import 'package:flutter/material.dart';
import 'package:treninoo/utils/utils.dart';

class StationTrain {
  final String? trainCode;
  final String? departureCode;
  final String? category;
  final String? name;
  final TimeOfDay? time;
  final String? plannedRail;
  final String? actualRail;
  final int? delay;

  StationTrain({
    this.trainCode,
    this.departureCode,
    this.category,
    this.name,
    this.time,
    this.plannedRail,
    this.actualRail,
    this.delay,
  });

  factory StationTrain.fromTreninooAPI(Map<String, dynamic> json) {
    return StationTrain(
      trainCode: json['trainCode'],
      departureCode: json['departureCode'],
      category: json['category'],
      name: json['stationName'],
      time: Utils.timestampToTimeOfDay(json['time']),
      plannedRail: json['plannedPlatform'],
      actualRail: json['actualPlatform'],
      delay: json['ritardo'],
    );
  }

  factory StationTrain.fromJson(Map<String, dynamic> json, bool departure) {
    String? plannedRail;
    String? actualRail;
    TimeOfDay? time;
    String? name;

    if (departure) {
      plannedRail = json['binarioEffettivoPartenzaDescrizione'];
      actualRail = json['binarioProgrammatoPartenzaDescrizione'];
      time = Utils.timestampToTimeOfDay(json['orarioPartenza']);
      name = json['destinazione'];
    } else {
      plannedRail = json['binarioProgrammatoArrivoDescrizione'];
      actualRail = json['binarioEffettivoArrivoDescrizione'];
      time = Utils.timestampToTimeOfDay(json['orarioArrivo']);
      name = json['origine'];
    }

    return StationTrain(
      trainCode: json['numeroTreno'].toString(),
      departureCode: json['codOrigine'],
      category: json['categoriaDescrizione'],
      name: name,
      time: time,
      plannedRail: plannedRail,
      actualRail: actualRail,
      delay: json['ritardo'],
    );
  }
}
