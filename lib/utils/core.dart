import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String addZeroToNumberLowerThan10(String n) {
  return (n.length < 2) ? "0$n" : n;
}

String formatDate(DateTime date) {
  return DateFormat("dd/MM/yyyy - HH:mm").format(date);
}

String formatDateDDMMYYYY(DateTime date) {
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
  return durationToString(travelTime);
}

String travelTimeSemantics(DateTime departure, DateTime arrival) {
  Duration travelTime = arrival.difference(departure);
  return durationToStringSemantics(travelTime);
}

String durationToString(Duration duration) {
  int days = duration.inDays;
  int hours = duration.inHours.remainder(24);
  int minutes = duration.inMinutes.remainder(60);

  List<String> parts = [];

  if (days > 0) parts.add('${days}d');
  if (hours > 0) parts.add('${hours}h');
  if (minutes > 0 || parts.isEmpty) parts.add('${minutes}m');

  return parts.join(' ');
}

String durationToStringSemantics(Duration duration) {
  int days = duration.inDays;
  int hours = duration.inHours.remainder(24);
  int minutes = duration.inMinutes.remainder(60);

  List<String> parts = [];

  if (days > 0) parts.add('${days} giorni');
  if (hours > 0) parts.add('${hours} ore');
  if (minutes > 0 || parts.isEmpty) parts.add('${minutes} minuti');

  return parts.join(' ');
}
