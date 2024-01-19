import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:flutter/material.dart';

class EndOfExamResultWidget extends StatelessWidget {
  const EndOfExamResultWidget(
      {super.key, required this.totalQuestions, required this.correctAnswers, required this.falseAnswers});
  final int totalQuestions;
  final int correctAnswers;
  final int falseAnswers;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        LocaleKeys.writtenExam_congratulations.locale,
        style: MyTextStyle.smallTextStyle(),
      ),
      Text(
        LocaleKeys.writtenExam_totalQuestion.locale + totalQuestions.toString(),
        style: MyTextStyle.smallTextStyle(),
      ),
      Text(
        LocaleKeys.writtenExam_totalCorrectAnswer.locale + correctAnswers.toString(),
        style: MyTextStyle.smallTextStyle(),
      ),
      Text(
        LocaleKeys.writtenExam_totalWrongAnswer.locale + falseAnswers.toString(),
        style: MyTextStyle.smallTextStyle(),
      )
    ]);
  }
}
