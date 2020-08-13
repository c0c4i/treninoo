import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// singleton class for recents and favourites train
class SharedPrefJson {
  static List<SavedTrain> recentsTrain = List<SavedTrain>();
  static List<SavedTrain> favouritesTrain = List<SavedTrain>();
  static SavedTrain nowSearching = new SavedTrain();

  static final SharedPrefJson _instance = SharedPrefJson._internal();

  factory SharedPrefJson() => _instance;

  SharedPrefJson._internal() {
    readSharedPreference();
  }

  void readSharedPreference() async {
    var recents = await read("recents");
    if (recents != null)
      recentsTrain =
          recents.map<SavedTrain>((e) => SavedTrain.fromJson(e)).toList();

    var favourites = await read("recents");
    if (recents != null)
      favouritesTrain =
          favourites.map<SavedTrain>((e) => SavedTrain.fromJson(e)).toList();
  }

  static void addRecent(SavedTrain t) {
    if (recentsTrain.contains(t)) return;
    if (recentsTrain.length == 3) recentsTrain.removeLast();
    recentsTrain.insert(0, t);
    save("recents", recentsTrain);
  }

  static void removeRecent(int trainCode) {
    SavedTrain trainToRemove;
    for (final savedTrain in recentsTrain) {
      trainToRemove = savedTrain.equals(trainCode);
      if (trainToRemove != null) {
        recentsTrain.remove(trainToRemove);
        save("favourites", recentsTrain);
        return;
      }
    }
  }

  static void addFavourite() {
    if (favouritesTrain.contains(nowSearching)) return;
    favouritesTrain.insert(0, nowSearching);
    save("favourites", favouritesTrain);
  }

  static void removeFavourite() {
    SavedTrain trainToRemove;
    for (final savedTrain in favouritesTrain) {
      trainToRemove = savedTrain.equals(int.parse(nowSearching.trainCode));
      if (trainToRemove != null) {
        favouritesTrain.remove(trainToRemove);
        save("favourites", favouritesTrain);
        return;
      }
    }
  }

  static bool isFavourite() {
    for (final savedTrain in favouritesTrain)
      if (nowSearching.trainCode == savedTrain.trainCode) return true;
    return false;
  }

  static Future<dynamic> read(String key) async {
    // if (hardCoded.containsKey(key)) return json.decode(hardCoded[key]);
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
