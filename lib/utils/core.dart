import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  Duration travelTime = arrival.difference(departure);
  int hours = travelTime.inHours;
  int minutes = travelTime.inMinutes.remainder(60);

  // Ignore hours if 0
  String hoursString = hours > 0 ? "${hours}h " : "";
  String minutesString = "${addZeroToNumberLowerThan10(minutes.toString())}m";

  // Return string like hhh mmm
  return "$hoursString$minutesString";
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
