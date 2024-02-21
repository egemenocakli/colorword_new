import 'package:colorword_new/app/pages/new_word/viewmodel/new_word_viewmodel.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:flutter/material.dart';

class SelectLanguage extends StatelessWidget {
  const SelectLanguage({
    super.key,
    required this.translateLanguage,
    required this.sourceLanguage,
    required this.viewModel,
  });

  final String translateLanguage;
  final String sourceLanguage;
  final NewWordViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          alignment: Alignment.center,
          height: 80,
          width: 60,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: ColorConstants.optionsButtonDefaultColor,
              side: BorderSide(width: 0.1, strokeAlign: 20, color: ColorConstants.transparent),
            ),
            onPressed: (null),
            child: Text(
              translateLanguage,
              style: MyTextStyle.smallTextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
        IconButton(
            onPressed: () async {
              await viewModel.changeLanguage();
            },
            icon: const Icon(Icons.cached_outlined)),
        Container(
          alignment: Alignment.center,
          height: 80,
          width: 60,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: ColorConstants.optionsButtonDefaultColor,
              side: const BorderSide(width: 0.1, strokeAlign: 20, color: Colors.transparent),
            ),
            onPressed: (null),
            child: Text(
              sourceLanguage,
              style: MyTextStyle.smallTextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        )
      ],
    );
  }
}
