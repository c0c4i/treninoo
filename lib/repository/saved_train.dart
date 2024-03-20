import 'dart:convert';

import 'package:treninoo/model/SavedStation.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/utils/shared_preference.dart';

import '../enum/saved_train_type.dart';

abstract class SavedTrainRepository {
  late SharedPrefs sharedPrefs;

  // Define a constructor for shared preference
  SavedTrainRepository() {
    sharedPrefs = SharedPrefs();
  }

  setup() async {
    await sharedPrefs.setup();
  }

  void changeDescription(SavedTrain savedTrain);

  List<SavedTrain> getFavourites();
  List<SavedTrain> getRecents();

  void addFavourite(SavedTrain savedTrain);
  void addRecent(SavedTrain savedTrain);

  void removeFavourite(SavedTrain savedTrain);
  void removeRecent(SavedTrain savedTrain);

  bool isFavourite(SavedTrain savedTrain);

  List<SavedStation?> getRecentsAndFavouritesStations();
  void addRecentOrFavoruiteStation(Station station, {bool isFavourite = false});

  Future<void> reorderFavourites(int oldIndex, int newIndex);
}

class APISavedTrain extends SavedTrainRepository {
  APISavedTrain() : super();

  @override
  void changeDescription(SavedTrain savedTrain) {
    List<SavedTrain?> trains = getFavourites();
    int index = trains.indexWhere((element) => element == savedTrain);
    trains[index] = savedTrain;
    sharedPrefs.favouritesTrains = jsonEncode(trains);
  }

  @override
  List<SavedTrain> getFavourites() => _getSavedTrain(SavedTrainType.favourites);

  @override
  List<SavedTrain> getRecents() => _getSavedTrain(SavedTrainType.recents);

  @override
  void addFavourite(SavedTrain savedTrain) => _saveTrain(
        savedTrain,
        SavedTrainType.favourites,
      );

  @override
  void addRecent(SavedTrain savedTrain) => _saveTrain(
        savedTrain,
        SavedTrainType.recents,
      );

  @override
  void removeFavourite(SavedTrain savedTrain) => _removeTrain(
        savedTrain,
        SavedTrainType.favourites,
      );

  @override
  void removeRecent(SavedTrain savedTrain) => _removeTrain(
        savedTrain,
        SavedTrainType.recents,
      );

  @override
  List<SavedStation> getRecentsAndFavouritesStations() {
    String? raw = sharedPrefs.recentsAndFavouritesStations;
    if (raw == null) return [];
    List<dynamic> rawStations = jsonDecode(raw);
    return rawStations.map((e) => SavedStation.fromJson(e)).toList();
  }

  @override
  bool isFavourite(SavedTrain? savedTrain) {
    List<SavedTrain?> savedTrains = _getSavedTrain(SavedTrainType.favourites);
    return savedTrains.contains(savedTrain);
  }

  // Used when user click on the heart icon to remove favourite station
  void removeFavoruiteStation(Station station) {
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

  List<SavedTrain> _getSavedTrain(SavedTrainType savedTrainType) {
    String? raw;
    switch (savedTrainType) {
      case SavedTrainType.favourites:
        raw = sharedPrefs.favouritesTrains;
        break;
      case SavedTrainType.recents:
        raw = sharedPrefs.recentsTrains;
        break;
    }

    if (raw == null) return [];

    List<dynamic> trains = jsonDecode(raw);

    List<SavedTrain> savedTrains =
        trains.map((e) => SavedTrain.fromJson(e)).toList();

    return savedTrains;
  }

  void _setSavedTrain(SavedTrainType savedTrainType, List<SavedTrain> trains) {
    // Modify list to only have 3 trains
    if (trains.length > 3 && savedTrainType == SavedTrainType.recents)
      trains.removeLast();

    String decodedTrains = jsonEncode(trains);
    switch (savedTrainType) {
      case SavedTrainType.favourites:
        sharedPrefs.favouritesTrains = decodedTrains;
        break;
      case SavedTrainType.recents:
        sharedPrefs.recentsTrains = decodedTrains;
        break;
    }
  }

  void _saveTrain(SavedTrain savedTrain, SavedTrainType savedTrainType) {
    // Get saved trains from shared preference
    List<SavedTrain> savedTrains = _getSavedTrain(savedTrainType);

    // If train is in the list, remove it
    if (savedTrains.contains(savedTrain)) {
      savedTrains.remove(savedTrain);
    }

    // Add train on top of the list
    savedTrains.insert(0, savedTrain);

    // Set saved trains to shared preference
    _setSavedTrain(savedTrainType, savedTrains);
  }

  void _removeTrain(SavedTrain savedTrain, SavedTrainType savedTrainType) {
    // Get saved trains from shared preference
    List<SavedTrain> savedTrains = _getSavedTrain(savedTrainType);

    // If train is in the list, remove it
    if (savedTrains.contains(savedTrain)) {
      savedTrains.remove(savedTrain);
    }

    // Set saved trains to shared preference
    _setSavedTrain(savedTrainType, savedTrains);
  }

  Future<void> reorderFavourites(int oldIndex, int newIndex) async {
    List<SavedTrain> trains = _getSavedTrain(SavedTrainType.favourites);
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    SavedTrain train = trains.removeAt(oldIndex);
    trains.insert(newIndex, train);
    _setSavedTrain(SavedTrainType.favourites, trains);
  }

  // Function to add
}
