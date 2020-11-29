// import 'package:provider/provider.dart';
// import 'package:treninoo/view/pages/Settings.dart';
import 'package:flutter/material.dart';

class SingleNotifier extends ChangeNotifier {
  String _currentTheme;
  int _startPage;
  SingleNotifier(this._currentTheme, this._startPage);
  String get currentTheme => _currentTheme;
  int get startPage => _startPage;

  updateTheme(String value) {
    if (value != _currentTheme) {
      _currentTheme = value;
      notifyListeners();
    }
  }

  updatePage(int value) {
    if (value != _startPage) {
      _startPage = value;
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
