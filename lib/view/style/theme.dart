import 'package:flutter/material.dart';

import 'colors/grey.dart';

Color kPrimaryColor = const Color(0xFFC4152B);
Color kAccentColor = const Color(0xFF006400);
Color kErrorColor = const Color(0xFFF03738);

Color kSuccessColor = const Color(0xFF4BB543);
Color kWarningColor = const Color(0xFFF3BB1C);
Color kGreyColor = const Color(0xFFC2C9D1);
Color kBlackColor = Colors.black;
Color kWhiteColor = Colors.white;

const double kRadius = 16.0;
const double kPadding = 12.0;
const double kPagePadding = 24.0;
const double kButtonPadding = 16.0;

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: false,
    colorScheme: ColorScheme(
      primary: kPrimaryColor,
      secondary: kPrimaryColor,
      surface: Colors.white,
      background: Grey.lightest2,
      error: kErrorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      onBackground: Colors.black,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
    fontFamily: "Cabin",
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Grey.lightest1,
      filled: true,
      labelStyle: TextStyle(
        color: Grey.dark,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Grey.light,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(kRadius)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Grey.light,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(kRadius)),
      ),
      prefixStyle: TextStyle(
        color: kGreyColor.withOpacity(0.75),
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: false,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: kPrimaryColor,
      secondary: kPrimaryColor,
    ),
    fontFamily: "Cabin",
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Grey.lightest1,
      filled: true,
      labelStyle: TextStyle(
        color: Grey.dark,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Grey.light,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(kRadius)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Grey.light,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(kRadius)),
      ),
      prefixStyle: TextStyle(
        color: kGreyColor.withOpacity(0.75),
      ),
    ),
  );
}
