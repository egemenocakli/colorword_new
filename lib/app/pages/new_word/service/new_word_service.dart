import 'package:colorword_new/app/db/firestore_service.dart';
import 'package:colorword_new/app/models/word_model.dart';
import 'package:colorword_new/app/pages/new_word/service/new_word_service_interface.dart';

class NewWordService implements INewWordService {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Future<bool> addWord(Word? word) async {
    return await _firestoreService.addWord(word!);
  }
}
