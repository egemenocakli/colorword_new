import 'package:colorword_new/core/enums/enum.dart';
import 'package:easy_localization/easy_localization.dart';

extension StringExtension on String {
  String get locale => this.tr();
  String get appDateFormat =>
      DateTime.tryParse(this) == null ? this : DateFormat('yyyy-MM-dd hh:mm').format(DateTime.parse(this));
}

extension LanguageEnumExtension on TranslateLanguages {
  String get languageShortName {
    switch (this) {
      case TranslateLanguages.turkish:
        return "TR";
      case TranslateLanguages.english:
        return "EN";
      case TranslateLanguages.bulgarian:
        return "BG";
      case TranslateLanguages.german:
        return "DE";
      case TranslateLanguages.spanish:
        return "ES";
      default:
        return "There is no Language";
    }
  }
}
