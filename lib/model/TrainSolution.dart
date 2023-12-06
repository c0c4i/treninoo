class TrainSolution {
  final String departureStation;
  final String? arrivalStation;
  final DateTime? departureTime;
  final DateTime? arrivalTime;
  final String? trainType;
  final String? trainCode;

  TrainSolution({
    this.trainCode,
    required this.departureStation,
    this.arrivalStation,
    this.departureTime,
    this.arrivalTime,
    this.trainType,
  });

  factory TrainSolution.fromJson(Map<String, dynamic> json) {
    return TrainSolution(
      departureStation: json['origin'],
      arrivalStation: json['destination'],
      departureTime: DateTime.parse(json['departureTime']),
      arrivalTime: DateTime.parse(json['arrivalTime']),
      trainType: json['category'],
      trainCode: json['trainCode'],
    );
  }
}
