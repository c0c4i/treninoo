import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {
  static setAppBarBrightness(bool isDark) {
    Brightness brightness =
        Platform.isAndroid ? Brightness.dark : Brightness.light;

    if (isDark != null && isDark) {
      brightness = Platform.isAndroid ? Brightness.light : Brightness.dark;
    }

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness,
    ));
  }
}


// import 'dart:collection';
// import 'dart:ui';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'package:treninoo/model/SavedTrain.dart';
// import 'package:treninoo/model/Station.dart';

// String spRecentsTrains = 'recentsTrains';
// String spFavouritesTrains = 'favouritesTrains';
// String spRecentsStations = 'recentsStations';

// // singleton class for recents and favourites train (da riscrivere)
// class SharedPrefJson {
//   static List<SavedTrain> recentsTrains = List<SavedTrain>();
//   static List<SavedTrain> favouritesTrain = List<SavedTrain>();
//   static List<Station> recentStation = List<Station>();
//   static SavedTrain nowSearching = new SavedTrain();

//   static final SharedPrefJson _instance = SharedPrefJson._internal();

//   factory SharedPrefJson() => _instance;

//   SharedPrefJson._internal() {
//     readSharedPreference();
//   }

//   void readSharedPreference() async {
//     var recents = await read(spRecentsTrains);
//     if (recents != null)
//       recentsTrains =
//           recents.map<SavedTrain>((e) => SavedTrain.fromJson(e)).toList();

//     var favourites = await read(spFavouritesTrains);
//     if (favourites != null)
//       favouritesTrain =
//           favourites.map<SavedTrain>((e) => SavedTrain.fromJson(e)).toList();

//     var recentStations = await read(spRecentsStations);
//     if (recentStations != null)
//       recentStation =
//           recentStations.map<Station>((e) => Station.fromJson(e)).toList();
//   }

//   static void addRecentTrain(SavedTrain t) {
//     if (recentsTrains.contains(t)) {
//       recentsTrains.remove(t);
//     } else if (recentsTrains.length == 3) recentsTrains.removeLast();
//     recentsTrains.insert(0, t);
//     save(spRecentsTrains, recentsTrains);
//   }

//   static void removeRecentTrain() {
//     SavedTrain trainToRemove;
//     for (final savedTrain in recentsTrains) {
//       trainToRemove = savedTrain.equals(
//           nowSearching.trainCode, nowSearching.departureStationCode);
//       if (trainToRemove != null) {
//         recentsTrains.remove(trainToRemove);
//         save(spRecentsTrains, recentsTrains);
//         return;
//       }
//     }
//   }

//   static void addFavourite() {
//     if (favouritesTrain.contains(nowSearching)) return;
//     favouritesTrain.insert(0, nowSearching);
//     save(spFavouritesTrains, favouritesTrain);
//   }

//   static void removeFavourite() {
//     SavedTrain trainToRemove;
//     for (final savedTrain in favouritesTrain) {
//       trainToRemove = savedTrain.equals(
//           nowSearching.trainCode, nowSearching.departureStationCode);
//       if (trainToRemove != null) {
//         favouritesTrain.remove(trainToRemove);
//         save(spFavouritesTrains, favouritesTrain);
//         return;
//       }
//     }
//   }

//   static bool isFavourite() {
//     for (final savedTrain in favouritesTrain) {
//       print(nowSearching.trainCode + "==" + savedTrain.trainCode);
//       if (nowSearching.trainCode == savedTrain.trainCode) return true;
//     }

//     return false;
//   }

//   static void addRecentStation(Station s) {
//     if (recentStation.contains(s)) {
//       recentStation.remove(s);
//     } else if (recentStation.length == 3) recentStation.removeLast();
//     recentStation.insert(0, s);
//     save(spRecentsStations, recentStation);
//   }

//   static Future<dynamic> read(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     if (!prefs.containsKey(key))
//       return null;
//     else
//       return json.decode(prefs.getString(key));
//   }

