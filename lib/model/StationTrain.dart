import 'package:treninoo/utils/utils.dart';

class StationTrain {
  final String trainCode;
  final String departureCode;
  final String category;
  final String name;
  final String time;
  final String plannedRail;
  final String actualRail;
  final int delay;
  final bool isDeparture;

  StationTrain({
    this.trainCode,
    this.departureCode,
    this.category,
    this.name,
    this.time,
    this.plannedRail,
    this.actualRail,
    this.delay,
    this.isDeparture,
  });

  factory StationTrain.fromJson(Map<String, dynamic> json, bool departure) {
    String plannedRail;
    String actualRail;
    String time;
    String name;

    if (departure) {
      plannedRail = json['binarioEffettivoPartenzaDescrizione'];
      actualRail = json['binarioProgrammatoPartenzaDescrizione'];
      time = Utils.timeStampToString(json['orarioPartenza']);
      name = json['destinazione'];
    } else {
      plannedRail = json['binarioProgrammatoArrivoDescrizione'];
      actualRail = json['binarioEffettivoArrivoDescrizione'];
      time = Utils.timeStampToString(json['orarioArrivo']);
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
      isDeparture: departure,
    );
  }
}
