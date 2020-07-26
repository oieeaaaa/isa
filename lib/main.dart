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
      primaryColor: primary,
      accentColor: dimmed,
    ),
    home: App(),
  ));
}
