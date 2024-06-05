import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.blue,
      elevation: 0,
      // brightness: Brightness.light,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.blue.shade400,
      secondary: Colors.green
          .shade400, // This is similar to accent color in previous versions
    ).copyWith(background: Colors.white),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      elevation: 0,
      // brightness: Brightness.dark,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.green.shade400,
      secondary: Colors.blue
          .shade400, // This is similar to accent color in previous versions
    ).copyWith(background: Colors.black),
  );
  static ThemeData? currentTheme = lightTheme; // Default to light theme

  static void applyLightTheme() {
    currentTheme = lightTheme;
  }

  static void applyDarkTheme() {
    currentTheme = darkTheme;
  }
}
