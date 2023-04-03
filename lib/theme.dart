import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/*
Credit for file structure:
Developers, Stream. “Build a Flutter Chat App: 01 - Design/UI.” YouTube, YouTube, 20 Aug. 2021, 
  https://www.youtube.com/watch?v=vgqBc7jni8c. 

*/


abstract class GradTalkColors {
//colors used in the app
  static const secondary = Color(0xFF0C7CD5);
  static const primary = Color(0xFFc51a2d);
  static const darkFont = Color(0xFF53585A);
  static const lightFont = Color(0xFFF5F5F5);
  static const fadedText = Color(0xFF9899A5);
  static const iconLight = Color(0xFFB1B4C0);
  static const cardDark = Color(0x00a3cfa7);
}


abstract class _DarkColors {
  static const background = Color(0xFF1B1E1F);
  static const card = GradTalkColors.cardDark;
}


//Sets default color settings for the app.
class AppTheme {
  static const accentColor = GradTalkColors.primary;
  static final visualDensity = VisualDensity.adaptivePlatformDensity;


  /// Dark theme and its settings.
  static ThemeData dark() => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: _DarkColors.background,
    visualDensity: visualDensity,
    backgroundColor: _DarkColors.background,
    cardColor: _DarkColors.card,
    textTheme:
      GoogleFonts.interTextTheme().apply(bodyColor: GradTalkColors.lightFont),
    primaryTextTheme: const TextTheme(
      headline6: TextStyle(color: GradTalkColors.lightFont),
    ),
    iconTheme: const IconThemeData(color: GradTalkColors.iconLight),
  );
}