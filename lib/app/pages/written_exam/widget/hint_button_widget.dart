import 'package:colorword_new/core/init/constants.dart';
import 'package:flutter/material.dart';

class HintButtonWidget extends StatelessWidget {
  const HintButtonWidget({
    super.key,
    required this.onTap,
  });

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: AllBorderRadius.xlargeBorderRadius(), color: ColorConstants.iconShadeColor),
      height: 40,
      width: 40,
      child: Material(
        color: ColorConstants.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: AllBorderRadius.xlargeBorderRadius(),
          ),
          onTap: onTap,
          child: Icon(
            Icons.lightbulb_outlined,
            color: ColorConstants.iconOrangeAccentColor,
            size: SizeConstants.iconMSize,
          ),
        ),
      ),
    );
  }
}
