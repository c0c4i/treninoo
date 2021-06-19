import 'package:treninoo/utils/final.dart';

class TrainSolution {
  final String departureStation;
  final String arrivalStation;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final String typeNumber; // sono infami e quindi String e non int come volevo
  final String trainType;
  final String trainCode;

  TrainSolution(
      {this.departureStation,
      this.arrivalStation,
      this.departureTime,
      this.arrivalTime,
      this.typeNumber,
      this.trainType,
      this.trainCode});

  factory TrainSolution.fromJson(Map<String, dynamic> json) {
    String category = json['categoria'];
    String typeNumber = trainTypeFromNumber.containsKey(category)
        ? trainTypeFromNumber[category]
        : "EC";

    return TrainSolution(
        departureStation: json['origine'],
        arrivalStation: json['destinazione'],
        departureTime: DateTime.parse(json['orarioPartenza']),
        arrivalTime: DateTime.parse(json['orarioArrivo']),
        typeNumber: typeNumber,
        trainType: typeNumber,
        trainCode: json['numeroTreno']);
  }
}
