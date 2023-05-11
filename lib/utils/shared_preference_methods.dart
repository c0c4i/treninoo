// import 'dart:convert';

// import 'package:treninoo/model/SavedTrain.dart';
// import 'package:treninoo/model/Station.dart';
// import 'package:treninoo/model/TrainInfo.dart';
// import 'package:treninoo/repository/train.dart';
// import 'package:treninoo/utils/shared_preference.dart';

// // TODO Remove this file and convert all to API
// /// add recent train to shared preference
// // void addRecentTrain(DepartureStation departureStation) {
// //   SavedTrain train = SavedTrain(
// //     departureStationCode: departureStation.station.stationCode,
// //     trainCode: departureStation.trainCode,
// //   );

// //   List<dynamic> trains = jsonDecode(sharedPrefs.recentsStations);
// //   List<SavedTrain> savedTrains =
// //       trains.map((e) => SavedTrain.fromJson(e)).toList();

// //   if (savedTrains.contains(train)) {
// //     savedTrains.remove(train);
// //   } else if (savedTrains.length == 3) savedTrains.removeLast();
// //   savedTrains.insert(0, train);
// //   sharedPrefs.recentsStations = jsonEncode(savedTrains);
// // }

// // static void removeRecentTrain(TrainInfo trainInfo) {
// //   SavedTrain train = SavedTrain.fromTrainInfo(trainInfo);

// //   List<dynamic> trains = jsonDecode(sharedPrefs.recentsStations);
// //   List<SavedTrain> savedTrains =
// //       trains.map((e) => SavedTrain.fromJson(e)).toList();

// //   if (savedTrains.contains(train)) {
// //     savedTrains.remove(train);
// //   } else if (savedTrains.length == 3) savedTrains.removeLast();
// //   savedTrains.insert(0, train);
// //   sharedPrefs.recentsStations = jsonEncode(savedTrains);
// // }

// /// add favourite train to shared preference
// void addTrain(SavedTrain savedTrain, SavedTrainType savedTrainType) {
//   // Get saved trains from shared preference
//   List<SavedTrain> savedTrains = getSavedTrain(savedTrainType);

//   // If train is in the list, remove it
//   if (savedTrains.contains(savedTrain)) {
//     savedTrains.remove(savedTrain);
//   }

//   // Add train on top of the list
//   savedTrains.insert(0, savedTrain);

//   // Set saved trains to shared preference
//   setSavedTrain(savedTrainType, savedTrains);
// }

// /// remove favourite train from shared preference
// void removeTrain(SavedTrain savedTrain, SavedTrainType savedTrainType) {
//   // Get saved trains from shared preference
//   List<SavedTrain> savedTrains = getSavedTrain(savedTrainType);

//   // If train is in the list, remove it
//   if (savedTrains.contains(savedTrain)) {
//     savedTrains.remove(savedTrain);
//   }

//   // Set saved trains to shared preference
//   setSavedTrain(savedTrainType, savedTrains);
// }

// /// remove favourite train from shared preference
// // void removeRecentTrain(SavedTrain savedTrain) {
// //   String raw = sharedPrefs.favouritesTrains;
// //   if (raw == null) return;

// //   List<dynamic> trains = jsonDecode(raw);
// //   List<SavedTrain> savedTrains =
// //       trains.map((e) => SavedTrain.fromJson(e)).toList();

// //   if (savedTrains.contains(savedTrain)) savedTrains.remove(savedTrain);
// //   sharedPrefs.favouritesTrains = jsonEncode(savedTrains);
// // }

// /// true/false if favourites train
// bool isFavouriteTrain(TrainInfo trainInfo) {
//   SavedTrain train = SavedTrain.fromTrainInfo(trainInfo);

//   String raw = sharedPrefs.favouritesTrains;
//   if (raw == null) return false;

//   List<dynamic> trains = jsonDecode(raw);

//   List<SavedTrain> savedTrains =
//       trains.map((e) => SavedTrain.fromJson(e)).toList();

//   return savedTrains.contains(train);
// }

// List<Station> fetchRecentsStations() {
//   String raw = sharedPrefs.recentsStations;
//   if (raw == null) return [];
//   List<dynamic> rawStations = jsonDecode(raw);
//   return rawStations.map((e) => Station.fromJson(e)).toList();
// }

// void addRecentStation(Station station) {
//   String raw = sharedPrefs.recentsStations;

//   List<Station> stations = [];

//   if (raw == null) {
//     stations.insert(0, station);
//   } else {
//     List<dynamic> rawStations = jsonDecode(raw);
//     stations = rawStations.map((e) => Station.fromJson(e)).toList();

//     if (!stations.contains(station)) {
//       stations.insert(0, station);
//     }
//     if (stations.length > 3) stations.removeLast();
//   }

//   sharedPrefs.recentsStations = jsonEncode(stations);
// }

// // List<SavedTrain> getSavedTrain(SavedTrainType savedTrainType) {
// //   String raw;
// //   switch (savedTrainType) {
// //     case SavedTrainType.favourites:
// //       raw = sharedPrefs.favouritesTrains;
// //       break;
// //     case SavedTrainType.recents:
// //       raw = sharedPrefs.recentsTrains;
// //       break;
// //   }

// //   if (raw == null) return [];

// //   List<dynamic> trains = jsonDecode(raw);
// //   List<SavedTrain> savedTrains =
// //       trains.map((e) => SavedTrain.fromJson(e)).toList();

// //   return savedTrains;
// // }

// // void setSavedTrain(SavedTrainType savedTrainType, List<SavedTrain> trains) {
// //   // Modify list to only have 3 trains
// //   if (trains.length > 3 && savedTrainType == SavedTrainType.recents)
// //     trains.removeLast();

// //   String decodedTrains = jsonEncode(trains);
// //   switch (savedTrainType) {
// //     case SavedTrainType.favourites:
// //       sharedPrefs.favouritesTrains = decodedTrains;
// //       break;
// //     case SavedTrainType.recents:
// //       sharedPrefs.recentsTrains = decodedTrains;
// //       break;
// //   }
// // }
