import 'package:treninoo/utils/final.dart';

class TrainSolutionInfo {
  final String departure_station;
  final String arrival_station;
  final DateTime departure_time;
  final DateTime arrival_time;
  final String typeNumber; // sono infami e quindi String e non int come volevo
  final String trainType;
  final String trainCode;

  TrainSolutionInfo(
      {this.departure_station,
      this.arrival_station,
      this.departure_time,
      this.arrival_time,
      this.typeNumber,
      this.trainType,
      this.trainCode});

  factory TrainSolutionInfo.fromJson(Map<String, dynamic> json) {
    String typeNumber = json['categoria'];

    return TrainSolutionInfo(
        departure_station: json['origine'],
        arrival_station: json['destinazione'],
        departure_time: DateTime.parse(json['orarioPartenza']),
        arrival_time: DateTime.parse(json['orarioArrivo']),
        typeNumber: typeNumber,
        trainType: trainTypeFromNumber.containsKey(typeNumber)
            ? trainTypeFromNumber[typeNumber]
            : "EC",
        trainCode: json['numeroTreno']);
  }
}
