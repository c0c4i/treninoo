import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:treninoo/model/DepartureStation.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/model/Solutions.dart';
import 'package:treninoo/model/SolutionsInfo.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/model/TrainInfo.dart';
import 'package:treninoo/utils/endpoint.dart';
import 'package:treninoo/utils/shared_preference.dart';
import 'package:treninoo/utils/shared_preference_methods.dart';
import 'package:treninoo/utils/utils.dart';

abstract class TrainRepository {
  Future<List<DepartureStation>> getDepartureStation(String trainCode);
  Future<Solutions> getSolutions(SolutionsInfo solutionsInfo);
  Future<TrainInfo> getTrainStatus(SavedTrain savedTrain);
  // List<SavedTrain> getSavedTrain(SavedTrainType savedTrainType);
  // Future<List<Station>> getStationAutocomplete(String text);
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

    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    String timestamp = date.millisecondsSinceEpoch.toString();

    var uri =
        Uri.https(URL, "$GET_TRAIN_INFO$stationCode/$trainCode/$timestamp");
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
    String departureCode = solutionsInfo.departureStation.stationCode;
    String arrivalCode = solutionsInfo.arrivalStation.stationCode;
    String time = solutionsInfo.fromTime.toIso8601String();

    String url = "$GET_SOLUTIONS$departureCode/$arrivalCode/$time";
    print(url);
    var uri = Uri.https(URL, url);
    var response = await http.get(uri);

    var body = jsonDecode(response.body);

    Solutions solutions = Solutions.fromJson(body);
    solutions.departureStation = solutionsInfo.departureStation;
    solutions.arrivalStation = solutionsInfo.arrivalStation;
    solutions.fromTime = solutionsInfo.fromTime;
    return solutions;
  }
}

enum SavedTrainType {
  recents,
  favourites,
}
