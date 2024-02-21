import 'package:colorword_new/app/pages/new_word/viewmodel/new_word_viewmodel.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:flutter/material.dart';

class AddWordFabButtonWidget extends StatelessWidget {
  const AddWordFabButtonWidget({super.key, required this.viewModel, required this.onPressed});

  final NewWordViewModel viewModel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: ColorConstants.buttonColor,
        foregroundColor: ColorConstants.white,
        onPressed:
            onPressed, //viewModel.translateResponse != null && viewModel.translateResponse != "" ? addWord : null,
        child: const Icon(
          Icons.task_alt_outlined,
          size: 28,
        ));
  }
}
