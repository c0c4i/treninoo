import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/model/Solutions.dart';
import 'package:treninoo/model/SolutionsInfo.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/model/StationTrain.dart';
import 'package:treninoo/model/TrainInfo.dart';
import 'package:treninoo/utils/endpoint.dart';

import '../exceptions/more_than_one.dart';
import '../exceptions/no_station.dart';

abstract class TrainRepository {
  final dio = Dio();

  TrainRepository() {
    dio.options.baseUrl = BASE_URL;
    dio.httpClientAdapter = NativeAdapter();
  }

  Future<List<Station>> getDepartureStation(String trainCode);
  Future<Solutions> getSolutions(SolutionsInfo solutionsInfo);
  Future<TrainInfo> getTrainStatus(SavedTrain savedTrain);
  Future<List<StationTrain>> getStationDetails(
      Station station, StationDetailsType type);
  Future<List<Station>> getFollowTrainStations(SavedTrain? savedTrain);
  Future<void> sendFeedback(String feedback, String? email);
  Future<List<Station>> searchStations(String text, SearchStationType type);
}

class APITrain extends TrainRepository {
  // Call super constructor
  APITrain() : super();

  @override
  Future<List<Station>> getDepartureStation(String? trainCode) async {
    String url = "${Endpoint.DEPARTURE_STATION}/$trainCode";
    Response response = await dio.get(url);

    if (response.statusCode != 200) throw Exception("Something went wrong");

    bool isItalo = response.data['is_italo'];

    if (response.data["total"] == 0 && !isItalo) return [];

    if (isItalo) return [Station.fakeItaloStation()];

    return (response.data['stations'] as List)
        .map((station) => Station.fromJson(station))
        .toList();
  }

  @override
  Future<TrainInfo> getTrainStatus(SavedTrain savedTrain) async {
    String? stationCode = savedTrain.departureStationCode;
    String trainCode = savedTrain.trainCode;

    // If station code is null, get it from the train code
    if (stationCode == null) {
      List<Station> departureStations =
          await getDepartureStation(savedTrain.trainCode);

      if (departureStations.length == 0) throw NoStationsException();

      if (departureStations.length > 1)
        throw MoreThanOneException(savedTrain, departureStations);

      stationCode = departureStations.first.stationCode;
    }

    String url = "${Endpoint.TRAIN_INFO_VIAGGIOTRENO}/$stationCode/$trainCode";
    Response response = await dio.get(url);

    return TrainInfo.fromJson(response.data);
  }

  Future<Solutions> getSolutions(SolutionsInfo solutionsInfo) async {
    Response response = await dio.get(
      Endpoint.SOLUTIONS_LEFRECCE,
      queryParameters: solutionsInfo.toJson(),
    );

    Solutions solutions = Solutions.fromJson(response.data);
    solutions.departureStation = solutionsInfo.departureStation;
    solutions.arrivalStation = solutionsInfo.arrivalStation;
    solutions.fromTime = solutionsInfo.fromTime;
    return solutions;
  }

  @override
  Future<List<StationTrain>> getStationDetails(
      Station station, StationDetailsType type) async {
    // Get last 5 letter of station code (es. 830002998 -> 02998)
    String stationCode =
        station.stationCode.substring(station.stationCode.length - 5);

    String url =
        "${Endpoint.STATION_DETAILS_VIAGGIOTRENO}/S$stationCode/${type.endpoint}";

    Response response = await dio.get(url);

    List<StationTrain> trains = (response.data['trains'] as List)
        .map((f) => StationTrain.fromJson(f))
        .toList();

    return trains;
  }

  @override
  Future<List<Station>> getFollowTrainStations(SavedTrain? savedTrain) async {
    String url =
        "${Endpoint.FOLLOWTRAIN_STATIONS}/${savedTrain!.departureStationCode}/${savedTrain.trainCode}";

    Response response = await dio.get(url);

    List<Station> stations = (response.data['stations'] as List)
        .map((station) => Station.fromJson(station))
        .toList();

    return stations;
  }

  String getDate() {
    DateTime now = DateTime.now();
    String formattedDate =
        DateFormat('EEE MMM dd yyyy HH:mm:00').format(now) + " GMT+0200";

    return formattedDate;
  }

  @override
  Future<void> sendFeedback(String feedback, String? email) async {
    Response response = await dio.post(
      Endpoint.FEEDBACK,
      data: {
        'feedback': feedback,
        'email': email,
      },
    );

    if (response.statusCode != 200) throw Exception();
  }

  Future<List<Station>> searchStations(
    String text,
    SearchStationType type,
  ) async {
    Response response = await dio.get(
      type.endpoint + text,
      queryParameters: type.params,
    );

    List<Station> stations = [];
    for (var station in response.data['stations']) {
      stations.add(Station.fromJson(station));
    }

    return stations;
  }
}

enum SearchStationType {
  VIAGGIO_TRENO,
  LEFRECCE_WITH_MULTISTATION,
  LEFRECCE;

  String get endpoint {
    switch (this) {
      case VIAGGIO_TRENO:
        return Endpoint.AUTOCOMPLETE_VIAGGIOTRENO;
      case LEFRECCE:
      case LEFRECCE_WITH_MULTISTATION:
        return Endpoint.AUTOCOMPLETE_LEFRECCE;
    }
  }

  // Return multitation = true if the type is LEFRECCE_WITH_MULTISTATION
  Map<String, dynamic> get params {
    switch (this) {
      case VIAGGIO_TRENO:
      case LEFRECCE:
        return {};
      case LEFRECCE_WITH_MULTISTATION:
        return {'multistation': true};
    }
  }
}

enum StationDetailsType {
  departure,
  arrival;

  String get endpoint {
    switch (this) {
      case departure:
        return 'departure';
      case arrival:
        return 'arrival';
    }
  }
}

enum TrainType {
  all,
  regional,
  highSpeed,
  intercity;

  String get label {
    switch (this) {
      case all:
        return "Tutti i treni";
      case regional:
        return "Regionali";
      case highSpeed:
        return "Frecce";
      case intercity:
        return "Intercity";
    }
  }

  Map<String, bool> toJson() {
    return {
      'onlyFrecce': this == highSpeed,
      'onlyIntercity': this == intercity,
      'onlyRegional': this == regional,
    };
  }
}
