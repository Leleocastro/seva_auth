import 'package:flutter/material.dart';

class MainTheme {
  static ThemeData customLightTheme() {
    final ThemeData lightTheme = ThemeData.light();
    return lightTheme.copyWith(
      primaryColor: Colors.blueGrey,
      secondaryHeaderColor: Colors.indigo,
      indicatorColor: Colors.indigo,
      scaffoldBackgroundColor: Colors.grey.shade300,
      primaryTextTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        bodySmall: TextStyle(
          color: Colors.black,
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
      primaryTextTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        bodySmall: TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
      ),
      secondaryHeaderColor: Colors.indigo,
      indicatorColor: Colors.grey.shade300,
      primaryIconTheme: darkTheme.primaryIconTheme.copyWith(
        color: Colors.green,
        size: 20,
      ),
    );
  }
}
