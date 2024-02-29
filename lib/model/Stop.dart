import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:treninoo/model/Station.dart';

import '../utils/utils.dart';

class Stop extends Equatable {
  final Station station;

  final TimeOfDay? plannedDepartureTime;
  final TimeOfDay? predictedDepartureTime;
  final TimeOfDay? actualDepartureTime;

  final TimeOfDay? plannedArrivalTime;
  final TimeOfDay? predictedArrivalTime;
  final TimeOfDay? actualArrivalTime;

  final String? plannedDepartureRail;
  final String? actualDepartureRail;
  final String? plannedArrivalRail;
  final String? actualArrivalRail;

  final bool confirmed;
  final bool currentStation;
  final int? delay;

  Stop({
    required this.station,
    this.plannedDepartureTime,
    this.predictedDepartureTime,
    this.actualDepartureTime,
    this.plannedArrivalTime,
    this.predictedArrivalTime,
    this.actualArrivalTime,
    this.plannedDepartureRail,
    this.actualDepartureRail,
    this.plannedArrivalRail,
    this.actualArrivalRail,
    this.confirmed = false,
    this.currentStation = false,
    this.delay,
  });

  factory Stop.fromJson(Map<String, dynamic> json) {
    return Stop(
      station: Station.fromJson(json['station']),
      plannedDepartureTime: Utils.timestampToTimeOfDay(
        json['plannedDepartureTime'],
      ),
      predictedDepartureTime: Utils.timestampToTimeOfDay(
        json['predictedDepartureTime'],
      ),
      actualDepartureTime: Utils.timestampToTimeOfDay(
        json['actualDepartureTime'],
      ),
      plannedArrivalTime: Utils.timestampToTimeOfDay(
        json['plannedArrivalTime'],
      ),
      predictedArrivalTime: Utils.timestampToTimeOfDay(
        json['predictedArrivalTime'],
      ),
      actualArrivalTime: Utils.timestampToTimeOfDay(
        json['actualArrivalTime'],
      ),
      plannedDepartureRail: json['plannedDepartureRail'],
      actualDepartureRail: json['actualDepartureRail'],
      plannedArrivalRail: json['plannedArrivalRail'],
      actualArrivalRail: json['actualArrivalRail'],
      confirmed: json['confirmed'],
      currentStation: json['currentStation'],
      delay: json['delay'],
    );
  }

  get binary {
    if (actualArrivalRail != null) return actualArrivalRail;
    if (plannedArrivalRail != null) return plannedArrivalRail;

    if (actualDepartureRail != null) return actualDepartureRail;
    if (plannedDepartureRail != null) return plannedDepartureRail;

    return "-";
  }

  get confirmedBinary {
    return actualArrivalRail != null ||
        actualDepartureRail != null ||
        confirmed;
  }

  String selectTime(context, actual, planned, predicted, isPredicted) {
    if (actual != null) {
      return actual.format(context);
    }

    if (isPredicted && predicted != null) {
      return predicted.format(context);
    }

    if (planned != null) {
      return planned.format(context);
    }

    return "—:—";
  }

  @override
  List<Object?> get props => [station, delay, confirmed, currentStation];
}
