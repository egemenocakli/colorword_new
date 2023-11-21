import 'package:colorword_new/core/models/word_model.dart';

abstract class IHomeService {
  Future<bool> deleteWord(Word? word);
  Future<List<Word?>?> readWords();
}
