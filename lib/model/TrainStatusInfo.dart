import 'package:treninoo/model/Stop.dart';
import 'package:treninoo/utils/api.dart';

class TrainStatusInfo {
  final List<Stop> stops;
  final String lastPositionRegister; // to converter from unix
  final String lastTimeRegister;
  final String trainType;
  final int delay;
  final String trainCode;

  String departureStationCode;
  String departureStationName;
  String arrivalStationName;
  String departureTime;

  TrainStatusInfo({
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

  factory TrainStatusInfo.fromJson(Map<String, dynamic> json) {
    if (json['fermate'].length == 0) {
      // trainInfoErrorType = 0;
      return null;
    }
    return TrainStatusInfo(
        stops: (json['fermate'] as List).map((f) => Stop.fromJson(f)).toList(),
        lastPositionRegister: json['stazioneUltimoRilevamento'],
        lastTimeRegister: timeStampToString(json['oraUltimoRilevamento']),
        trainType: json['categoria'],
        delay: json['ritardo'],
        trainCode: json['numeroTreno'].toString(),
        departureStationCode: json['idOrigine'],
        departureStationName: json['origine'],
        arrivalStationName: json['destinazione'],
        departureTime: json['compOrarioPartenzaZero']);
  }
}
