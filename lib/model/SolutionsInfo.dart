import 'package:treninoo/model/Station.dart';

class SolutionsInfo {
  Station departureStation;
  Station arrivalStation;
  DateTime fromTime;

  SolutionsInfo({
    required this.departureStation,
    required this.arrivalStation,
    required this.fromTime,
  });
}
