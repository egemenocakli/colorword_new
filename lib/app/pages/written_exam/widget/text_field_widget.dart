import 'package:colorword_new/app/models/word_model.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:flutter/material.dart';

class ExamTextFieldWidget extends StatefulWidget {
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
  State<ExamTextFieldWidget> createState() => _ExamTextFieldWidgetState();
}

class _ExamTextFieldWidgetState extends State<ExamTextFieldWidget> {
  double fontSize = 26;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    changeFontSize();
  }

  void changeFontSize() {
    if (widget.word?.word != null && widget.word!.word!.length > 15 && widget.word!.word!.length < 20) {
      fontSize = fontSize - 4;
    } else if (widget.word!.word!.length > 20) {
      fontSize = fontSize - 6;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: TextField(
        style: TextStyle(
          fontFamily: AppConstants.fontFamilyManrope,
          letterSpacing: 10,
          fontSize: fontSize,
          color: Colors.white60,
        ),
        focusNode: widget.focusNode,
        textAlign: TextAlign.center,
        autocorrect: false,
        autofillHints: const [],
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
        controller: widget.controller,
        maxLines: 1,
        maxLength: widget.word?.word?.length ?? 1,
        autofocus: true,
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComplete,
        cursorColor: Colors.white12,
        decoration: InputDecoration(
          counterStyle: const TextStyle(color: Colors.white54),
          border: InputBorder.none,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white54),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.white),
          ),
        ),
      ),
    );
  }
}
