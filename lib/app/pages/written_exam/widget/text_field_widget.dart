import 'package:colorword_new/app/models/word_model.dart';
import 'package:flutter/material.dart';

class ExamTextFieldWidget extends StatelessWidget {
  const ExamTextFieldWidget({
    super.key,
    required this.onChanged,
    required this.onEditingComplete,
    required this.controller,
    required this.focusNode,
    required this.word,
  });
  final void Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Word? word;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: TextField(
        style: const TextStyle(
          letterSpacing: 10,
          fontSize: 26,
          color: Colors.white60,
        ),
        //focusNode: focusNode[pageIndex],
        focusNode: focusNode,
        autocorrect: false,
        autofillHints: const [],
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
        controller: controller,
        maxLines: 1,
        maxLength: word?.word?.length ?? 1,
        autofocus: true,
        onChanged: onChanged,
        /* onChanged: (value) {
          setState(() {
            if (word?.word == controller.text) {
              viewModel.increasetheScore(point: 3, word: word);
              viewModel.examResultList[pageIndex] = true;
              nextPage();
              controller.clear();
            } else if (word?.word != controller.text && controller.text.length == word?.word?.length) {
              viewModel.mistakes = viewModel.mistakes - 1;
              if (viewModel.mistakes <= 0) {
                viewModel.decreasetheScore(point: 2, word: word);
                viewModel.examResultList[pageIndex] = false;
                nextPage();
                controller.clear();
                //TODO:Bilemediniz animasyonu
              }
            }
          });
        }, */
        onEditingComplete: onEditingComplete,
        /* onEditingComplete: () {
          if (word?.word == controller.text) {
            viewModel.increasetheScore(point: 3, word: word);
            viewModel.examResultList[pageIndex] = true;
            nextPage();
            controller.clear();
            //TODO:Bildiniz animasyonu
          }
        }, */
        cursorColor: Colors.white12,
        decoration: const InputDecoration(
          counterStyle: TextStyle(color: Colors.white54),
          border: InputBorder.none,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white54),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
