import 'package:equatable/equatable.dart';
import 'package:treninoo/model/StationTrain.dart';
import 'package:treninoo/model/TrainInfo.dart';
import 'package:treninoo/model/TrainSolution.dart';
import 'package:treninoo/utils/core.dart';

import 'Station.dart';

class SavedTrain extends Equatable {
  final String? trainType;
  final String trainCode;
  final String? departureStationCode;
  final String? departureStationName;
  final String? arrivalStationName;
  final String? departureTime;
  final String? arrivalTime;
  final String? description;
  final DateTime? departureDate;

  SavedTrain({
    this.trainType,
    required this.trainCode,
    this.departureStationCode,
    this.departureStationName,
    this.departureTime,
    this.arrivalStationName,
    this.arrivalTime,
    this.description,
    this.departureDate,
  });

  Map<String, dynamic> toJson() => {
        'trainCode': trainCode,
        'trainType': trainType,
        'departureStationCode': departureStationCode,
        'departureStationName': departureStationName,
        'arrivalStationName': arrivalStationName,
        'departureTime': departureTime,
        'arrivalTime': arrivalTime,
        'description': description,
      };

  factory SavedTrain.fromJson(Map<String, dynamic> json) {
    return SavedTrain(
      trainCode: json['trainCode'],
      trainType: json['trainType'],
      departureStationCode: json['departureStationCode'],
      departureStationName: json['departureStationName'],
      arrivalStationName: json['arrivalStationName'],
      departureTime: json['departureTime'],
      arrivalTime: json['arrivalTime'],
      description: json['description'],
    );
  }

  factory SavedTrain.fromTrainInfo(TrainInfo trainInfo) {
    bool hasStops = trainInfo.stops != null && trainInfo.stops!.isNotEmpty;

    String? arrivalTime;
    if (hasStops && trainInfo.stops!.last.plannedArrivalTime != null) {
      arrivalTime = formatTimeOfDay(
        trainInfo.stops!.last.plannedArrivalTime!,
      );
    }

    return SavedTrain(
      trainCode: trainInfo.trainCode,
      trainType: trainInfo.trainType,
      departureStationCode: trainInfo.departureStation.stationCode,
      departureStationName: trainInfo.departureStation.stationName,
      arrivalStationName: trainInfo.arrivalStationName,
      departureTime: trainInfo.departureTime,
      arrivalTime: arrivalTime,
      departureDate: trainInfo.departureDate,
    );
  }

  factory SavedTrain.fromDepartureStation(
    SavedTrain savedTrain,
    Station departureStation,
  ) {
    return SavedTrain(
      trainCode: savedTrain.trainCode,
      departureStationCode: departureStation.stationCode,
      departureDate: departureStation.departureDate,
    );
  }

  factory SavedTrain.fromStationTrain(StationTrain stationTrain) {
    return SavedTrain(
      trainCode: stationTrain.trainCode,
      departureStationCode: stationTrain.departureCode,
    );
  }

  factory SavedTrain.fromSolution(TrainSolution trainSolution) {
    return SavedTrain(
      trainCode: trainSolution.trainCode!,
      departureStationName: trainSolution.origin,
    );
  }

  factory SavedTrain.fromNewsUrl(String url) {
    // Get params treno, origine and datapartenza, open the train page
    Uri uri = Uri.parse(url);
    String? trainCode = uri.queryParameters['treno'];
    String? departureStationCode = uri.queryParameters['origine'];
    String? departureDate = uri.queryParameters['datapartenza'];

    return SavedTrain(
      trainCode: trainCode ?? '',
      departureStationCode: departureStationCode ?? '',
      departureDate: DateTime.tryParse(departureDate ?? ''),
    );
  }

  SavedTrain copyWith({
    String? description,
    DateTime? departureDate,
  }) {
    return SavedTrain(
      trainCode: this.trainCode,
      trainType: this.trainType,
      departureStationCode: this.departureStationCode,
      departureStationName: this.departureStationName,
      arrivalStationName: this.arrivalStationName,
      departureTime: this.departureTime,
      description: description ?? this.description,
      departureDate: departureDate ?? this.departureDate,
    );
  }

  String? get trainName {
    if (trainType == null) return trainCode;
    return '$trainType $trainCode';
  }

  bool get showTimeCard => arrivalTime != null && departureTime != null;

  @override
  List<Object?> get props {
    return [trainCode, departureStationCode];
  }
}
