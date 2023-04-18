import 'package:equatable/equatable.dart';
import 'package:treninoo/model/DepartureStation.dart';
import 'package:treninoo/model/StationTrain.dart';
import 'package:treninoo/model/TrainInfo.dart';

class SavedTrain extends Equatable {
  final String trainCode;
  final String trainType;
  final String departureStationCode;
  final String departureStationName;
  final String arrivalStationName;
  final String departureTime;
  final String description;

  SavedTrain({
    this.trainCode,
    this.trainType,
    this.departureStationCode,
    this.departureStationName,
    this.arrivalStationName,
    this.departureTime,
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
      departureStationCode: trainInfo.departureStationCode,
      departureStationName: trainInfo.departureStationName,
      arrivalStationName: trainInfo.arrivalStationName,
      departureTime: trainInfo.departureTime,
    );
  }

  factory SavedTrain.fromDepartureStation(DepartureStation departureStation) {
    return SavedTrain(
      trainCode: departureStation.trainCode,
      departureStationCode: departureStation.station.stationCode,
    );
  }

  factory SavedTrain.fromStationTrain(StationTrain stationTrain) {
    return SavedTrain(
      trainCode: stationTrain.trainCode,
      departureStationCode: stationTrain.departureCode,
    );
  }

  @override
  List<Object> get props {
    return [trainCode, departureStationCode];
  }
}
