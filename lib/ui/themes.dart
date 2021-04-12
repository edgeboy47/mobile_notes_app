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

  static const TextStyle noteCardTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
}
