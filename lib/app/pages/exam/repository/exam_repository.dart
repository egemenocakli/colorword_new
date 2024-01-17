import 'package:colorword_new/app/models/word_model.dart';
import 'package:colorword_new/app/pages/exam/service/exam_service.dart';
import 'package:colorword_new/app/pages/exam/service/exam_service_interface.dart';

class ExamRepository implements IExamService {
  final ExamService _examService = ExamService();

  @override
  Future<bool> decreasetheScore({Word? word, required int point}) async {
    return await _examService.decreasetheScore(point: point);
  }

  @override
  Future<bool> increasetheScore({Word? word, required int point}) async {
    return await _examService.increasetheScore(word: word, point: point);
  }
}
