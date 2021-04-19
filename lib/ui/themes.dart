import 'package:flutter/material.dart';

class Themes {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Manrope',
    primaryColor: Colors.black,
  );

  static const Map<String, Color> noteColours = {
    'blue': Color(0xFF3369ff),
    'yellow': Color(0xFFffda47),
    'white': Colors.white,
    'pink': Color(0xFFae3b76),
    'teal': Color(0xFF0aebaf),
    'orange': Color(0xFFff7746),
    'black': Color(0xFF0e121b),
  };

  static const darkBackgroundColor = Color(0xFF171c26);

  static const whiteBackgroundColor = Colors.white;

  static const bodyTextColour = Color(0xFF6f7788);

  static const dateTextColour = Color(0xFF60687b);

  static const tagBorderColour = Color(0xFF2f384c);

  static const TextStyle noteCardTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle noteCardBody = TextStyle(
    color: bodyTextColour,
    fontSize: 16,
    letterSpacing: 0.5,
    height: 1.5,
  );

  static const TextStyle noteCardDate = TextStyle(
    color: dateTextColour,
    fontSize: 14,
  );

  static const TextStyle notePageHeader = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
  );
}
