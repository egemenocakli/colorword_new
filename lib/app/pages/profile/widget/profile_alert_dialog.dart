import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:flutter/material.dart';

class ProfileAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String? confirmButtonText;
  final String? rejectButtonText;
  final Text? confirmTextWidget;
  final Text? rejectTextWidget;
  final Color? backgroundColor;
  final VoidCallback confirmOnPressed;
  final VoidCallback cancelOnPressed;

  const ProfileAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.confirmButtonText,
    this.rejectButtonText,
    this.confirmTextWidget,
    this.rejectTextWidget,
    this.backgroundColor,
    required this.confirmOnPressed,
    required this.cancelOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
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
                onPressed: cancelOnPressed,
                /* onPressed: () {
                  Navigator.pop(context, false);
                }, */
                child: rejectTextWidget ?? Text(rejectButtonText!, style: MyTextStyle.smallTextStyle()),
              ),
            TextButton(
              style: AllButtonStyle.alertDialog(
                  borderRadius: AllBorderRadius.mediumBorderRadius(),
                  backgroundColor: backgroundColor), //Colors.red.shade400),
              onPressed: confirmOnPressed,
              /* onPressed: () {
                Navigator.pop(context, true);
              }, */
              child: confirmTextWidget ??
                  Text(confirmButtonText ?? LocaleKeys.profilePage_confirm.locale, style: MyTextStyle.smallTextStyle()),
            ),
          ],
        );
      },
    );
  }
}
