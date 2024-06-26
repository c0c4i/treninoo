import 'dart:convert';

import 'package:treninoo/model/SavedStation.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/utils/shared_preference.dart';

abstract class SavedStationsRepository {
  SharedPrefs sharedPrefs;

  SavedStationsRepository(SharedPrefs sharedPrefs) : sharedPrefs = sharedPrefs;

  List<SavedStation> getRecentsAndFavouritesStations();
  void removeFavoriteStation(SavedStation station);
  void addRecentOrFavoruiteStation(Station station, {bool isFavourite = false});
}

class APISavedStation extends SavedStationsRepository {
  APISavedStation(super.sharedPrefs);

  @override
  List<SavedStation> getRecentsAndFavouritesStations() {
    String? raw = sharedPrefs.recentsAndFavouritesStations;
    if (raw == null) return [];
    List<dynamic> rawStations = jsonDecode(raw);

    List<SavedStation> stations =
        rawStations.map((e) => SavedStation.fromJson(e)).toList();

    // Sort stations by lastSelected
    stations.sort((a, b) => a.lastSelected.isAfter(b.lastSelected) ? -1 : 1);

    return stations;
  }

  // Used when user click on the heart icon to remove favourite station
  void removeFavoriteStation(SavedStation savedStation) {
    List<SavedStation> stations = getRecentsAndFavouritesStations();

    // Get index of station in the list
    int? index = stations
        .indexWhere((element) => element.station == savedStation.station);

    // Remove station from the list
    if (index != -1) stations.removeAt(index);

    // Check if can stay as recent station (less then 3 recent stations)
    int recentStations = stations.where((e) => !e.isFavourite).length;
    if (recentStations < 3) {
      // If true add the station as recent station
      stations.insert(index, savedStation.copyWith(isFavourite: false));
    }

    sharedPrefs.recentsAndFavouritesStations = jsonEncode(stations);
  }

  // Used when user make a new search or add a station to favourite
  void addRecentOrFavoruiteStation(Station station,
      {bool isFavourite = false}) {
    // Get saved stations from shared preference
    List<SavedStation> stations = getRecentsAndFavouritesStations();

    // Handle when user add a station to favourite
    if (isFavourite) {
      // Update value of isFavourite of station on the list
      int? index = stations.indexWhere((element) => element.station == station);

      // If station is not in the list, ignore it (should not happen but just in case)
      if (index == -1) return;

      // Update value of isFavourite
      SavedStation savedStation = stations[index].copyWith(isFavourite: true);
      stations[index] = savedStation;
    } else {
      // Handle when user make a new search

      // Find station in the list
      int? index = stations.indexWhere((element) => element.station == station);
      SavedStation? savedStationInList = index == -1 ? null : stations[index];

      // If station is not in the list, add it and remove the oldest recent station
      if (savedStationInList == null) {
        stations.insert(0, SavedStation(station));

        // Modify list to only have 3 recents trains, remove the oldest one based on lastSelected
        int recentStations = stations.where((e) => !e.isFavourite).length;
        if (recentStations > 3) {
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
