import 'package:flutter/material.dart';
import 'package:treninoo/utils/utils.dart';

class StationTrain {
  final String trainCode;
  final String departureCode;
  final String? category;
  final String? name;
  final TimeOfDay? time;
  final String? plannedRail;
  final String? actualRail;
  final int? delay;

  StationTrain({
    required this.trainCode,
    required this.departureCode,
    this.category,
    this.name,
    this.time,
    this.plannedRail,
    this.actualRail,
    this.delay,
  });

  factory StationTrain.fromJson(Map<String, dynamic> json) {
    // Resolve a possible weird time in API
    TimeOfDay? time;
    if (json['time'] != null) {
      try {
        time = Utils.timestampToTimeOfDay(json['time']);
      } catch (e) {
        time = null;
      }
    }

    return StationTrain(
      trainCode: json['trainCode'],
      departureCode: json['departureCode'],
      category: json['category'],
      name: json['stationName'],
      time: time,
      plannedRail: json['plannedPlatform'],
      actualRail: json['actualPlatform'],
      delay: json['ritardo'],
    );
  }
}
