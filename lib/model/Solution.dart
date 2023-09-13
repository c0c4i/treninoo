import 'package:treninoo/model/TrainSolution.dart';

class Solution {
  // final String travelTime;
  final List<TrainSolution>? trains;

  Solution({this.trains});

  factory Solution.fromJson(Map<String, dynamic> json) {
    return Solution(
      trains: (json['trains'] as List)
          .map((f) => TrainSolution.fromJson(f))
          .toList(),
    );
  }
}
