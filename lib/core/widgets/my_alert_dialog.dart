import 'package:colorword_new/core/init/constants.dart';
import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmButtonText;
  final String? rejectButtonText;

  const MyAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.confirmButtonText,
    this.rejectButtonText,
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
            child: Text(rejectButtonText!, style: MyTextStyle.smallTextStyle()),
          ),
        TextButton(
          style: AllButtonStyle.alertDialog(
              borderRadius: AllBorderRadius.mediumBorderRadius(), backgroundColor: Colors.red.shade400),
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text(confirmButtonText, style: MyTextStyle.smallTextStyle()),
        ),
      ],
    );
  }
}
