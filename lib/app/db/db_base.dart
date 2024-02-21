import 'package:colorword_new/app/models/word_model.dart';

abstract class DbBase {
  Future<List<Word?>?> readWords();
  Future<Word?> readWord(String wordId);
  Future<bool> updateWord(Word word);
  Future<bool> addWord(Word word);
  Future<bool> deleteWord(Word word);
}
