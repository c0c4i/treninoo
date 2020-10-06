import 'package:provider/provider.dart';
import 'package:treninoo/settings.dart';
import 'package:flutter/material.dart';

class SingleNotifier extends ChangeNotifier {
  String _currentTheme;
  SingleNotifier(this._currentTheme);
  String get currentTheme => _currentTheme;
  updateTheme(String value) {
    if (value != _currentTheme) {
      _currentTheme = value;
      notifyListeners();
    }
  }
}

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}
