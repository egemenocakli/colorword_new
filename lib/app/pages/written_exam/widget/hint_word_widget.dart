import 'package:colorword_new/core/init/constants.dart';
import 'package:flutter/material.dart';

class HintWordWidget extends StatelessWidget {
  const HintWordWidget({super.key, required this.hintText});
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text(
        hintText,
        style: TextStyle(
          fontFamily: AppConstants.fontFamilyManrope,
          color: ColorConstants.white,
          fontSize: 18,
        ),
      ),
    );
  }
}
