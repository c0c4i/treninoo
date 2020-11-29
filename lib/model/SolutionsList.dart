import 'package:treninoo/model/Solution.dart';

class SolutionsList {
  final List<Solution> solutions;
  final String departureStation;
  final String departureStationCode;
  final String arrivalStation;
  final String arrivalStationCode;
  final DateTime fromTime;

  SolutionsList({
    this.solutions,
    this.departureStation,
    this.departureStationCode,
    this.arrivalStation,
    this.arrivalStationCode,
    this.fromTime,
  });

  factory SolutionsList.fromJson(Map<String, dynamic> json,
      String departureCode, String arrivalCode, DateTime time) {
    if (json['soluzioni'].length == 0) {
      // trainInfoErrorType = 0;
      return null;
    }
    return SolutionsList(
      solutions:
          (json['soluzioni'] as List).map((f) => Solution.fromJson(f)).toList(),
      departureStation: json['origine'],
      departureStationCode: departureCode,
      arrivalStation: json['destinazione'],
      arrivalStationCode: arrivalCode,
      fromTime: time,
    );
  }
}
