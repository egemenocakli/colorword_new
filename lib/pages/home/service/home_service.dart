import 'package:colorword_new/core/app_data/db/firestore_service.dart';
import 'package:colorword_new/core/models/word_model.dart';
import 'package:colorword_new/pages/home/service/home_service_interface.dart';

class ExamService implements IHomeService {
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
