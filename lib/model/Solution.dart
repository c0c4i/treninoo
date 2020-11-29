import 'package:treninoo/model/TrainSolutionInfo.dart';

class Solution {
  final String travelTime;
  final List<TrainSolutionInfo> trains;

  Solution({this.travelTime, this.trains});

  factory Solution.fromJson(Map<String, dynamic> json) {
    return Solution(
      travelTime: json['durata'],
      trains: (json['vehicles'] as List)
          .map((f) => TrainSolutionInfo.fromJson(f))
          .toList(),
    );
  }
}
