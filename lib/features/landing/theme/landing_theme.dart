import 'package:flutter/material.dart';

abstract final class LandingTheme {
  // A cor principal e a família tipográfica vêm do BarberHub/develop.
  static const orange = Color(0xFFEE8A3C);
  static const orangeDark = Color(0xFFB4530F);
  static const ink = Color(0xFF171715);
  static const cream = Color(0xFFF6F3ED);
  static const paper = Color(0xFFFEFDF9);
  static const muted = Color(0xFF66665F);
  static const line = Color(0xFFDEDCD4);
  static const darkLine = Color(0xFF393934);

  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    fontFamily: 'Barlow',
    scaffoldBackgroundColor: cream,
    colorScheme: ColorScheme.fromSeed(
      seedColor: orange,
      primary: ink,
      secondary: orange,
      surface: paper,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 16, height: 1.5, color: ink),
      bodyLarge: TextStyle(fontSize: 18, height: 1.5, color: ink),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: ink,
        foregroundColor: paper,
        minimumSize: const Size(0, 52),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle: const TextStyle(
          fontFamily: 'Barlow',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ink,
        minimumSize: const Size(44, 44),
        textStyle: const TextStyle(
          fontFamily: 'Barlow',
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
