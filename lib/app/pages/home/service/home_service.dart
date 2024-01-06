import 'package:colorword_new/app/db/firestore_service.dart';
import 'package:colorword_new/app/models/word_model.dart';
import 'package:colorword_new/app/pages/home/service/home_service_interface.dart';

class HomeService implements IHomeService {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Future<bool> deleteWord(Word? word) async {
    return await _firestoreService.deleteWord(word);
  }

  @override
  Future<List<Word?>?> readWords() async {
    return await _firestoreService.readWords();
  }
}
