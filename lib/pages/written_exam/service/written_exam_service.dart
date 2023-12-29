import 'package:colorword_new/core/app_data/db/firestore_service.dart';
import 'package:colorword_new/core/models/word_model.dart';
import 'package:colorword_new/pages/written_exam/service/written_exam_interface.dart';

class WrittenExamService implements IWrittenExamService {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Future<bool> decreasetheScore({Word? word, required int point}) {
    return _firestoreService.decreasetheScore(word: word, point: point);
  }

  @override
  Future<bool> increasetheScore({Word? word, required int point}) {
    return _firestoreService.increasetheScore(word: word, point: point);
  }
}
