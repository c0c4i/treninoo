import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  late SharedPreferences _sharedPrefs;
  static const String SPrecentsTrains = 'recentsTrains';
  static const String SPfavouritesTrains = 'favouritesTrains';
  static const String SPrecentsStations = 'recentsStations';
  static const String SPDarkMode = 'darkMode';
  static const String SPFirstPage = 'first_page';
  static const String SPPredictedArrival = 'predicted_arrival';
  static const String SPShowFeature = 'show_feature_1';

  Future<void> setup() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  String? get recentsTrains => _sharedPrefs.getString(SPrecentsTrains);

  set recentsTrains(String? value) {
    _sharedPrefs.setString(SPrecentsTrains, value!);
  }

  String? get favouritesTrains => _sharedPrefs.getString(SPfavouritesTrains);

  set favouritesTrains(String? value) {
    _sharedPrefs.setString(SPfavouritesTrains, value!);
  }

  String? get recentsStations =>
      _sharedPrefs.getString(SPrecentsStations) ?? null;

  set recentsStations(String? value) {
    _sharedPrefs.setString(SPrecentsStations, value!);
  }

  int get firstPage => _sharedPrefs.getInt(SPFirstPage) ?? 0;

  set firstPage(int value) {
    _sharedPrefs.setInt(SPFirstPage, value);
  }

  bool get predictedArrival =>
      _sharedPrefs.getBool(SPPredictedArrival) ?? false;

  set predictedArrival(bool value) {
    _sharedPrefs.setBool(SPPredictedArrival, value);
  }

  bool get showFeature => _sharedPrefs.getBool(SPShowFeature) ?? true;

  set showFeature(bool value) {
    _sharedPrefs.setBool(SPShowFeature, value);
  }
}
