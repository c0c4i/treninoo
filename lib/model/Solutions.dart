import 'package:equatable/equatable.dart';
import 'package:treninoo/model/Solution.dart';
import 'package:treninoo/model/Station.dart';

class Solutions extends Equatable {
  final List<Solution> solutions;
  final Station departureStation;
  final Station arrivalStation;
  final DateTime fromTime;

  Solutions({
    required this.solutions,
    required this.departureStation,
    required this.arrivalStation,
    required this.fromTime,
  });

  static List<Solution> getSolutionsFromJson(Map<String, dynamic> json) {
    return (json['solutions'] as List)
        .map((f) => Solution.fromJson(f))
        .toList();
  }

  @override
  List<Object?> get props => [solutions];
}
