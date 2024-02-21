import 'package:colorword_new/app/db/firestore_service.dart';
import 'package:colorword_new/app/models/word_model.dart';
import 'package:colorword_new/app/pages/multipleChoiceExam/service/mchoice_exam_service_interface.dart';

class MChoiceExamService implements IMChoiceExamService {
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
