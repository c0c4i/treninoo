import 'package:flutter/material.dart';

class CustomColors {
  static Color customRed = const Color(0xFFC4152B); // or 0xFFC41329
  static Color customGreyNigthMode = const Color(0xff828282);
}

class CustomTheme {
  static ThemeData defaultMode = ThemeData(
    brightness: Brightness.light,
    primaryColor: CustomColors.customRed,
    accentColor: CustomColors.customRed,
    buttonColor: CustomColors.customRed,
    iconTheme: IconThemeData(
      color: CustomColors.customRed,
    ),
    errorColor: CustomColors.customRed,
    scaffoldBackgroundColor: Colors.white,
    buttonTheme: ButtonThemeData(
      buttonColor: CustomColors.customRed,
      shape: RoundedRectangleBorder(),
    ),
    hintColor: CustomColors.customRed,
    primaryTextTheme:
        TextTheme(body1: TextStyle(color: CustomColors.customRed)),
    cursorColor: CustomColors.customRed,
    textSelectionHandleColor: CustomColors.customRed,
    textTheme: TextTheme(
      display1: TextStyle(
        color: CustomColors.customRed,
        fontSize: 25,
      ),
      display2: TextStyle(fontSize: 25, color: Colors.white),
      display3: TextStyle(
        fontSize: 20.0,
        color: Colors.black,
      ),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
    ),
  );

  static ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    primaryColor: CustomColors.customGreyNigthMode,
    accentColor: CustomColors.customGreyNigthMode,
    focusColor: CustomColors.customGreyNigthMode,
    primaryTextTheme: TextTheme(body1: TextStyle(color: Colors.white)),
    scaffoldBackgroundColor: Color(0xff333333),
    iconTheme: IconThemeData(color: Colors.white),
    buttonColor: CustomColors.customGreyNigthMode,
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
}
