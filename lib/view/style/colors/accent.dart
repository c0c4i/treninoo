import 'package:flutter/material.dart';
import '../theme.dart';
import 'shades.dart';

class Accent {
  static Color darker = Color.alphaBlend(Shades.dark, normal);
  static Color dark = Color.alphaBlend(Shades.dark, normal);
  static Color normal = kAccentColor;
  static Color light = normal.withValues(alpha: Shades.light);
  static Color lighter = normal.withValues(alpha: Shades.lighter);
  static Color lightest2 = normal.withValues(alpha: Shades.lightest2);
  static Color lightest1 = normal.withValues(alpha: Shades.lightest1);
}
