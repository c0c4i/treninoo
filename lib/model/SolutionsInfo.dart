import 'package:treninoo/model/Station.dart';

class SolutionsInfo {
  Station departureStation;
  Station arrivalStation;
  DateTime fromTime;

  SolutionsInfo({
    this.departureStation,
    this.arrivalStation,
    this.fromTime,
  });
}
