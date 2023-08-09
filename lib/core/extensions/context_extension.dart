import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension LanguageLoader on BuildContext {
  Localizable get localizables => Localizable(this);
}

extension BuildContextExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}

class Localizable {
  final BuildContext context;

  Localizable(this.context);

  String get appTitle => ltr('appTitle');

  String get yes => ltr('yes');

  String get no => ltr('no');

  String get quoteAnime => ltr('quoteAnime');

  String darkModeTitle(bool enabled) => ltr('darkModeTitle', args: [enabled ? yes : no]);

  String localeTitle(String locale) => ltr('locale.$locale');

  String ltr(
    String key, {
    List<String>? args,
    Map<String, String>? namedArgs,
    String? gender,
  }) {
    EasyLocalization.of(context);
    return tr(key, args: args, namedArgs: namedArgs, gender: gender);
  }
}
