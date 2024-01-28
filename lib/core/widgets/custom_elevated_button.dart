import 'package:colorword_new/core/init/constants.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      required this.onPressed,
      required this.onButtonText,
      this.textColor,
      this.buttonColor,
      this.fontWeight});

  final VoidCallback onPressed;
  final String onButtonText;
  final FontWeight? fontWeight;
  final Color? textColor;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor ?? Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: AllBorderRadius.smallBorderRadius(),
        ),
      ),
      child: Text(onButtonText,
          style: MyTextStyle.smallTextStyle(
              textColor: textColor ?? ColorConstants.white, fontWeight: fontWeight ?? FontWeight.w700)),
    );
  }
}
