import 'package:flutter/material.dart';

class AppConstants {
  static const localizationAssetPath = 'assets/translations';
  static const background = 'assets/images/background.png';
  static const appName = 'ColorWord';
}

class ColorConstants {
  //HomePage
  static Color deleteButtonColor = Colors.redAccent;
  static Color learnedWordButton = Colors.green;
  static Color iconWhiteColor = Colors.white;
  //_____________

  //General
  static Color backgroundColor = const Color(0xFFC5CAC4);
  static Color white = Colors.white;
  static Color transparent = Colors.transparent;
  static Color black = Colors.black;
  static Color buttonColor = const Color(0xFF68B2A0);
  static Color greySh4 = Colors.grey.shade300;
  static Color buttonColorPink = const Color(0xFFCD6688);
  static List<Color> appBarColors = [
    const Color(0xFF6868AC),
    const Color(0xFFCF9893),
    const Color(0xFF119DA4),
    const Color(0xFFFDE789)
  ];
  static List<Color> backgroundGradientColors = [
    const Color(0xFF6868AC),
    const Color(0xFF119DA4),
  ];
  static Color iconColor = const Color(0xFF273748);
}

class SizeConstants {
  static double iconSize = 28;
  static double appBarLargeIconSize = 32;
  static double appBarMediumIconSize = 30;
  static double wordBetweenSize = 20;
}
