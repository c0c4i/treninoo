import 'package:flutter/material.dart';

import '../utils/utils.dart';

class Stop {
  final String? name;
  final TimeOfDay? plannedDepartureTime;
  final TimeOfDay? actualDepartureTime;
  final TimeOfDay? plannedArrivalTime;
  final TimeOfDay? actualArrivalTime;
  final String? plannedDepartureRail;
  final String? actualDepartureRail;
  final String? plannedArrivalRail;
  final String? actualArrivalRail;
  final int? delay;

  Stop({
    this.name,
    this.plannedDepartureTime,
    this.actualDepartureTime,
    this.plannedArrivalTime,
    this.actualArrivalTime,
    this.plannedDepartureRail,
    this.actualDepartureRail,
    this.plannedArrivalRail,
    this.actualArrivalRail,
    this.delay,
  });

  factory Stop.fromJson(Map<String, dynamic> json) {
    return Stop(
      name: json['stazione'],
      plannedDepartureTime: Utils.timestampToTimeOfDay(
        json['partenza_teorica'],
      ),
      actualDepartureTime: Utils.timestampToTimeOfDay(
        json['partenzaReale'],
      ),
      plannedArrivalTime: Utils.timestampToTimeOfDay(
        json['arrivo_teorico'],
      ),
      actualArrivalTime: Utils.timestampToTimeOfDay(
        json['arrivoReale'],
      ),
      plannedDepartureRail: json['binarioProgrammatoPartenzaDescrizione'],
      actualDepartureRail: json['binarioEffettivoPartenzaDescrizione'],
      plannedArrivalRail: json['binarioProgrammatoArrivoDescrizione'],
      actualArrivalRail: json['binarioEffettivoArrivoDescrizione'],
      delay: json['ritardo'],
    );
  }
}
