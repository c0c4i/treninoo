import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final String LOCALE = " GMT+0200";

String addZeroToNumberLowerThan10(String n) {
  return (n.length < 2) ? "0$n" : n;
}

String formatDate(DateTime date) {
  return DateFormat("dd/MM/yyyy").format(date);
}

String formatTime(DateTime date) {
  return DateFormat("HH:mm").format(date);
}

String formatTimeOfDay(TimeOfDay time) {
  DateTime date = DateTime(0, 0, 0, time.hour, time.minute);
  return DateFormat("HH:mm").format(date);
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
