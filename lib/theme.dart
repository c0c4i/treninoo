import 'package:flutter/material.dart';

class CustomColors {
  static Color customRed = const Color(0xFFC4152B);
  static Color customGreyNigthMode = const Color(0xff828282);
}

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

MaterialColor color = new MaterialColor(0xFFC4152B, colorCodes);

class CustomTheme {
  static ThemeData defaultMode = ThemeData(
    brightness: Brightness.light,
    primaryColor: CustomColors.customRed,
    accentColor: CustomColors.customRed,
    buttonColor: CustomColors.customRed,
    primarySwatch: color,
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
