import 'package:treninoo/utils/api.dart';

class Stop {
  final String name;
  final String plannedDepartureTime;
  final String actualDepartureTime;
  final String plannedArrivalTime;
  final String actualArrivalTime;
  final String plannedDepartureRail;
  final String actualDepartureRail;
  final String plannedArrivalRail;
  final String actualArrivalRail;
  final int delay;

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
      plannedDepartureTime:
          timeStampToString(json['partenza_teorica']), // to converter from unix
      actualDepartureTime:
          timeStampToString(json['partenzaReale']), // to converter from unix
      plannedArrivalTime:
          timeStampToString(json['arrivo_teorico']), // to converter from unix
      actualArrivalTime:
          timeStampToString(json['arrivoReale']), // to converter from unix
      plannedDepartureRail: json['binarioProgrammatoPartenzaDescrizione'],
      actualDepartureRail: json['binarioEffettivoPartenzaDescrizione'],
      plannedArrivalRail: json['binarioProgrammatoArrivoDescrizione'],
      actualArrivalRail: json['binarioEffettivoArrivoDescrizione'],
      delay: json['ritardo'],
    );
  }
}
