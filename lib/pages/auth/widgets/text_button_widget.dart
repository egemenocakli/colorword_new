import 'package:colorword_new/core/init/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageTextButtonWidget extends StatelessWidget {
  final BuildContext context;

  const LanguageTextButtonWidget({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomRight,
        height: 35,
        width: 45,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.black12,
            side: const BorderSide(width: 0.1, strokeAlign: 20, color: Colors.transparent),
          ),
          onPressed: () async {
            if (context.locale.toString() == 'en_US') {
              await EasyLocalization.of(context)!.setLocale(const Locale('tr', 'TR'));
            } else if (context.locale.toString() == 'tr_TR') {
              await EasyLocalization.of(context)!.setLocale(const Locale('en', 'US'));
            }
          },
          child:
              Text(context.locale.toString() == 'en_US' ? 'TR' : 'EN', style: TextStyle(color: ColorConstants.white)),
        ));
  }
}
