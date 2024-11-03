import 'dart:ui';

import 'package:treninoo/view/style/colors/ErrorColor.dart';
import 'package:treninoo/view/style/colors/success.dart';
import 'package:treninoo/view/style/colors/warning.dart';

class DelayUtils {
  static Color textColor(int? delay) {
    if (delay == null) return Success.darker;
    if (delay <= 0) return Success.darker;
    if (delay <= 15) return Warning.darker;
    return ErrorColor.darker;
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

  static String description(int? delay) {
    if (delay == 0) return 'In orario';
    return delay! < 0 ? 'Anticipo' : 'Ritardo';
  }
}
