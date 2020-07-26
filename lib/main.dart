import 'package:flutter/material.dart';
import './App.dart';

void main() {
  // =========================================================================
  // THEME COLORS
  // =========================================================================

  final primary = Color(0xff222222);
  final dimmed = Color(0xff838383);

  // =========================================================================
  // ENTRY POINT
  // =========================================================================

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'Avenir',
      textTheme: TextTheme(
        bodyText1: TextStyle(
          fontFamily: 'Avenir',
          fontSize: 16,
        ),
        bodyText2: TextStyle(
          fontFamily: 'Avenir',
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      primaryColor: primary,
      accentColor: dimmed,
    ),
    home: App(),
  ));
}
