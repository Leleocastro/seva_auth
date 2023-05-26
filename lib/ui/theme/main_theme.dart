import 'package:flutter/material.dart';

class MainTheme {
  static ThemeData customLightTheme() {
    final ThemeData lightTheme = ThemeData.light();
    return lightTheme.copyWith(
      primaryColor: Colors.blueGrey,
      secondaryHeaderColor: Colors.indigo,
      indicatorColor: Colors.grey.shade300,
      hintColor: Colors.lime,
      scaffoldBackgroundColor: Colors.grey.shade300,
      primaryTextTheme: TextTheme(
        bodyMedium: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        bodySmall: TextStyle(
          color: lightTheme.hintColor,
          fontSize: 14,
        ),
      ),
      primaryIconTheme: lightTheme.primaryIconTheme.copyWith(
        color: Colors.white,
        size: 20,
      ),
      iconTheme: lightTheme.iconTheme.copyWith(
        color: Colors.white,
      ),
    );
  }

  static ThemeData customDarkTheme() {
    final ThemeData darkTheme = ThemeData.dark();
    return darkTheme.copyWith(
      primaryColor: Colors.blueGrey,
      primaryTextTheme: TextTheme(
        bodyMedium: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        bodySmall: TextStyle(
          color: darkTheme.hintColor,
          fontSize: 14,
        ),
      ),
      hintColor: Colors.lime,
      secondaryHeaderColor: Colors.indigo,
      indicatorColor: Colors.grey.shade300,
      primaryIconTheme: darkTheme.primaryIconTheme.copyWith(
        color: Colors.green,
        size: 20,
      ),
    );
  }
}
