import 'package:flutter/material.dart';

class AppConstants {
  static const localizationAssetPath = 'assets/translations';
  static const background = 'assets/images/background.png'; //kaldırılacak
  static const googleIcon = 'assets/images/google_icon.png';
  static const appName = 'ColorWord';
  static const fontFamilyManrope = 'Manrope';
}

class ColorConstants {
  //HomePage
  static Color deleteButtonColor = Colors.redAccent;
  static Color learnedWordButton = Colors.green;
  static Color iconWhiteColor = Colors.white;
  //ExamPage
  static Color optionsButtonDefaultColor = Colors.black12;
  static Color optionsButtonCorrectColor = Colors.green.shade700;
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
  static Color alertCancelButton = Colors.red.shade400;
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
  static Color alertDialogBackgroundColor = const Color(0xFF43719c);
  static Color iconColor = const Color(0xFF273748);
  static Color iconOrangeAccentColor = Colors.orangeAccent;
  static Color iconShadeColor = Colors.black12;
  static Color grey = Colors.grey;
  static Color green = Colors.green;
  static Color optionShade = Colors.white24;
}

class SizeConstants {
  static double iconxSmallSize = 18;
  static double iconSmallSize = 24;
  static double iconMSize = 26;
  static double iconLSize = 28;
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

class MyTextStyle {
  ///FontSize:14  Color:Colors.white
  static TextStyle xsmallTextStyle(
      {double? fontSize,
      Color? textColor,
      TextOverflow? overflow,
      FontWeight? fontWeight,
      TextDecoration? decoration}) {
    return TextStyle(
        fontFamily: AppConstants.fontFamilyManrope,
        fontSize: (fontSize ?? 14),
        overflow: overflow,
        color: textColor ?? ColorConstants.white,
        fontWeight: fontWeight,
        decoration: decoration);
  }

  ///FontSize:16  Color:Colors.white
  static TextStyle smallTextStyle(
      {double? fontSize,
      Color? textColor,
      TextOverflow? overflow,
      FontWeight? fontWeight,
      TextDecoration? decoration}) {
    return TextStyle(
        fontFamily: AppConstants.fontFamilyManrope,
        fontSize: (fontSize ?? 16),
        overflow: overflow,
        color: textColor ?? ColorConstants.white,
        fontWeight: fontWeight,
        decoration: decoration);
  }

  ///FontSize:20  Color:Colors.white
  static TextStyle midTextStyle(
      {double? fontSize,
      Color? textColor,
      TextOverflow? overflow,
      FontWeight? fontWeight,
      TextDecoration? decoration}) {
    return TextStyle(
        fontFamily: AppConstants.fontFamilyManrope,
        fontSize: (fontSize ?? 20),
        overflow: overflow,
        color: textColor ?? ColorConstants.white,
        fontWeight: fontWeight,
        decoration: decoration);
  }

  ///FontSize:26  Color:Colors.white
  static TextStyle largeTextStyle(
      {double? fontSize,
      Color? textColor,
      TextOverflow? overflow,
      FontWeight? fontWeight,
      TextDecoration? decoration}) {
    return TextStyle(
        fontFamily: AppConstants.fontFamilyManrope,
        fontSize: (fontSize ?? 26),
        overflow: overflow,
        color: textColor ?? ColorConstants.white,
        fontWeight: fontWeight,
        decoration: decoration);
  }

  ///FontSize:32  Color:Colors.white
  static TextStyle xlargeTextStyle(
      {double? fontSize,
      Color? textColor,
      TextOverflow? overflow,
      FontWeight? fontWeight,
      TextDecoration? decoration}) {
    return TextStyle(
        fontFamily: AppConstants.fontFamilyManrope,
        fontSize: (fontSize ?? 32),
        overflow: overflow,
        color: textColor ?? ColorConstants.white,
        fontWeight: fontWeight,
        decoration: decoration);
  }
}

class AllBorderRadius {
  ///30
  static BorderRadius xlargeBorderRadius() {
    return BorderRadius.circular(30);
  }

  ///20
  static BorderRadius largeBorderRadius() {
    return BorderRadius.circular(20);
  }

  ///15
  static BorderRadius mediumBorderRadius() {
    return BorderRadius.circular(15);
  }

  ///12
  static BorderRadius smallBorderRadius() {
    return BorderRadius.circular(12);
  }
}

class AllButtonStyle {
  static ButtonStyle alertDialog({Color? backgroundColor, required BorderRadiusGeometry borderRadius}) {
    return ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(backgroundColor),
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: borderRadius)));
  }
}

Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>> mySnackbarWidget(
    {required Widget content, required Duration duration, required dynamic context}) async {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.black,
    showCloseIcon: true,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
    padding: const EdgeInsets.only(right: 5.0, left: 15.0, bottom: 8.0, top: 8.0),
    closeIconColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    content: content,
    duration: duration,
  ));
}
