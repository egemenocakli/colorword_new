import 'package:colorword_new/app/models/word_model.dart';
import 'package:colorword_new/app/pages/new_word/service/new_word_service.dart';
import 'package:colorword_new/app/pages/new_word/service/new_word_service_interface.dart';

class NewWordRepository implements INewWordService {
  final NewWordService _newWordService = NewWordService();

  @override
  Future<bool> addWord(Word? word) async {
    return await _newWordService.addWord(word);
  }
}
