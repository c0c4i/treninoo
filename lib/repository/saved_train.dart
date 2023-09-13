import 'dart:convert';

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

  List<Station?> getRecentsStations();
  void addRecentStation(Station? station);
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
  List<Station?> getRecentsStations() {
    String? raw = sharedPrefs.recentsStations;
    if (raw == null) return [];
    List<dynamic> rawStations = jsonDecode(raw);
    return rawStations.map((e) => Station.fromJson(e)).toList();
  }

  @override
  bool isFavourite(SavedTrain? savedTrain) {
    List<SavedTrain?> savedTrains = _getSavedTrain(SavedTrainType.favourites);
    return savedTrains.contains(savedTrain);
  }

  void addRecentStation(Station? station) {
    // Get saved trains from shared preference
    List<Station?> stations = getRecentsStations();

    // If train is in the list, remove it
    if (stations.contains(station)) stations.remove(station);

    // Add train on top of the list
    stations.insert(0, station);

    // Modify list to only have 3 trains
    if (stations.length > 3) stations.removeLast();
    sharedPrefs.recentsStations = jsonEncode(stations);
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
}
