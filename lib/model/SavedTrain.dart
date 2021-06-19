import 'package:equatable/equatable.dart';
import 'package:treninoo/model/DepartureStation.dart';
import 'package:treninoo/model/TrainInfo.dart';

class SavedTrain extends Equatable {
  final String trainCode;
  final String trainType;
  final String departureStationCode;
  final String departureStationName;
  final String arrivalStationName;
  final String departureTime;

  SavedTrain({
    this.trainCode,
    this.trainType,
    this.departureStationCode,
    this.departureStationName,
    this.arrivalStationName,
    this.departureTime,
  });

  Map<String, dynamic> toJson() => {
        'trainCode': trainCode,
        'trainType': trainType,
        'departureStationCode': departureStationCode,
        'departureStationName': departureStationName,
        'arrivalStationName': arrivalStationName,
        'departureTime': departureTime,
      };

  factory SavedTrain.fromJson(Map<String, dynamic> json) {
    return SavedTrain(
      trainCode: json['trainCode'],
      trainType: json['trainType'],
      departureStationCode: json['departureStationCode'],
      departureStationName: json['departureStationName'],
      arrivalStationName: json['arrivalStationName'],
      departureTime: json['departureTime'],
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

  @override
  List<Object> get props {
    return [trainCode, departureStationCode];
  }
}
