import 'package:flutter/material.dart';

class MyTextTheme {
  MyTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    // BIG TITLES
    headlineSmall: TextStyle().copyWith(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineMedium: TextStyle().copyWith(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineLarge: TextStyle().copyWith(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),

    // NORMAL TITLES
    titleSmall: TextStyle().copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    titleMedium: TextStyle().copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    titleLarge: TextStyle().copyWith(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),

    // BODY TEXTS
    bodySmall: TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    bodyMedium: TextStyle().copyWith(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    bodyLarge: TextStyle().copyWith(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),

    // LABELS AND SMALL TEXT
    labelSmall: TextStyle().copyWith(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    labelMedium: TextStyle().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    labelLarge: TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineSmall: TextStyle().copyWith(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineMedium: TextStyle().copyWith(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineLarge: TextStyle().copyWith(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),

    // NORMAL TITLES
    titleSmall: TextStyle().copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    titleMedium: TextStyle().copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    titleLarge: TextStyle().copyWith(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),

    // BODY TEXTS
    bodySmall: TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    bodyMedium: TextStyle().copyWith(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    bodyLarge: TextStyle().copyWith(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),

    // LABELS AND SMALL TEXT
    labelSmall: TextStyle().copyWith(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    labelMedium: TextStyle().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    labelLarge: TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
  );
}
