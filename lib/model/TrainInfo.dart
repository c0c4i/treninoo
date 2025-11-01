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

  static Status fromString(String? status) {
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
        return REGULAR;
    }
  }
}

class TrainInfo extends Equatable {
  final String trainType;
  final String trainCode;
  final TimeOfDay? lastTimeRegister;
  final String? lastPositionRegister;
  final bool isDeparted;
  final Station departureStation;
  final String arrivalStationName;
  final String departureTime;
  final int? delay;
  final List<Stop>? stops;
  final DateTime? departureDate;
  final Status status;
  final String? warning;
  final bool isCached;

  TrainInfo({
    required this.trainType,
    required this.trainCode,
    this.lastTimeRegister,
    this.lastPositionRegister,
    required this.isDeparted,
    required this.departureStation,
    required this.arrivalStationName,
    required this.departureTime,
    this.delay,
    this.stops,
    this.departureDate,
    this.status = Status.REGULAR,
    this.warning,
    this.isCached = false,
  });

  factory TrainInfo.fromJson(Map<String, dynamic> json) {
    json = json['status'];

    Status status = Status.fromString(json['status']);
    return TrainInfo(
      trainType: json['trainType'],
      trainCode: json['trainCode'].toString(),
      lastTimeRegister: Utils.timestampToTimeOfDay(json['lastDetectionTime']),
      lastPositionRegister: json['lastDetectionStation'],
      isDeparted: json['isDeparted'] ?? false,
      departureStation: Station.fromJson(json['departureStation']),
      arrivalStationName: json['arrivalStationName'],
      departureTime: json['firstDepartureTime'],
      delay: json['delay'],
      stops: (json['stops'] as List).map((f) => Stop.fromJson(f)).toList(),
      status: status,
      warning: json['warning'],
      isCached: json['isCached'] ?? false,
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
      isDeparted: isDeparted,
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

  Stop? findStopByStationCode(String stationCode) {
    for (Stop stop in stops!) {
      if (stop.station.stationCode == stationCode) {
        return stop;
      }
    }
    return null;
  }

  bool get completed => lastPositionRegister == arrivalStationName;

  bool get haveWarning =>
      status == Status.PARTIALLY_SUPPRESSED && warning != null;

  bool get isSuppressed => status == Status.SUPPRESSED;

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
        departureDate,
        status,
        warning,
        isCached,
      ];
}

enum TrainInfoDifference {
  status,
  stops,
}
