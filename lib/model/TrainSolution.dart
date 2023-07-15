import 'package:treninoo/utils/train_utils.dart';

class TrainSolution {
  final String? departureStation;
  final String? arrivalStation;
  final DateTime? departureTime;
  final DateTime? arrivalTime;
  final String? trainType;
  final String? trainCode;

  TrainSolution(
      {this.departureStation,
      this.arrivalStation,
      this.departureTime,
      this.arrivalTime,
      this.trainType,
      this.trainCode});

  factory TrainSolution.fromJson(Map<String, dynamic> json) {
    return TrainSolution(
      departureStation: json['origine'],
      arrivalStation: json['destinazione'],
      departureTime: DateTime.parse(json['orarioPartenza']),
      arrivalTime: DateTime.parse(json['orarioArrivo']),
      trainType: TrainUtils.getTypeFromNumber(json['categoria']),
      trainCode: json['numeroTreno'],
    );
  }
}
