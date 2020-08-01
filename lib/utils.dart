import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPrefJson {
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
    """,
    "recents": """
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
        "trainCode": "27",
        "trainType": "REG",
        "departureStationCode": "S02430",
        "departureStationName": "Verona Porta Nuova",
        "arrivalStationName": "Venezia Santa Lucia",
        "departureTime": "20:42"
      }
    ]
    """
  };

  static Future<dynamic> read(String key) async {
    if (hardCoded.containsKey(key)) return json.decode(hardCoded[key]);
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
}
