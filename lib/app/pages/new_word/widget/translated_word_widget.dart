import 'package:colorword_new/app/pages/new_word/viewmodel/new_word_viewmodel.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:flutter/material.dart';

class TranslatedWordWidget extends StatelessWidget {
  const TranslatedWordWidget({super.key, required this.viewModel});

  final NewWordViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
        child: Text(viewModel.translatedWord,
            style: MyTextStyle.largeTextStyle(fontWeight: FontWeight.w300, fontSize: 24)),
      ),
    );
  }
}
