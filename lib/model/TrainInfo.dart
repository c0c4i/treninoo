import 'package:flutter/material.dart';
import 'package:treninoo/exceptions/status_not_available.dart';
import 'package:treninoo/model/Stop.dart';
import 'package:treninoo/utils/train_utils.dart';

import '../utils/utils.dart';

class TrainInfo {
  final List<Stop>? stops;
  final String? lastPositionRegister; // to converter from unix
  final TimeOfDay? lastTimeRegister;
  final String? trainType;
  final int? delay;
  final String? trainCode;

  String? departureStationCode;
  String? departureStationName;
  String? arrivalStationName;
  String? departureTime;

  TrainInfo({
    this.stops,
    this.lastPositionRegister,
    this.lastTimeRegister,
    this.trainType,
    this.delay,
    this.trainCode,
    this.departureStationCode,
    this.departureStationName,
    this.arrivalStationName,
    this.departureTime,
  });

  factory TrainInfo.fromJson(Map<String, dynamic> json) {
    if (json['fermate'].length == 0) {
      throw StatusNotAvailableException();
    }

    return TrainInfo(
      stops: (json['fermate'] as List).map((f) => Stop.fromJson(f)).toList(),
      lastPositionRegister: json['stazioneUltimoRilevamento'],
      lastTimeRegister:
          Utils.timestampToTimeOfDay(json['oraUltimoRilevamento']),
      trainType: TrainUtils.getCategory(json['compNumeroTreno']),
      delay: json['ritardo'],
      trainCode: json['numeroTreno'].toString(),
      departureStationCode: json['idOrigine'],
      departureStationName: json['origine'],
      arrivalStationName: json['destinazione'],
      departureTime: json['compOrarioPartenzaZero'],
    );
  }
}
