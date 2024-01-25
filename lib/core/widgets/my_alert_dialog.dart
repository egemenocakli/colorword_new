import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String? confirmButtonText;
  final String? rejectButtonText;
  final Text? confirmTextWidget;
  final Text? rejectTextWidget;

  const MyAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.confirmButtonText,
    this.rejectButtonText,
    this.confirmTextWidget,
    this.rejectTextWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: AllBorderRadius.mediumBorderRadius()),
      backgroundColor: ColorConstants.alertDialogBackgroundColor,
      title: Text(title, style: MyTextStyle.midTextStyle()),
      content: Text(content, style: MyTextStyle.smallTextStyle()),
      actions: <Widget>[
        if (rejectButtonText != null)
          TextButton(
            style: AllButtonStyle.alertDialog(
                borderRadius: AllBorderRadius.mediumBorderRadius(), backgroundColor: Colors.green.shade400),
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: rejectTextWidget ?? Text(rejectButtonText!, style: MyTextStyle.smallTextStyle()),
          ),
        TextButton(
          style: AllButtonStyle.alertDialog(
              borderRadius: AllBorderRadius.mediumBorderRadius(), backgroundColor: Colors.red.shade400),
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: confirmTextWidget ??
              Text(confirmButtonText ?? LocaleKeys.profilePage_confirm.locale, style: MyTextStyle.smallTextStyle()),
        ),
      ],
    );
  }
}
