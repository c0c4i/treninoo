
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences _sharedPrefs;
  static const String SPrecentsTrains = 'recentsTrains';
  static const String SPfavouritesTrains = 'favouritesTrains';
  static const String SPrecentsStations = 'recentsStations';
  static const String SPDarkMode = 'darkMode';

  init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  String get recentsTrains => _sharedPrefs.getString(SPrecentsTrains) ?? null;

  set recentsTrains(String value) {
    _sharedPrefs.setString(SPrecentsTrains, value);
  }

  String get favouritesTrains =>
      _sharedPrefs.getString(SPfavouritesTrains) ?? null;

  set favouritesTrains(String value) {
    _sharedPrefs.setString(SPfavouritesTrains, value);
  }

  String get recentsStations =>
      _sharedPrefs.getString(SPrecentsStations) ?? null;

  set recentsStations(String value) {
    _sharedPrefs.setString(SPrecentsStations, value);
  }
}

final sharedPrefs = SharedPrefs();
