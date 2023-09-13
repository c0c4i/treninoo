import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {
  static setAppBarBrightness(bool isDark) {
    Brightness brightness =
        Platform.isAndroid ? Brightness.dark : Brightness.light;

    if (isDark) {
      brightness = Platform.isAndroid ? Brightness.light : Brightness.dark;
    }

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness,
    ));
  }

  // Parse timestamp to TimeOfDay
  static TimeOfDay? timestampToTimeOfDay(int? timeStampMillisecond) {
    if (timeStampMillisecond == null) return null;

    DateTime date =
        new DateTime.fromMillisecondsSinceEpoch(timeStampMillisecond);

    return TimeOfDay.fromDateTime(date);
  }
}
