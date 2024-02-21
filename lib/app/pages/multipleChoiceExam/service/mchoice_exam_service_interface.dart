import 'package:colorword_new/app/models/word_model.dart';

abstract class IMChoiceExamService {
  Future<bool> increasetheScore({Word? word, required int point});
  Future<bool> decreasetheScore({Word? word, required int point});
}
