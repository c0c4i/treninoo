import 'package:equatable/equatable.dart';
import 'package:treninoo/model/TrainSolution.dart';

class Solution extends Equatable {
  // final String travelTime;
  final List<TrainSolution> trains;

  Solution({required this.trains});

  factory Solution.fromJson(Map<String, dynamic> json) {
    return Solution(
      trains: (json['trains'] as List)
          .map((f) => TrainSolution.fromJson(f))
          .toList(),
    );
  }

  Solution copyWith({List<TrainSolution>? trains}) {
    return Solution(trains: trains ?? this.trains);
  }

  @override
  List<Object?> get props => [trains];
}
