import 'package:flutter/material.dart';
import 'package:treninoo/view/pages/Settings.dart';
import 'package:treninoo/view/style/theme.dart';

String addZeroToNumberLowerThan10(String n) {
  return (n.length < 2) ? "0$n" : n;
}

String getCustomDate(DateTime d) {
  String day = addZeroToNumberLowerThan10(d.day.toString());
  String month = addZeroToNumberLowerThan10(d.month.toString());
  String year = addZeroToNumberLowerThan10(d.year.toString());

  return "$day/$month/$year";
}

String getCustomTime(DateTime d) {
  String hour = addZeroToNumberLowerThan10(d.hour.toString());
  String minute = addZeroToNumberLowerThan10(d.minute.toString());

  return "$hour:$minute";
}

ThemeData getThemeFromString(String value) {
  int n = themes.indexOf(value);
  switch (n) {
    case 0:
      return lightTheme;
    case 1:
      return darkTheme;
  }
}
