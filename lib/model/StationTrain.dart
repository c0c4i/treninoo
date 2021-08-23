import 'package:treninoo/model/Stop.dart';
import 'package:treninoo/utils/api.dart';

class StationTrain {
  final String trainCode;
  final String category;
  final String departureStation;
  final String time;
  final String plannedRail;
  final String actualRail;
  final int delay;

  StationTrain({
    this.trainCode,
    this.category,
    this.departureStation,
    this.time,
    this.plannedRail,
    this.actualRail,
    this.delay,
  });

  factory StationTrain.fromJson(Map<String, dynamic> json, bool departure) {
    String plannedRail;
    String actualRail;
    String time;

    if (departure) {
      plannedRail = json['binarioEffettivoPartenzaDescrizione'];
      actualRail = json['binarioProgrammatoPartenzaDescrizione'];
      time = timeStampToString(json['orarioArrivo']);
    } else {
      plannedRail = json['binarioProgrammatoArrivoDescrizione'];
      actualRail = json['binarioEffettivoArrivoDescrizione'];
      time = timeStampToString(json['orarioArrivo']);
    }

    return StationTrain(
      trainCode: json['numeroTreno'].toString(),
      category: json['categoriaDescrizione'],
      departureStation: json['origine'],
      time: time,
      plannedRail: plannedRail,
      actualRail: actualRail,
      delay: json['ritardo'],
    );
  }
}
