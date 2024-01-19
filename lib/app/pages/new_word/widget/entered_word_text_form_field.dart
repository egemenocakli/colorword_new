import 'package:colorword_new/app/pages/new_word/viewmodel/new_word_viewmodel.dart';
import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:flutter/material.dart';

class EnteredWordTextFormField extends StatelessWidget {
  const EnteredWordTextFormField({super.key, required this.viewModel});

  final NewWordViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 15),
      child: TextFormField(
        maxLines: (viewModel.textController!.text.length > 30) ? 2 : 1,
        maxLength: 50,
        controller: viewModel.textController,
        style: MyTextStyle.midTextStyle(fontWeight: FontWeight.w600, overflow: TextOverflow.fade),
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: AllBorderRadius.xlargeBorderRadius(),
                borderSide: BorderSide(color: ColorConstants.buttonColorPink)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.grey),
              borderRadius: AllBorderRadius.xlargeBorderRadius(),
            ),
            labelText: LocaleKeys.addNewWordPage_enterNewWord.locale,
            labelStyle: MyTextStyle.smallTextStyle(fontWeight: FontWeight.w400)),
      ),
    );
  }
}
