import 'dart:async';
import 'dart:math';
import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:colorword_new/core/models/word_model.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/pages/exam/model/quest_model.dart';
import 'package:colorword_new/pages/home/viewmodel/home_viewmodel.dart';

class ExamViewModel extends BaseViewModel {
  List<QuestModel> examQuestList = [];

  HomeViewModel homeViewModel = locator<HomeViewModel>();
  late List<Word?>? examWords;
  Set<String?> options = {};
  late String? onPageWordTranslate;

  @override
  Future<void> refreshData() {
    // TODO: implement refreshData
    throw UnimplementedError();
  }

  @override
  FutureOr<void> init() {
    examWords = homeViewModel.words;
    //options = createOtherOptions(examWords);
  }

  //getter

  //setter

  List<String?> createOptions({required List<Word?> allWords}) {
    var random = Random(4);

    options.clear();
    options.add(onPageWordTranslate);
    //randomdan 0-4 arası sayı alıp listeden birini değiştirmek?
    for (int i = 0; i <= 4; i++) {
      options.add(allWords[random.nextInt(allWords.length)]?.translatedWords?.first);
    }

    return options.toList();
  }

  List<QuestModel?> createExamQuestList({
    required List<Word?> allWords,
  }) {
    options.clear();
    List<QuestModel> result = [];

    for (var element in allWords) {
      //List<String?> options = [];
      //options.add(element?.translatedWords?.first);
      onPageWordTranslate = element?.translatedWords?.first;

      //random olarak al shuffle kullanma performans kaybı

      options.addAll(createOptions(allWords: allWords));

      List<String?> newList = options.toList().sublist(0, 4);
      newList.shuffle();

      result.add(
        QuestModel(
          word: element,
          options: newList,
        ),
      );
    }

    examQuestList = result;

    return result;
  }
}
