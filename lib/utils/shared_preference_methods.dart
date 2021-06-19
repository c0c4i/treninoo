import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:treninoo/model/DepartureStation.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/model/TrainInfo.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/utils/shared_preference.dart';

/// add recent train to shared preference
void addRecentTrain(DepartureStation departureStation) {
  SavedTrain train = SavedTrain(
    departureStationCode: departureStation.station.stationCode,
    trainCode: departureStation.trainCode,
  );

  List<dynamic> trains = jsonDecode(sharedPrefs.recentsStations);
  List<SavedTrain> savedTrains =
      trains.map((e) => SavedTrain.fromJson(e)).toList();

  if (savedTrains.contains(train)) {
    savedTrains.remove(train);
  } else if (savedTrains.length == 3) savedTrains.removeLast();
  savedTrains.insert(0, train);
  sharedPrefs.recentsStations = jsonEncode(savedTrains);
}

// static void removeRecentTrain(TrainInfo trainInfo) {
//   SavedTrain train = SavedTrain.fromTrainInfo(trainInfo);

//   List<dynamic> trains = jsonDecode(sharedPrefs.recentsStations);
//   List<SavedTrain> savedTrains =
//       trains.map((e) => SavedTrain.fromJson(e)).toList();

//   if (savedTrains.contains(train)) {
//     savedTrains.remove(train);
//   } else if (savedTrains.length == 3) savedTrains.removeLast();
//   savedTrains.insert(0, train);
//   sharedPrefs.recentsStations = jsonEncode(savedTrains);
// }

/// add favourite train to shared preference
void addFavouriteTrain(TrainInfo trainInfo) {
  SavedTrain train = SavedTrain.fromTrainInfo(trainInfo);

  String raw = sharedPrefs.favouritesTrains;
  List<SavedTrain> savedTrains = [];

  if (raw == null) {
    savedTrains.insert(0, train);
  } else {
    List<dynamic> trains = jsonDecode(raw);
    savedTrains = trains.map((e) => SavedTrain.fromJson(e)).toList();
    if (!savedTrains.contains(train)) {
      savedTrains.insert(0, train);
    }
  }

  sharedPrefs.favouritesTrains = jsonEncode(savedTrains);
}

/// remove favourite train from shared preference
void removeFavouriteTrain(TrainInfo trainInfo) {
  SavedTrain train = SavedTrain.fromTrainInfo(trainInfo);

  String raw = sharedPrefs.favouritesTrains;
  if (raw == null) return;

  List<dynamic> trains = jsonDecode(raw);
  List<SavedTrain> savedTrains =
      trains.map((e) => SavedTrain.fromJson(e)).toList();

  if (savedTrains.contains(train)) savedTrains.remove(train);
  sharedPrefs.favouritesTrains = jsonEncode(savedTrains);
}

/// true/false if favourites train
bool isFavouriteTrain(TrainInfo trainInfo) {
  SavedTrain train = SavedTrain.fromTrainInfo(trainInfo);

  String raw = sharedPrefs.favouritesTrains;
  if (raw == null) return false;

  List<dynamic> trains = jsonDecode(raw);

  List<SavedTrain> savedTrains =
      trains.map((e) => SavedTrain.fromJson(e)).toList();

  return savedTrains.contains(train);
}

List<SavedTrain> getSavedTrain(SavedTrainType savedTrainType) {
  String raw;
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
