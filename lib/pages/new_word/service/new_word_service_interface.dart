import '../../../core/models/word_model.dart';

abstract class INewWordService {
  Future<bool> addWord(Word word);
  Future<bool> deleteWord(Word word);
}
