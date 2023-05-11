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
  SharedPrefs sharedPrefs;

  // Define a constructor for shared preference
  TrainRepository() {
    sharedPrefs = SharedPrefs();
    sharedPrefs.setup();
  }

  setup() async {
    await sharedPrefs.setup();
  }

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
  Future<void> sendFeedback(String feedback);
  Future<List<Station>> searchStations(String text);

  // Shared Preference methods
  void saveTrain(SavedTrain savedTrain, SavedTrainType savedTrainType);
  void removeTrain(SavedTrain savedTrain, SavedTrainType savedTrainType);
  bool isFavourite(SavedTrain savedTrain);
  List<Station> getRecentsStations();
  void addRecentStation(Station station);
}

class APITrain extends TrainRepository {
  // Call super constructor
  APITrain() : super();

  @override
  Future<List<DepartureStation>> getDepartureStation(String trainCode) async {
    var uri = Uri.http(URL, "${ViaggioTreno.GET_STATION_CODE}$trainCode");
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

    // If station code is null, get it from the train code
    if (stationCode == null && savedTrain.departureStationName != null) {
      stationCode = await _getDepartureStationCodeFromName(savedTrain);
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

  _getDepartureStationCodeFromName(savedTrain) async {
    List<DepartureStation> departureStations =
        await getDepartureStation(savedTrain.trainCode);

    if (departureStations == null) throw Exception("No station found");

    for (var departureStation in departureStations) {
      String stationName = departureStation.station.stationName.toLowerCase();
      if (stationName == savedTrain.departureStationName.toLowerCase()) {
        return departureStation.station.stationCode;
      }
    }
    throw Exception("No station found");
  }

  Future<Solutions> getSolutions(SolutionsInfo solutionsInfo) async {
    String departureCode =
        solutionsInfo.departureStation.stationCode.replaceAll("S0", "");
    String arrivalCode =
        solutionsInfo.arrivalStation.stationCode.replaceAll("S0", "");
    String time = solutionsInfo.fromTime.toIso8601String();

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
    String stationCode = savedTrain.departureStationCode;
    String trainCode = savedTrain.trainCode;

    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    String timestamp = date.millisecondsSinceEpoch.toString();

    var uri = Uri.https(URL,
        "${ViaggioTreno.GET_TRAIN_INFO}$stationCode/$trainCode/$timestamp");
    var response = await http.get(uri);

    return response.body.isNotEmpty;
  }

  @override
  Future<List<StationTrain>> getArrivalTrains(String stationCode) async {
    String url = "${ViaggioTreno.GET_ARRIVAL_TRAINS}$stationCode/" + getDate();

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
    String url =
        "${ViaggioTreno.GET_DEPARTURE_TRAINS}$stationCode/" + getDate();

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

  @override
  Future<void> sendFeedback(String feedback) async {
    var uri = Uri.https(BASE_URL, Endpoint.FEEDBACK);
    Response response = await http.post(
      uri,
      body: {'feedback': feedback},
    );

    if (response.statusCode != 200) throw Exception();
  }

  @override
  List<Station> getRecentsStations() {
    String raw = sharedPrefs.recentsStations;
    if (raw == null) return [];
    List<dynamic> rawStations = jsonDecode(raw);
    return rawStations.map((e) => Station.fromJson(e)).toList();
  }

  @override
  void saveTrain(SavedTrain savedTrain, SavedTrainType savedTrainType) {
    // Get saved trains from shared preference
    List<SavedTrain> savedTrains = getSavedTrain(savedTrainType);

    // If train is in the list, remove it
    if (savedTrains.contains(savedTrain)) {
      savedTrains.remove(savedTrain);
    }

    // Add train on top of the list
    savedTrains.insert(0, savedTrain);

    // Set saved trains to shared preference
    _setSavedTrain(savedTrainType, savedTrains);
  }

  @override
  void removeTrain(SavedTrain savedTrain, SavedTrainType savedTrainType) {
    // Get saved trains from shared preference
    List<SavedTrain> savedTrains = getSavedTrain(savedTrainType);

    // If train is in the list, remove it
    if (savedTrains.contains(savedTrain)) {
      savedTrains.remove(savedTrain);
    }

    // Set saved trains to shared preference
    _setSavedTrain(savedTrainType, savedTrains);
  }

  void _setSavedTrain(SavedTrainType savedTrainType, List<SavedTrain> trains) {
    // Modify list to only have 3 trains
    if (trains.length > 3 && savedTrainType == SavedTrainType.recents)
      trains.removeLast();

    String decodedTrains = jsonEncode(trains);
    switch (savedTrainType) {
      case SavedTrainType.favourites:
        sharedPrefs.favouritesTrains = decodedTrains;
        break;
      case SavedTrainType.recents:
        sharedPrefs.recentsTrains = decodedTrains;
        break;
    }
  }

  @override
  bool isFavourite(SavedTrain savedTrain) {
    List<SavedTrain> savedTrains = getSavedTrain(SavedTrainType.favourites);
    return savedTrains.contains(savedTrain);
  }

  void addRecentStation(Station station) {
    // Get saved trains from shared preference
    List<Station> stations = getRecentsStations();

    // If train is in the list, remove it
    if (stations.contains(station)) stations.remove(station);

    // Add train on top of the list
    stations.insert(0, station);

    // Modify list to only have 3 trains
    if (stations.length > 3) stations.removeLast();
    sharedPrefs.recentsStations = jsonEncode(stations);
  }

  Future<List<Station>> searchStations(String text) async {
    if (text.length == 0) return getRecentsStations();

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

enum SavedTrainType {
  recents,
  favourites,
}
