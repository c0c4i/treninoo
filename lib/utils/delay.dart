import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/ErrorColor.dart';
import 'package:treninoo/view/style/colors/success.dart';
import 'package:treninoo/view/style/colors/warning.dart';

class DelayUtils {
  static Color textColor(int? delay, bool isDark) {
    if (delay == null) return isDark ? Success.normal : Success.darker;
    if (delay <= 0) return isDark ? Success.normal : Success.darker;
    if (delay <= 15) return isDark ? Warning.normal : Warning.darker;
    return isDark ? ErrorColor.normal : ErrorColor.darker;
  }

  static Color color(int? delay) {
    if (delay == null) return Success.lighter;
    if (delay <= 0) return Success.lighter;
    if (delay <= 15) return Warning.lighter;
    return ErrorColor.lighter;
  }

  static String? title(int? delay) {
    if (delay == null) return null;
    if (delay > 0) return '+$delay min';
    if (delay < 0) return '$delay min';
    return 'In orario';
  }

  static String delay(int? delay) {
    if (delay == null) return '0';
    if (delay > 0) return '+$delay';
    if (delay < 0) return '$delay';
    return '0';
  }

  static String description(int? delay) {
    if (delay == 0) return 'In orario';
    return delay! < 0 ? 'Anticipo' : 'Ritardo';
  }
}
