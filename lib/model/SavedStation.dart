import 'package:equatable/equatable.dart';

import 'Station.dart';

class SavedStation extends Equatable {
  final Station station;
  final DateTime lastSelected;
  final bool isFavourite;

  SavedStation(this.station, {lastSelected, isFavourite})
      : lastSelected = lastSelected ?? DateTime.now(),
        isFavourite = false;

  Map<String, dynamic> toJson() => {
        'station': station.toJson(),
        'last_selected': lastSelected.toString(),
        'is_favourite': isFavourite,
      };

  factory SavedStation.fromJson(Map<String, dynamic> json) {
    return SavedStation(
      Station.fromJson(json['station']),
      lastSelected: DateTime.parse(json['last_selected']),
      isFavourite: json['is_favourite'],
    );
  }

  SavedStation copyWith({
    DateTime? lastSelected,
    bool? isFavourite,
  }) {
    return SavedStation(
      station,
      lastSelected: lastSelected,
      isFavourite: isFavourite,
    );
  }

  @override
  List<Object?> get props {
    return [station, lastSelected, isFavourite];
  }
}
