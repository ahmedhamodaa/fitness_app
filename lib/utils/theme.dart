// utils/theme.dart
import 'package:flutter/material.dart';
import 'constants.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: Constants.primaryColor,
  primaryColorDark: Constants.secondaryColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Constants.primaryColor,
    secondary: Constants.accentColor,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Constants.primaryColor,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Constants.primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Constants.defaultRadius),
    ),
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Constants.primaryColor,
      foregroundColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.defaultRadius),
      ),
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Constants.primaryColor,
      side: BorderSide(color: Constants.primaryColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.defaultRadius),
      ),
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: Constants.primaryColor),
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: Constants.headline1Size,
      fontWeight: FontWeight.bold,
      color: Constants.darkText,
    ),
    headlineMedium: TextStyle(
      fontSize: Constants.headline2Size,
      fontWeight: FontWeight.bold,
      color: Constants.darkText,
    ),
    titleLarge: TextStyle(
      fontSize: Constants.headline3Size,
      fontWeight: FontWeight.bold,
      color: Constants.darkText,
    ),
    bodyLarge: TextStyle(
      fontSize: Constants.bodySize,
      color: Constants.darkText,
    ),
    bodyMedium: TextStyle(
      fontSize: Constants.bodySize,
      color: Constants.mediumText,
    ),
    bodySmall: TextStyle(
      fontSize: Constants.captionSize,
      color: Constants.mediumText,
    ),
  ),
  cardTheme: CardTheme(
    elevation: 2,
    margin: EdgeInsets.symmetric(vertical: 8.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Constants.defaultRadius),
    ),
  ),
  dividerTheme: DividerThemeData(
    color: Constants.dividerColor,
    thickness: 1.0,
    space: 1.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Constants.primaryColor,
    unselectedItemColor: Constants.mediumText,
    type: BottomNavigationBarType.fixed,
    elevation: 8.0,
  ),
  chipTheme: ChipThemeData(
    backgroundColor: Constants.lightGreen,
    disabledColor: Constants.lightText,
    selectedColor: Constants.primaryColor,
    secondarySelectedColor: Constants.accentColor,
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
    labelStyle: TextStyle(color: Constants.darkText),
    secondaryLabelStyle: TextStyle(color: Colors.white),
    brightness: Brightness.light,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Constants.defaultRadius),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Constants.defaultRadius),
      borderSide: BorderSide(color: Constants.primaryColor, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Constants.defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 1.0),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
  ),
);
