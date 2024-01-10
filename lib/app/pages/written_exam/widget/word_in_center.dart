import 'package:colorword_new/core/init/constants.dart';
import 'package:flutter/material.dart';

class WordInCenter extends StatelessWidget {
  const WordInCenter({super.key, required this.translatedWord});
  final String? translatedWord;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        maxLines: 2,
        translatedWord ?? '-',
        style: TextStyle(
          fontFamily: AppConstants.fontFamilyManrope,
          color: ColorConstants.white,
          fontSize: 26,
        ),
      ),
    );
  }
}
