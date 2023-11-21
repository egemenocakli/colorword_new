import 'package:colorword_new/core/models/word_model.dart';

abstract class INewWordService {
  Future<bool> addWord(Word? word);
}
