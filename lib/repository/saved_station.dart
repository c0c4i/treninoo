import 'dart:convert';

import 'package:treninoo/model/SavedStation.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/utils/shared_preference.dart';

abstract class SavedStationsRepository {
  SharedPrefs sharedPrefs;

  SavedStationsRepository(SharedPrefs sharedPrefs) : sharedPrefs = sharedPrefs;

  List<SavedStation> getRecentsAndFavouritesStations();
  void removeFavoruiteStation(SavedStation station);
  void addRecentOrFavoruiteStation(Station station, {bool isFavourite = false});
}

class APISavedStation extends SavedStationsRepository {
  APISavedStation(super.sharedPrefs);

  @override
  List<SavedStation> getRecentsAndFavouritesStations() {
    String? raw = sharedPrefs.recentsAndFavouritesStations;
    if (raw == null) return [];
    List<dynamic> rawStations = jsonDecode(raw);
    return rawStations.map((e) => SavedStation.fromJson(e)).toList();
  }

  // Used when user click on the heart icon to remove favourite station
  void removeFavoruiteStation(SavedStation station) {
    List<SavedStation> stations = getRecentsAndFavouritesStations();
    stations.removeWhere((element) => element.station == station);
    sharedPrefs.recentsAndFavouritesStations = jsonEncode(stations);
  }

  // Used when user make a new search or add a station to favourite
  void addRecentOrFavoruiteStation(Station station,
      {bool isFavourite = false}) {
    // Get saved stations from shared preference
    List<SavedStation> stations = getRecentsAndFavouritesStations();

    // Handle when user add a station to favourite
    if (isFavourite) {
      // Add station on top of the list
      stations.insert(0, SavedStation(station, isFavourite: true));
      return;
    } else {
      // Handle when user make a new search

      // Find station in the list
      int? index = stations.indexWhere((element) => element.station == station);
      SavedStation? savedStationInList = index == -1 ? null : stations[index];

      // If station is not in the list, add it and remove the oldest recent station
      if (savedStationInList == null) {
        stations.insert(0, SavedStation(station));

        // Modify list to only have 3 recents trains, remove the oldest one based on lastSelected
        if (stations.map((e) => !e.isFavourite).length > 3) {
          // Find the oldest recent station
          SavedStation oldestRecent = stations
              .where((element) => !element.isFavourite)
              .reduce((value, element) =>
                  value.lastSelected.isBefore(element.lastSelected)
                      ? value
                      : element);

          // Remove the oldest recent station
          stations.remove(oldestRecent);
        }
      } else {
        // If station is in the list, update lastSelected
        stations[index] =
            savedStationInList.copyWith(lastSelected: DateTime.now());
      }
    }

    // Save stations to shared preference
    sharedPrefs.recentsAndFavouritesStations = jsonEncode(stations);
  }
}
