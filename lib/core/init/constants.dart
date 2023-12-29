import 'package:flutter/material.dart';

class AppConstants {
  static const localizationAssetPath = 'assets/translations';
  static const background = 'assets/images/background.png';
  static const googleIcon = 'assets/images/google_icon.png';
  static const appName = 'ColorWord';
  static const fontFamilyManrope = 'Manrope';
}

///TODO: GENEL RADİUS DEĞERİ oluştur

class ColorConstants {
  //HomePage
  static Color deleteButtonColor = Colors.redAccent;
  static Color learnedWordButton = Colors.green;
  static Color iconWhiteColor = Colors.white;
  //ExamPage
  static Color optionsButtonDefaultColor = Colors.black12;
  static Color optionsButtonCorrectColor = Colors.greenAccent;
  static Color optionsButtonWrongColor = Colors.redAccent;

  //_____________

  //General
  static Color backgroundColor = const Color(0xFFC5CAC4);
  static Color white = Colors.white;
  static Color transparent = Colors.transparent;
  static Color black = Colors.black;
  static Color buttonColor = const Color(0xFF6883BC);
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

class FontPackage {
  FontPackage._();

  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  static const IconData edit_alt = IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData edit = IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData pencil = IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData pencil_circled = IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData edit_circled = IconData(0xe804, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
