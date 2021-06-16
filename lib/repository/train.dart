import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:treninoo/model/DepartureStation.dart';
import 'package:treninoo/model/Solutions.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/utils/endpoint.dart';

abstract class TrainRepository {
  Future<List<DepartureStation>> getDepartureStation(String trainCode);
  // Future<Solutions> getSolutions(
  //     Station departureStation, Station arrivalStation, DateTime time);
  // Future<TrainInfo> getTrainStatus(DepartureStation details);
  // Future<List<Station>> getStationAutocomplete(String text);
}

class APITrain extends TrainRepository {
  @override
  Future<List<DepartureStation>> getDepartureStation(String trainCode) async {
    await Future.delayed(Duration(seconds: 10));
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

  // @override
  // Future<TrainInfo> getTrainStatus(DepartureStation details) async {
  //   var uri = Uri.https(URL,
  //       "$GET_TRAIN_INFO${details.station.stationCode}/${details.trainCode}/${details.random}");
  //   var response = await http.get(uri);

  //   var body = jsonDecode(response.body);

  //   return TrainInfo.fromJson(body);
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

  // Future<Solutions> getSolutions(
  //     Station departureStation, Station arrivalStation, DateTime time) async {
  //   String url =
  //       "$GET_SOLUTIONS${departureStation.stationCode}/${arrivalStation.stationCode}/${time.toIso8601String()}";

  //   var uri = Uri.https(URL, url);
  //   var response = await http.get(uri);

  //   var body = jsonDecode(response.body);

  //   return Solutions.fromJson(body, departureStation, arrivalStation, time);
  // }
}
