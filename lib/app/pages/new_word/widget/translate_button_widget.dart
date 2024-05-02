import 'package:colorword_new/app/pages/new_word/viewmodel/new_word_viewmodel.dart';
import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:flutter/material.dart';

class TranslateButtonWidget extends StatelessWidget {
  const TranslateButtonWidget({super.key, required this.viewModel});

  final NewWordViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            foregroundColor: ColorConstants.white,
            backgroundColor: ColorConstants.buttonColorPink,
            textStyle: const TextStyle(fontSize: 20)),
        onPressed: () async {
          viewModel.translatedWord = await viewModel.wordTranslate(word: viewModel.textController?.text) ??
              LocaleKeys.addNewWordPage_cantFindWord;
        },
        child: Text(LocaleKeys.addNewWordPage_translate.locale));
  }
}
