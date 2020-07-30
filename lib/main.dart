import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:isa/helpers/dbProvider.dart';

import './App.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final camera = cameras.first;

  // =========================================================================
  // THEME COLORS
  // =========================================================================

  final primary = Color(0xff222222);
  final dimmed = Color(0xff838383);

  // =========================================================================
  // ENTRY POINT
  // =========================================================================

  DBProvider dbIsa = DBProvider();

  // db initialization
  dbIsa.initDB().then((res) => print('DB connection established ✨'));

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
    home: App(camera),
  ));
}
