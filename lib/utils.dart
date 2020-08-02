import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPrefJson {
  static List<SavedTrain> recentsTrain = List<SavedTrain>();
  static List<SavedTrain> favouritesTrain;

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
    // favouritesTrain =
    //     (await read("favourites")).map((e) => SavedTrain.fromJson(e)).toList();
  }

  static void addRecents(SavedTrain t) {
    if (recentsTrain.contains(t)) return;
    if (recentsTrain.length == 3) recentsTrain.removeLast();
    recentsTrain.insert(0, t);
    save("recents", recentsTrain);
  }

  static Map<String, String> hardCoded = {
    "favourite": """
    [
      {
        "trainCode": "27",
        "trainType": "REG",
        "departureStationCode": "S02430",
        "departureStationName": "Verona Porta Nuova",
        "arrivalStationName": "Venezia Santa Lucia",
        "departureTime": "20:42"
      },
      {
        "trainCode": "2747",
        "trainType": "RV",
        "departureStationCode": "S02430",
        "departureStationName": "Verona Porta Nuova",
        "arrivalStationName": "Venezia Santa Lucia",
        "departureTime": "22:21"
      },
      {
        "trainCode": "27",
        "trainType": "REG",
        "departureStationCode": "S02430",
        "departureStationName": "Verona Porta Nuova",
        "arrivalStationName": "Venezia Santa Lucia",
        "departureTime": "20:42"
      },
      {
        "trainCode": "2747",
        "trainType": "RV",
        "departureStationCode": "S02430",
        "departureStationName": "Verona Porta Nuova",
        "arrivalStationName": "Venezia Santa Lucia",
        "departureTime": "22:21"
      },
      {
        "trainCode": "27",
        "trainType": "REG",
        "departureStationCode": "S02430",
        "departureStationName": "Verona Porta Nuova",
        "arrivalStationName": "Venezia Santa Lucia",
        "departureTime": "20:42"
      },
      {
        "trainCode": "2747",
        "trainType": "RV",
        "departureStationCode": "S02430",
        "departureStationName": "Verona Porta Nuova",
        "arrivalStationName": "Venezia Santa Lucia",
        "departureTime": "22:21"
      }
    ]
    """
  };

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
  final String trainCode;
  final String trainType;
  final String departureStationCode;
  final String departureStationName;
  final String arrivalStationName;
  final String departureTime;

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

  bool operator ==(Object other) {
    SavedTrain tmp = other;
    return (tmp.trainCode == trainCode);
  }
}
