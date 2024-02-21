import 'package:colorword_new/core/init/constants.dart';
import 'package:flutter/material.dart';

class SkipButtonWidget extends StatelessWidget {
  const SkipButtonWidget({super.key, required this.onTap});
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
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
              Icons.next_plan_outlined,
              color: ColorConstants.white,
              size: SizeConstants.iconMSize,
            ),
          ),
        ),
      ),
    );
  }
}
