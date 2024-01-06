import 'package:colorword_new/app/models/word_model.dart';
import 'package:colorword_new/app/pages/exam/model/option_model.dart';

class QuestModel {
  final Word? word;
  late List<OptionModel?> options;

  QuestModel({
    required this.word,
    required this.options,
  });
}
