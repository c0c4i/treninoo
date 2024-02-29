import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/model/Stop.dart';

import '../utils/utils.dart';

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
  });

  factory TrainInfo.fromJson(Map<String, dynamic> json) {
    json = json['status'];
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
    );
  }

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
