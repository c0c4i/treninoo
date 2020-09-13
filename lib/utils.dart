import 'dart:collection';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

String shprRecentsTrains = 'recentsTrains';
String shprFavouritesTrains = 'favouritesTrains';
String shprRecentsStations = 'recentsStations';

// singleton class for recents and favourites train
class SharedPrefJson {
  static List<SavedTrain> recentsTrains = List<SavedTrain>();
  static List<SavedTrain> favouritesTrain = List<SavedTrain>();
  static List<Station> recentStation = List<Station>();
  static SavedTrain nowSearching = new SavedTrain();

  static final SharedPrefJson _instance = SharedPrefJson._internal();

  factory SharedPrefJson() => _instance;

  SharedPrefJson._internal() {
    readSharedPreference();
  }

  void readSharedPreference() async {
    var recents = await read(shprRecentsTrains);
    if (recents != null)
      recentsTrains =
          recents.map<SavedTrain>((e) => SavedTrain.fromJson(e)).toList();

    var favourites = await read(shprFavouritesTrains);
    if (favourites != null)
      favouritesTrain =
          favourites.map<SavedTrain>((e) => SavedTrain.fromJson(e)).toList();

    var recentStations = await read(shprRecentsStations);
    if (recentStations != null)
      recentStation =
          recentStations.map<Station>((e) => Station.fromJson(e)).toList();
  }

  static void addRecentTrain(SavedTrain t) {
    if (recentsTrains.contains(t)) {
      recentsTrains.remove(t);
    } else if (recentsTrains.length == 3) recentsTrains.removeLast();
    recentsTrains.insert(0, t);
    save(shprRecentsTrains, recentsTrains);
  }

  static void removeRecentTrain() {
    SavedTrain trainToRemove;
    for (final savedTrain in recentsTrains) {
      trainToRemove = savedTrain.equals(int.parse(nowSearching.trainCode));
      if (trainToRemove != null) {
        recentsTrains.remove(trainToRemove);
        save(shprRecentsTrains, recentsTrains);
        return;
      }
    }
  }

  static void addFavourite() {
    if (favouritesTrain.contains(nowSearching)) return;
    favouritesTrain.insert(0, nowSearching);
    save(shprFavouritesTrains, favouritesTrain);
  }

  static void removeFavourite() {
    SavedTrain trainToRemove;
    for (final savedTrain in favouritesTrain) {
      trainToRemove = savedTrain.equals(int.parse(nowSearching.trainCode));
      if (trainToRemove != null) {
        favouritesTrain.remove(trainToRemove);
        save(shprFavouritesTrains, favouritesTrain);
        return;
      }
    }
  }

  static bool isFavourite() {
    for (final savedTrain in favouritesTrain)
      if (nowSearching.trainCode == savedTrain.trainCode) return true;
    return false;
  }

  static void addRecentStation(Station s) {
    if (recentStation.contains(s)) {
      recentStation.remove(s);
    } else if (recentStation.length == 3) recentStation.removeLast();
    recentStation.insert(0, s);
    save(shprRecentsStations, recentStation);
  }

  static Future<dynamic> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key))
      return null;
    else
      return json.decode(prefs.getString(key));
  }

  static save(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  static remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}

class SavedTrain {
  String trainCode;
  String trainType;
  String departureStationCode;
  String departureStationName;
  String arrivalStationName;
  String departureTime;

  SavedTrain({
    this.trainCode,
    this.trainType,
    this.departureStationCode,
    this.departureStationName,
    this.arrivalStationName,
    this.departureTime,
  });

  Map<String, dynamic> toJson() => {
        'trainCode': trainCode,
        'trainType': trainType,
        'departureStationCode': departureStationCode,
        'departureStationName': departureStationName,
        'arrivalStationName': arrivalStationName,
        'departureTime': departureTime,
      };

  factory SavedTrain.fromJson(Map<String, dynamic> json) {
    return SavedTrain(
      trainCode: json['trainCode'],
      trainType: json['trainType'],
      departureStationCode: json['departureStationCode'],
      departureStationName: json['departureStationName'],
      arrivalStationName: json['arrivalStationName'],
      departureTime: json['departureTime'],
    );
  }

  SavedTrain equals(int trainCode) {
    return (trainCode.toString() == this.trainCode) ? this : null;
  }

  bool operator ==(Object other) {
    SavedTrain tmp = other;
    return (tmp.trainCode == trainCode);
  }
}

class Station {
  String stationName;
  String stationCode;

  Station({
    this.stationName,
    this.stationCode,
  });

  Map<String, dynamic> toJson() => {
        'stationName': stationName,
        'stationCode': stationCode,
      };

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      stationName: json['stationName'],
      stationCode: json['stationCode'],
    );
  }

  Station equals(int stationCode) {
    return (stationCode.toString() == this.stationCode) ? this : null;
  }

  bool operator ==(Object other) {
    Station tmp = other;
    return (tmp.stationCode == stationCode);
  }
}

Future<List<SavedTrain>> fetchSharedPreferenceWithListOf(String s) async {
  final pref = await SharedPrefJson.read(s);
  if (pref == null) return null;
  return (pref as List<dynamic>).map((e) => SavedTrain.fromJson(e)).toList();
}

Future<List<Station>> fetchRecentsStations(String s) async {
  final pref = await SharedPrefJson.read(s);
  if (pref == null) return null;
  return (pref as List<dynamic>).map((e) => Station.fromJson(e)).toList();
}
