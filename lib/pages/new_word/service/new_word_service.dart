import 'package:colorword_new/core/app_data/db/firestore_service.dart';
import 'package:colorword_new/core/models/word_model.dart';
import 'package:colorword_new/pages/new_word/service/new_word_service_interface.dart';

class NewWordService implements INewWordService {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Future<bool> addWord(Word word) async {
    return await _firestoreService.addWord(word);
  }

  @override
  Future<bool> deleteWord(Word word) async {
    return await _firestoreService.deleteWord(word);
  }
}
