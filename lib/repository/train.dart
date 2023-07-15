import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/model/Solutions.dart';
import 'package:treninoo/model/SolutionsInfo.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/model/StationTrain.dart';
import 'package:treninoo/model/TrainInfo.dart';
import 'package:treninoo/utils/endpoint.dart';

import '../exceptions/more_than_one.dart';

abstract class TrainRepository {
  Future<List<Station>> getDepartureStation(String trainCode);
  Future<Solutions> getSolutions(SolutionsInfo? solutionsInfo);
  Future<TrainInfo> getTrainStatus(SavedTrain? savedTrain);
  Future<bool> trainExist(SavedTrain savedTrain);
  Future<List<StationTrain>> getArrivalTrains(Station? station);
  Future<List<StationTrain>> getDepartureTrains(Station? station);
  Future<List<Station>> getFollowTrainStations(SavedTrain? savedTrain);
  Future<void> sendFeedback(String feedback);
  Future<List<Station>> searchStations(String text);
}

class APITrain extends TrainRepository {
  // Call super constructor
  APITrain() : super();

  @override
  Future<List<Station>> getDepartureStation(String? trainCode) async {
    var uri = Uri.https(BASE_URL, "${Endpoint.DEPARTURE_STATION}/$trainCode");
    var response = await http.get(uri);

    if (response.statusCode != 200) throw Exception("Something went wrong");

    var body = jsonDecode(response.body);

    if (body["total"] == 0) return [];

    return (body['stations'] as List)
        .map((station) => Station.fromJson(station))
        .toList();
  }

  @override
  Future<TrainInfo> getTrainStatus(SavedTrain? savedTrain) async {
    String? stationCode = savedTrain!.departureStationCode;
    String? trainCode = savedTrain.trainCode;

    // If station code is null, get it from the train code
    if (stationCode == null) {
      List<Station> departureStations =
          await getDepartureStation(savedTrain.trainCode);

      if (departureStations.length == 0) throw Exception("No station found");
      if (departureStations.length > 1)
        throw MoreThanOneException(savedTrain, departureStations);

      stationCode = departureStations.first.stationCode;
    }

    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    String timestamp = date.millisecondsSinceEpoch.toString();

    var uri = Uri.https(URL,
        "${ViaggioTreno.GET_TRAIN_INFO}$stationCode/$trainCode/$timestamp");

    var response = await http.get(uri);

    if (response.body.isEmpty) throw Exception("No train found");

    var body = jsonDecode(response.body);

    return TrainInfo.fromJson(body);
  }

  Future<Solutions> getSolutions(SolutionsInfo? solutionsInfo) async {
    String departureCode =
        solutionsInfo!.departureStation!.stationCode!.replaceAll("S0", "");
    String arrivalCode =
        solutionsInfo.arrivalStation!.stationCode!.replaceAll("S0", "");
    String time = solutionsInfo.fromTime!.toIso8601String();

    String url =
        "${ViaggioTreno.GET_SOLUTIONS}$departureCode/$arrivalCode/$time";
    var uri = Uri.https(URL, url);
    var response = await http.get(uri);

    var body = jsonDecode(response.body);

    Solutions solutions = Solutions.fromJson(body);
    solutions.departureStation = solutionsInfo.departureStation;
    solutions.arrivalStation = solutionsInfo.arrivalStation;
    solutions.fromTime = solutionsInfo.fromTime;
    return solutions;
  }

  @override
  Future<bool> trainExist(SavedTrain savedTrain) async {
    String? stationCode = savedTrain.departureStationCode;
    String? trainCode = savedTrain.trainCode;

    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    String timestamp = date.millisecondsSinceEpoch.toString();

    var uri = Uri.https(URL,
        "${ViaggioTreno.GET_TRAIN_INFO}$stationCode/$trainCode/$timestamp");
    var response = await http.get(uri);

    return response.body.isNotEmpty;
  }

  @override
  Future<List<StationTrain>> getArrivalTrains(Station? station) async {
    String url =
        "${ViaggioTreno.GET_ARRIVAL_TRAINS}${station!.stationCode}/" + getDate();

    var uri = Uri.https(URL, url);
    var response = await http.get(uri);
    var body = jsonDecode(response.body);

    // fake response for testing at 12 PM
    // var response = await readJson("arrivi_milano");
    // var body = jsonDecode(response);

    List<StationTrain> trains =
        (body as List).map((f) => StationTrain.fromJson(f, false)).toList();

    return trains;
  }

  @override
  Future<List<StationTrain>> getDepartureTrains(Station? station) async {
    String url = "${ViaggioTreno.GET_DEPARTURE_TRAINS}${station!.stationCode}/" +
        getDate();

    var uri = Uri.https(URL, url);
    var response = await http.get(uri);
    var body = jsonDecode(response.body);

    // fake response for testing at 12 PM
    // var response = await readJson("partenze_milano");
    // var body = jsonDecode(response);

    List<StationTrain> trains =
        (body as List).map((f) => StationTrain.fromJson(f, true)).toList();

    return trains;
  }

  @override
  Future<List<Station>> getFollowTrainStations(SavedTrain? savedTrain) async {
    String url =
        "${Endpoint.FOLLOWTRAIN_STATIONS}/${savedTrain!.departureStationCode}/${savedTrain.trainCode}";

    print(url);
    var uri = Uri.https(BASE_URL, url);
    var response = await http.get(uri);
    var body = jsonDecode(response.body)['stations'];

    List<Station> stations =
        (body as List).map((station) => Station.fromJson(station)).toList();

    return stations;
  }

  String getDate() {
    DateTime now = DateTime.now();
    String formattedDate =
        DateFormat('EEE MMM dd yyyy HH:mm:00').format(now) + " GMT+0200";

    return formattedDate;
  }

  @override
  Future<void> sendFeedback(String feedback) async {
    var uri = Uri.https(BASE_URL, Endpoint.FEEDBACK);
    http.Response response = await http.post(
      uri,
      body: {'feedback': feedback},
    );

    if (response.statusCode != 200) throw Exception();
  }

  Future<List<Station>> searchStations(String text) async {
    var uri = Uri.http(BASE_URL, Endpoint.AUTOCOMPLETE + text);
    var response = await http.get(uri);
    var body = jsonDecode(response.body);

    List<Station> stations = [];
    for (var station in body['stations']) {
      stations.add(Station.fromJson(station));
    }

    return stations;
  }
}
