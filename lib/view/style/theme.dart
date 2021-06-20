import 'package:flutter/material.dart';

class CustomColors {
  static Color customRed = const Color(0xFFC4152B);
  static Color customGreyNigthMode = const Color(0xff828282);
}

class AppColors {
  static Color red = const Color(0xFFC4152B);
  static Color error = const Color(0xFFC4152B);
  static Color lightRed = const Color(0x1CC4152B);
  static Color black = Colors.black;
  static Color secondaryGrey = const Color(0xFF979797);
  static Color thinGrey = const Color(0xFFEAEEF4);
  static Color backgroundGrey = const Color(0xFFF7F9FC);
  static Color borderGrey = const Color(0xFFE4E9F2);
  static Color textGrey = const Color(0xFF8F9BB3);
  // static Color customGreyNigthMode = const Color(0xff828282);
}

class DialogColor {
  static const Color lightGrey = const Color(0xFFEFF1F6);
  static const Color darkGrey = const Color(0xFF5B5C5E);
}

// custom red material color for app
Map<int, Color> colorCodes = {
  50: Color.fromRGBO(196, 21, 43, .1),
  100: Color.fromRGBO(196, 21, 43, .2),
  200: Color.fromRGBO(196, 21, 43, .3),
  300: Color.fromRGBO(196, 21, 43, .4),
  400: Color.fromRGBO(196, 21, 43, .5),
  500: Color.fromRGBO(196, 21, 43, .6),
  600: Color.fromRGBO(196, 21, 43, .7),
  700: Color.fromRGBO(196, 21, 43, .8),
  800: Color.fromRGBO(196, 21, 43, .9),
  900: Color.fromRGBO(196, 21, 43, 1),
};

MaterialColor primarySwatch = new MaterialColor(0xFFC4152B, colorCodes);

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Cabin',
    brightness: Brightness.light,
    primaryColor: AppColors.red,
    accentColor: AppColors.red,
    buttonColor: AppColors.red,
    primarySwatch: primarySwatch,
    iconTheme: IconThemeData(
      color: AppColors.textGrey,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.backgroundGrey,
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.borderGrey,
          width: 1,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.borderGrey,
          width: 1,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.borderGrey,
          width: 1,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.borderGrey,
          width: 1,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.error,
          width: 1,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.error,
          width: 1,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      labelStyle: TextStyle(color: AppColors.textGrey),
    ),
    errorColor: AppColors.error,
    scaffoldBackgroundColor: Colors.white,
    buttonTheme: ButtonThemeData(
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
    ),
  );
}

final lightTheme = ThemeData(
  fontFamily: 'Cabin',
  brightness: Brightness.light,
  primaryColor: AppColors.red,
  accentColor: AppColors.red,
  buttonColor: AppColors.red,
  primarySwatch: primarySwatch,
  iconTheme: IconThemeData(
    color: AppColors.textGrey,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: AppColors.backgroundGrey,
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.borderGrey,
        width: 1,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.borderGrey,
        width: 1,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.borderGrey,
        width: 1,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.borderGrey,
        width: 1,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.error,
        width: 1,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.error,
        width: 1,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    labelStyle: TextStyle(color: AppColors.textGrey),
  ),
  errorColor: AppColors.error,
  scaffoldBackgroundColor: Colors.white,
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: CustomColors.customGreyNigthMode,
  accentColor: CustomColors.customGreyNigthMode,
  focusColor: CustomColors.customGreyNigthMode,
  primaryTextTheme: TextTheme(body1: TextStyle(color: Colors.white)),
  scaffoldBackgroundColor: Color(0xff333333),
  iconTheme: IconThemeData(color: Colors.white),
  buttonColor: CustomColors.customGreyNigthMode,
  primarySwatch: Colors.grey,
  cursorColor: CustomColors.customGreyNigthMode,
  textSelectionHandleColor: CustomColors.customGreyNigthMode,
  textTheme: TextTheme(
    display1: TextStyle(
      color: Colors.white,
      fontSize: 25,
    ),
    display2: TextStyle(fontSize: 25, color: Colors.white),
    display3: TextStyle(
      fontSize: 20.0,
      color: Colors.white,
    ),
  ),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0))),
  ),
);