//   static save(String key, dynamic value) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(key, json.encode(value));
//   }

//   static remove(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove(key);
//   }
// }

// // singleton class for list of train
// class SP {
//   static List<SavedTrain> recentsTrains = List<SavedTrain>();
//   static List<SavedTrain> favouritesTrain = List<SavedTrain>();
//   static List<Station> recentStation = List<Station>();
//   static SavedTrain nowSearching = new SavedTrain();

//   static final SP _instance = SP._internal();

//   factory SP() => _instance;

//   SP._internal() {
//     readSP();
//   }

//   void readSP() async {
//     var recents = await read(spRecentsTrains);
//     if (recents != null)
//       recentsTrains =
//           recents.map<SavedTrain>((e) => SavedTrain.fromJson(e)).toList();

//     var favourites = await read(spFavouritesTrains);
//     if (favourites != null)
//       favouritesTrain =
//           favourites.map<SavedTrain>((e) => SavedTrain.fromJson(e)).toList();

//     var recentStations = await read(spRecentsStations);
//     if (recentStations != null)
//       recentStation =
//           recentStations.map<Station>((e) => Station.fromJson(e)).toList();
//   }

//   static void addRecentTrain(SavedTrain t) {
//     if (recentsTrains.contains(t)) {
//       recentsTrains.remove(t);
//     } else if (recentsTrains.length == 3) recentsTrains.removeLast();
//     recentsTrains.insert(0, t);
//     save(spRecentsTrains, recentsTrains);
//   }

//   static void removeRecentTrain() {
//     SavedTrain trainToRemove;
//     for (final savedTrain in recentsTrains) {
//       trainToRemove = savedTrain.equals(
//           nowSearching.trainCode, nowSearching.departureStationCode);
//       if (trainToRemove != null) {
//         recentsTrains.remove(trainToRemove);
//         save(spRecentsTrains, recentsTrains);
//         return;
//       }
//     }
//   }

//   static void addFavourite() {
//     if (favouritesTrain.contains(nowSearching)) return;
//     favouritesTrain.insert(0, nowSearching);
//     save(spFavouritesTrains, favouritesTrain);
//   }

//   static void removeFavourite() {
//     SavedTrain trainToRemove;
//     for (final savedTrain in favouritesTrain) {
//       trainToRemove = savedTrain.equals(
//           nowSearching.trainCode, nowSearching.departureStationCode);
//       if (trainToRemove != null) {
//         favouritesTrain.remove(trainToRemove);
//         save(spFavouritesTrains, favouritesTrain);
//         return;
//       }
//     }
//   }

//   static bool isFavourite() {
//     for (final savedTrain in favouritesTrain) {
//       if (nowSearching.trainCode == savedTrain.trainCode) return true;
//     }

//     return false;
//   }

//   static void addRecentStation(Station s) {
//     if (recentStation.contains(s)) {
//       recentStation.remove(s);
//     } else if (recentStation.length == 3) recentStation.removeLast();
//     recentStation.insert(0, s);
//     save(spRecentsStations, recentStation);
//   }

//   static Future<dynamic> read(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     if (!prefs.containsKey(key))
//       return null;
//     else
//       return json.decode(prefs.getString(key));
//   }

//   static save(String key, dynamic value) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(key, json.encode(value));
//   }

//   static remove(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove(key);
//   }
// }

// // Questi due metodi sotto vanno tolti perché ho già la classe singleton per la roba in memoria

// Future<List<SavedTrain>> fetchSharedPreferenceWithListOf(String s) async {
//   final pref = await SharedPrefJson.read(s);
//   if (pref == null) return null;
//   return (pref as List<dynamic>).map((e) => SavedTrain.fromJson(e)).toList();
// }

// Future<List<Station>> fetchRecentsStations(String s) async {
//   final pref = await SharedPrefJson.read(s);
//   if (pref == null) return [];
//   return (pref as List<dynamic>).map((e) => Station.fromJson(e)).toList();
// }
