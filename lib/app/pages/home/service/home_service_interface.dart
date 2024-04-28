import 'package:colorword_new/app/models/word_model.dart';

abstract class IHomeService {
  Future<bool> deleteWord(Word? word);
  Future<bool> updateWord(Word? word);
  Future<List<Word?>?> readWords();
}
