import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/model/Stop.dart';

import '../utils/utils.dart';

enum Status {
  REGULAR,
  SUPPRESSED,
  PARTIALLY_SUPPRESSED,
  DEVIATED;

  static Status fromString(String status) {
    switch (status) {
      case 'REGULAR':
        return REGULAR;
      case 'SUPPRESSED':
        return SUPPRESSED;
      case 'PARTIALLY_SUPPRESSED':
        return PARTIALLY_SUPPRESSED;
      case 'DEVIATED':
        return DEVIATED;
      default:
        throw Exception('Unknown status: $status');
    }
  }
}

class TrainInfo extends Equatable {
  final String trainType;
  final String trainCode;
  final TimeOfDay? lastTimeRegister;
  final String? lastPositionRegister;
  final Station departureStation;
  final String arrivalStationName;
  final String departureTime;
  final int? delay;
  final List<Stop>? stops;
  final DateTime? departureDate;
  final Status status;
  final String? warning;

  TrainInfo({
    required this.trainType,
    required this.trainCode,
    this.lastTimeRegister,
    this.lastPositionRegister,
    required this.departureStation,
    required this.arrivalStationName,
    required this.departureTime,
    this.delay,
    this.stops,
    this.departureDate,
    this.status = Status.REGULAR,
    this.warning,
  });

  factory TrainInfo.fromJson(Map<String, dynamic> json) {
    json = json['status'];

    Status status = Status.fromString(json['status']);
    return TrainInfo(
      trainType: json['trainType'],
      trainCode: json['trainCode'].toString(),
      lastTimeRegister: Utils.timestampToTimeOfDay(json['lastDetectionTime']),
      lastPositionRegister: json['lastDetectionStation'],
      departureStation: Station.fromJson(json['departureStation']),
      arrivalStationName: json['arrivalStationName'],
      departureTime: json['firstDepartureTime'],
      delay: json['delay'],
      stops: (json['stops'] as List).map((f) => Stop.fromJson(f)).toList(),
      status: status,
      warning: json['warning'],
    );
  }

  List<TrainInfoDifference> compareWith(TrainInfo other) {
    List<TrainInfoDifference> differences = [];

    if (lastTimeRegister != other.lastTimeRegister ||
        lastPositionRegister != other.lastPositionRegister ||
        delay != other.delay) {
      differences.add(TrainInfoDifference.status);
    }

    if (!listEquals(stops, other.stops)) {
      differences.add(TrainInfoDifference.stops);
    }

    return differences;
  }

  TrainInfo addDepartureDate(DateTime departureDate) {
    return TrainInfo(
      trainType: trainType,
      trainCode: trainCode,
      lastTimeRegister: lastTimeRegister,
      lastPositionRegister: lastPositionRegister,
      departureStation: departureStation,
      arrivalStationName: arrivalStationName,
      departureTime: departureTime,
      delay: delay,
      stops: stops,
      departureDate: departureDate,
      status: status,
      warning: warning,
    );
  }

  bool get isDeparted => lastPositionRegister != '--';

  bool get completed => lastPositionRegister == arrivalStationName;

  bool get haveWarning =>
      status == Status.PARTIALLY_SUPPRESSED && warning != null;

  @override
  List<Object?> get props => [
        trainType,
        trainCode,
        lastTimeRegister,
        lastPositionRegister,
        departureStation,
        arrivalStationName,
        departureTime,
        delay,
        stops,
      ];
}

enum TrainInfoDifference {
  status,
  stops,
}
