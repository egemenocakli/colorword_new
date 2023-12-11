import 'package:colorword_new/core/app_data/db/firestore_service.dart';
import 'package:colorword_new/core/models/word_model.dart';
import 'package:colorword_new/pages/exam/service/exam_service_interface.dart';

class ExamService implements IExamService {
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
