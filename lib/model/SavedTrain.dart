import 'package:equatable/equatable.dart';
import 'package:treninoo/model/StationTrain.dart';
import 'package:treninoo/model/TrainInfo.dart';

import 'Station.dart';

class SavedTrain extends Equatable {
  final String? trainType;
  final String trainCode;
  final String? departureStationCode;
  final String? departureStationName;
  final String? arrivalStationName;
  final String? departureTime;
  final String? description;

  SavedTrain({
    this.trainType,
    required this.trainCode,
    this.departureStationCode,
    this.departureStationName,
    this.departureTime,
    this.arrivalStationName,
    this.description,
  });

  Map<String, dynamic> toJson() => {
        'trainCode': trainCode,
        'trainType': trainType,
        'departureStationCode': departureStationCode,
        'departureStationName': departureStationName,
        'arrivalStationName': arrivalStationName,
        'departureTime': departureTime,
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
      description: json['description'],
    );
  }

  factory SavedTrain.fromTrainInfo(TrainInfo trainInfo) {
    return SavedTrain(
      trainCode: trainInfo.trainCode,
      trainType: trainInfo.trainType,
      departureStationCode: trainInfo.departureStation.stationCode,
      departureStationName: trainInfo.departureStation.stationName,
      arrivalStationName: trainInfo.arrivalStationName,
      departureTime: trainInfo.departureTime,
    );
  }

  factory SavedTrain.fromDepartureStation(
    SavedTrain savedTrain,
    Station departureStation,
  ) {
    return SavedTrain(
      trainCode: savedTrain.trainCode,
      departureStationCode: departureStation.stationCode,
    );
  }

  factory SavedTrain.fromStationTrain(StationTrain stationTrain) {
    return SavedTrain(
      trainCode: stationTrain.trainCode,
      departureStationCode: stationTrain.departureCode,
    );
  }

  SavedTrain copyWith({
    String? description,
  }) {
    return SavedTrain(
      trainCode: this.trainCode,
      trainType: this.trainType,
      departureStationCode: this.departureStationCode,
      departureStationName: this.departureStationName,
      arrivalStationName: this.arrivalStationName,
      departureTime: this.departureTime,
      description: description,
    );
  }

  String? get trainName {
    if (trainType == null) return trainCode;
    return '$trainType $trainCode';
  }

  @override
  List<Object?> get props {
    return [trainCode, departureStationCode];
  }
}
