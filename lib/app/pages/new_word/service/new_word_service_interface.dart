import 'package:colorword_new/app/models/word_model.dart';

abstract class INewWordService {
  Future<bool> addWord(Word? word);
}
