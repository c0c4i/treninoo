import 'package:equatable/equatable.dart';
import 'package:treninoo/model/Station.dart';

class SavedSolutionsInfo extends Equatable {
  final Station departureStation;
  final Station arrivalStation;
  final DateTime lastSelected;

  SavedSolutionsInfo(this.departureStation, this.arrivalStation, {lastSelected})
      : lastSelected = lastSelected ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        "departure_station": departureStation.toJson(),
        "arrival_station": arrivalStation.toJson(),
        "last_selected": lastSelected.toString()
      };

  factory SavedSolutionsInfo.fromJson(Map<String, dynamic> json) {
    return SavedSolutionsInfo(Station.fromJson(json["departure_station"]),
        Station.fromJson(json["arrival_station"]),
        lastSelected: DateTime.parse(json["last_selected"]));
  }

  SavedSolutionsInfo copyWith({DateTime? lastSelected}) {
    return SavedSolutionsInfo(this.departureStation, this.arrivalStation,
        lastSelected: lastSelected ?? this.lastSelected);
  }

  @override
  List<Object?> get props {
    return [departureStation, arrivalStation];
  }
}
