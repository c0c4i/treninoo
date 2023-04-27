import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:treninoo/model/DepartureStation.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/model/Solutions.dart';
import 'package:treninoo/model/SolutionsInfo.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/model/StationTrain.dart';
import 'package:treninoo/model/TrainInfo.dart';
import 'package:treninoo/utils/endpoint.dart';
import 'package:treninoo/utils/shared_preference.dart';

abstract class TrainRepository {
  Future<List<DepartureStation>> getDepartureStation(String trainCode);
  Future<Solutions> getSolutions(SolutionsInfo solutionsInfo);
  Future<TrainInfo> getTrainStatus(SavedTrain savedTrain);
  Future<bool> trainExist(SavedTrain savedTrain);
  Future<List<StationTrain>> getArrivalTrains(String stationCode);
  Future<List<StationTrain>> getDepartureTrains(String stationCode);
  Future<List<Station>> getFollowTrainStations(
      DepartureStation departureStation);
  void changeDescription(SavedTrain savedTrain);
  List<SavedTrain> getSavedTrain(SavedTrainType savedTrainType);
}

class APITrain extends TrainRepository {
  @override
  Future<List<DepartureStation>> getDepartureStation(String trainCode) async {
    var uri = Uri.http(URL, GET_STATION_CODE + trainCode);
    var response = await http.get(uri);

    var lines = response.body.split("\n");
    List<DepartureStation> stations = [];

    if (lines.length == 0) return null;

    for (int i = 0; i < lines.length - 1; i++) {
      stations.add(DepartureStation.fromJson(lines[i]));
    }

    return stations;
  }

  @override
  Future<TrainInfo> getTrainStatus(SavedTrain savedTrain) async {
    String stationCode = savedTrain.departureStationCode;
    String trainCode = savedTrain.trainCode;

    if (stationCode == null) {
      stationCode = await getStationCode(savedTrain.trainCode);
      if (stationCode == null) return null;
    }

    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    String timestamp = date.millisecondsSinceEpoch.toString();

    var uri =
        Uri.https(URL, "$GET_TRAIN_INFO$stationCode/$trainCode/$timestamp");
    print(uri.host + uri.path);
    var response = await http.get(uri);

    var body = jsonDecode(response.body);

    return TrainInfo.fromJson(body);
  }

  // @override
  // List<SavedTrain> getSavedTrain(SavedTrainType savedTrainType) {
  //   SharedPreferencesUtils().
  //   return getSavedTrain(savedTrainType);
  // }

  // @override
  // Future<List<Station>> getStationAutocomplete(String text) async {
  //   List<Station> stationList = [];

  //   var uri = Uri.https(URL, GET_STATION_NAME + text);
  //   var response = await http.get(uri);

  //   var lines = response.body.split('\n');

  //   for (var i = 0; i < lines.length - 1; i++) {
  //     stationList.add(Station.fromBody(lines[i]));
  //   }

  //   return stationList;
  // }

  Future<Solutions> getSolutions(SolutionsInfo solutionsInfo) async {
    String departureCode =
        solutionsInfo.departureStation.stationCode.replaceAll("S0", "");
    String arrivalCode =
        solutionsInfo.arrivalStation.stationCode.replaceAll("S0", "");
    String time = solutionsInfo.fromTime.toIso8601String();

    String url = "$GET_SOLUTIONS$departureCode/$arrivalCode/$time";
    var uri = Uri.https(URL, url);
    var response = await http.get(uri);

    var body = jsonDecode(response.body);

    Solutions solutions = Solutions.fromJson(body);
    solutions.departureStation = solutionsInfo.departureStation;
    solutions.arrivalStation = solutionsInfo.arrivalStation;
    solutions.fromTime = solutionsInfo.fromTime;
    return solutions;
  }

  Future<String> getStationCode(String trainCode) async {
    String url = GET_STATION_CODE + trainCode;
    var uri = Uri.https(URL, url);
    Response response = await http.get(uri);

    if (response.body.isEmpty) return null;

    String stationCode = response.body.split("|")[1].split("-")[1];

    return stationCode;
  }

  @override
  Future<bool> trainExist(SavedTrain savedTrain) async {
    String stationCode = savedTrain.departureStationCode;
    String trainCode = savedTrain.trainCode;

    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    String timestamp = date.millisecondsSinceEpoch.toString();

    var uri =
        Uri.https(URL, "$GET_TRAIN_INFO$stationCode/$trainCode/$timestamp");
    var response = await http.get(uri);

    return response.body.isNotEmpty;
  }

  @override
  Future<List<StationTrain>> getArrivalTrains(String stationCode) async {
    String url = "$GET_ARRIVAL_TRAINS$stationCode/" + getDate();

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
  Future<List<StationTrain>> getDepartureTrains(String stationCode) async {
    String url = "$GET_DEPARTURE_TRAINS$stationCode/" + getDate();

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
  Future<List<Station>> getFollowTrainStations(
      DepartureStation departureStation) async {
    String url =
        "${Endpoint.FOLLOWTRAIN_STATIONS}/${departureStation.station.stationCode}/${departureStation.trainCode}";

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
  void changeDescription(SavedTrain savedTrain) {
    List<dynamic> trains = jsonDecode(sharedPrefs.favouritesTrains);
    List<SavedTrain> savedTrains =
        trains.map((e) => SavedTrain.fromJson(e)).toList();

    int index = savedTrains.indexWhere((element) => element == savedTrain);
    savedTrains[index] = savedTrain;

    sharedPrefs.favouritesTrains = jsonEncode(savedTrains);
  }

  @override
  List<SavedTrain> getSavedTrain(SavedTrainType savedTrainType) {
    String raw;
    switch (savedTrainType) {
      case SavedTrainType.favourites:
        raw = sharedPrefs.favouritesTrains;
        break;
      case SavedTrainType.recents:
        raw = sharedPrefs.recentsTrains;
        break;
    }

    if (raw == null) return [];

    List<dynamic> trains = jsonDecode(raw);

    List<SavedTrain> savedTrains =
        trains.map((e) => SavedTrain.fromJson(e)).toList();

    return savedTrains;
  }
}

enum SavedTrainType {
  recents,
  favourites,
}
