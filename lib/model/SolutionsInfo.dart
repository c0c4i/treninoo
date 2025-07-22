import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/repository/train.dart';

const _LIMIT = 10;

class SolutionsInfo extends Equatable {
  final Station departureStation;
  final Station arrivalStation;
  final DateTime fromTime;
  final TrainType trainType;
  final bool noChanges;
  final int page;

  SolutionsInfo({
    required this.departureStation,
    required this.arrivalStation,
    required this.fromTime,
    required this.trainType,
    required this.noChanges,
    this.page = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'departureStation': departureStation.stationCode,
      'arrivalStation': arrivalStation.stationCode,
      'date': DateFormat('yyyy-MM-dd HH:mm').format(fromTime),
      'noChanges': noChanges,
      'offset': page * _LIMIT,
      'limit': _LIMIT,
      ...trainType.toJson(),
    };
  }

  SolutionsInfo previousPage() {
    DateTime previousTime = fromTime.subtract(Duration(minutes: 15));
    return SolutionsInfo(
      departureStation: departureStation,
      arrivalStation: arrivalStation,
      fromTime: previousTime,
      trainType: trainType,
      noChanges: noChanges,
      page: 0,
    );
  }

  SolutionsInfo nextPage() {
    return SolutionsInfo(
      departureStation: departureStation,
      arrivalStation: arrivalStation,
      fromTime: fromTime,
      trainType: trainType,
      noChanges: noChanges,
      page: page + 1,
    );
  }

  @override
  List<Object?> get props => [
        departureStation,
        arrivalStation,
        fromTime,
        trainType,
        noChanges,
        page,
      ];
}
