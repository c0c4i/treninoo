import '../utils/utils.dart';

class Stop {
  final String? name;
  final String? plannedDepartureTime;
  final String? actualDepartureTime;
  final String? plannedArrivalTime;
  final String? actualArrivalTime;
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
      plannedDepartureTime: Utils.timeStampToString(
        json['partenza_teorica'],
      ),
      actualDepartureTime: Utils.timeStampToString(
        json['partenzaReale'],
      ),
      plannedArrivalTime: Utils.timeStampToString(
        json['arrivo_teorico'],
      ),
      actualArrivalTime: Utils.timeStampToString(
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
