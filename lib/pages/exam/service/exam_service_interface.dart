import 'package:colorword_new/core/models/word_model.dart';

abstract class IExamService {
  Future<bool> increasetheScore({Word? word, required int point});
  Future<bool> decreasetheScore({Word? word, required int point});
}
