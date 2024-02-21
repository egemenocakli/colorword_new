import 'package:colorword_new/app/models/word_model.dart';
import 'package:colorword_new/app/pages/multipleChoiceExam/service/mchoice_exam_service.dart';
import 'package:colorword_new/app/pages/multipleChoiceExam/service/mchoice_exam_service_interface.dart';

class MChoiceExamRepository implements IMChoiceExamService {
  final MChoiceExamService _examService = MChoiceExamService();

  @override
  Future<bool> decreasetheScore({Word? word, required int point}) async {
    return await _examService.decreasetheScore(word: word, point: point);
  }

  @override
  Future<bool> increasetheScore({Word? word, required int point}) async {
    return await _examService.increasetheScore(word: word, point: point);
  }
}
