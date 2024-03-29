import 'package:treninoo/model/Solution.dart';
import 'package:treninoo/model/Station.dart';

class Solutions {
  List<Solution>? solutions;
  Station? departureStation;
  Station? arrivalStation;
  DateTime? fromTime;

  Solutions({
    this.solutions,
    this.departureStation,
    this.arrivalStation,
    this.fromTime,
  });

  factory Solutions.fromJson(Map<String, dynamic> json) {
    List<Solution> solutions =
        (json['solutions'] as List).map((f) => Solution.fromJson(f)).toList();
    return Solutions(solutions: solutions);
  }
}
