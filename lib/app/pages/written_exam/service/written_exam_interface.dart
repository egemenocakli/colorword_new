import 'package:colorword_new/app/models/word_model.dart';

abstract class IWrittenExamService {
  Future<bool> increasetheScore({Word? word, required int point});
  Future<bool> decreasetheScore({Word? word, required int point});
}
