import 'package:intl/intl.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/repository/train.dart';

class SolutionsInfo {
  Station departureStation;
  Station arrivalStation;
  DateTime fromTime;
  TrainType trainType;

  SolutionsInfo({
    required this.departureStation,
    required this.arrivalStation,
    required this.fromTime,
    required this.trainType,
  });

  Map<String, dynamic> toJson() {
    return {
      'departureStation': departureStation.stationCode,
      'arrivalStation': arrivalStation.stationCode,
      'date': DateFormat('yyyy-MM-dd HH:mm').format(fromTime),
      ...trainType.toJson(),
    };
  }
}
