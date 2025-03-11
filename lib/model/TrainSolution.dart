import 'package:equatable/equatable.dart';
import 'package:treninoo/model/Station.dart';

class TrainSolution extends Equatable {
  final String origin;
  final String? destination;
  final DateTime? departureTime;
  final DateTime? arrivalTime;
  final String? trainType;
  final String? trainCode;
  final Station? originStation;
  final Station? destinationStation;

  TrainSolution({
    this.trainCode,
    required this.origin,
    this.destination,
    this.departureTime,
    this.arrivalTime,
    this.trainType,
    this.originStation,
    this.destinationStation,
  });

  factory TrainSolution.fromJson(Map<String, dynamic> json) {
    Station? originStation = json['originStation'] != null
        ? Station.fromJson(json['originStation'])
        : null;

    Station? destinationStation = json['destinationStation'] != null
        ? Station.fromJson(json['destinationStation'])
        : null;

    return TrainSolution(
      origin: json['origin'],
      destination: json['destination'],
      departureTime: DateTime.parse(json['departureTime']),
      arrivalTime: DateTime.parse(json['arrivalTime']),
      trainType: json['category'],
      trainCode: json['trainCode'],
      originStation: originStation,
      destinationStation: destinationStation,
    );
  }

  @override
  List<Object?> get props => [trainCode, origin];
}
