import 'dart:async';
import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:colorword_new/core/models/word_model.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/pages/exam/model/quest_model.dart';
import 'package:colorword_new/pages/home/viewmodel/home_viewmodel.dart';

class ExamViewModel extends BaseViewModel {
  List<QuestModel> examQuestList = [];

  HomeViewModel homeViewModel = locator<HomeViewModel>();
  late List<Word?>? examWords;
  List<String?>? options = [];
  List<String?>? lastList = [];

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

//Metod saçma bir şekilde iki sefer çağrılıyor ilk kelimelerin tr karşılığı çıkıyo sonrakiler çıkmıyor saçmalık
  Future<List<String?>?> createOtherOptions(List<Word?>? examWords, Word? onPageWord) async {
    options!.clear();
    lastList!.clear();
    //Aynı şıktan 2 3 tane olmamalı ve kesin kelimenin karşılığı da olmalı
    if (examWords!.isNotEmpty) {
      print("ifli metoda girdi");
      for (int i = 0; i < examWords.length;) {
        options!.add(examWords[i]!.translatedWords![0]!);
        i++;
      }
      options?.shuffle();
      options = await setOptionList(options, onPageWord, lastList);
    }
    if (options!.isNotEmpty) {
      return options;
    } else {
      return null;
    }
  }

  Future<List<String?>> setOptionList(List<String?>? options, Word? onPageWord, List<String?>? lastList) async {
    print("metoda girdi");
    Set<String?>? newOptions = {};
    options!.toSet();

    for (int i = 1; i < 4;) {
      newOptions.add(options[i]);
      i++;
    }
    newOptions.add(onPageWord!.translatedWords![0]);

    lastList = newOptions.toList();
    lastList.shuffle();

    return lastList;
  }

  List<String?> createOptions({required List<Word?> allWords}) {
    List<String?> options = [];

    allWords.shuffle();
    for (int i = 0; i < 3; i++) {
      options.add(allWords[i]?.translatedWords?.first);
    }
    return options;
  }

  List<QuestModel?> createExamQuestList({
    required List<Word?> allWords,
  }) {
    List<QuestModel> result = [];

    for (var element in allWords) {
      List<String?> options = [];
      options.addAll(createOptions(allWords: allWords));
      options.add(element?.translatedWords?.first);
      options.shuffle();

      result.add(
        QuestModel(
          word: element,
          options: options,
        ),
      );
    }

    examQuestList = result;

    return result;
  }
}
