import 'package:treninoo/model/Stop.dart';
import 'package:treninoo/utils/api.dart';

class StationTrain {
  final String trainCode;
  final String category;
  final String station;
  final String time;
  final String plannedRail;
  final String actualRail;
  final int delay;

  StationTrain({
    this.trainCode,
    this.category,
    this.station,
    this.time,
    this.plannedRail,
    this.actualRail,
    this.delay,
  });

  factory StationTrain.fromJson(Map<String, dynamic> json) {
    return StationTrain(
      trainCode: json['numeroTreno'].toString(),
      category: json['categoriaDescrizione'],
      station: json['origine'],
      time: timeStampToString(json['oraUltimoRilevamento']),
      plannedRail: json['binarioEffettivoPartenzaDescrizione'],
      actualRail: json['binarioProgrammatoPartenzaDescrizione'],
      delay: json['ritardo'],
    );
  }
}
