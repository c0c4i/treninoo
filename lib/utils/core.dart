import 'package:flutter/material.dart';
import 'package:treninoo/view/pages/old/Settings.dart';
import 'package:treninoo/view/style/theme.dart';

String addZeroToNumberLowerThan10(String n) {
  return (n.length < 2) ? "0$n" : n;
}

String formatDate(DateTime d) {
  String day = addZeroToNumberLowerThan10(d.day.toString());
  String month = addZeroToNumberLowerThan10(d.month.toString());
  String year = addZeroToNumberLowerThan10(d.year.toString());

  return "$day/$month/$year";
}

String formatTime(DateTime d) {
  String hour = addZeroToNumberLowerThan10(d.hour.toString());
  String minute = addZeroToNumberLowerThan10(d.minute.toString());

  return "$hour:$minute";
}

String travelTime(DateTime departure, DateTime arrival) {
  Duration time = arrival.difference(departure);
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(time.inMinutes.remainder(60));
  return "${twoDigits(time.inHours)}h $twoDigitMinutes\m";
}

// ThemeData getThemeFromString(String value) {
//   int n = themes.indexOf(value);
//   switch (n) {
//     case 0:
//       return lightTheme;
//     case 1:
//       return darkTheme;
//   }
// }
