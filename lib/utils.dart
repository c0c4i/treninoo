import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class SharedPrefJson {
  static Map<String, String> hardCoded = {
    "favorites": """
    [
      {
        "favTrainCode": "27",
        "favTrainType": "REG",
        "favDepartureStationCode": "S02430",
        "favDepartureStationName": "Verona Porta Nuova",
        "favArrivalStationName": "Venezia Santa Lucia",
        "favDepartureTime": "20:42"
      },
      {
        "favTrainCode": "2747",
        "favTrainType": "RV",
        "favDepartureStationCode": "S02430",
        "favDepartureStationName": "Verona Porta Nuova",
        "favArrivalStationName": "Venezia Santa Lucia",
        "favDepartureTime": "22:21"
      }
    ]
    """
  };

  static Future<dynamic> read(String key) async {
    if (hardCoded.containsKey(key))
      return json.decode(hardCoded[key]);
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