import 'package:easy_localization/easy_localization.dart';

extension StringExtension on String {
  String get locale => this.tr();
  String get appDateFormat =>
      DateTime.tryParse(this) == null ? this : DateFormat('yyyy-MM-dd hh:mm').format(DateTime.parse(this));
}
