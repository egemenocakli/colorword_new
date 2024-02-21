import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:flutter/material.dart';

class EnterWordTextWidget extends StatelessWidget {
  const EnterWordTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Text(LocaleKeys.addNewWordPage_addNewWord.locale,
          style: MyTextStyle.midTextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
