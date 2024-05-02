import 'package:colorword_new/app/models/word_model.dart';
import 'package:colorword_new/app/pages/written_exam/service/written_exam_interface.dart';
import 'package:colorword_new/app/pages/written_exam/service/written_exam_service.dart';

class WrittenExamRepository implements IWrittenExamService {
  final WrittenExamService _writtenExamService = WrittenExamService();

  @override
  Future<bool> decreasetheScore({Word? word, required int point}) async {
    return await _writtenExamService.decreasetheScore(word: word, point: point);
  }

  @override
  Future<bool> increasetheScore({Word? word, required int point}) async {
    return await _writtenExamService.increasetheScore(word: word, point: point);
  }
}
