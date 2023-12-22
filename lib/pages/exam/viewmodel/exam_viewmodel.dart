import 'dart:async';
import 'dart:math';
import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/models/word_model.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/pages/exam/model/option_model.dart';
import 'package:colorword_new/pages/exam/model/quest_model.dart';
import 'package:colorword_new/pages/exam/service/exam_service.dart';
import 'package:colorword_new/pages/exam/service/exam_service_interface.dart';
import 'package:colorword_new/pages/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';

class ExamViewModel extends BaseViewModel implements IExamService {
  final ExamService _examService = ExamService();
  HomeViewModel homeViewModel = locator<HomeViewModel>();

  List<QuestModel> examQuestList = [];
  late List<Word?>? examWords;
  Set<String?> options = {};
  late Word? onPageWord;
  Color _optionsButtonColor = ColorConstants.optionsButtonDefaultColor;
  bool _isTap = false;

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
  Color get optionsButtonColor => _optionsButtonColor;
  bool get isTap => _isTap;
  //setter
  set optionsButtonColor(Color value) {
    viewState = ViewState.loading;
    _optionsButtonColor = value;
    viewState = ViewState.loaded;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  set isTap(bool value) {
    viewState = ViewState.loading;
    _isTap = value;
    viewState = ViewState.loaded;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future<void> reloadWords() async {
    await homeViewModel.readWords();
  }

  List<String?> createOptions({required List<Word?> allWords}) {
    var random = Random(4);

    options.clear();
    options.add(onPageWord?.translatedWords?[0]);
    //neden bilmiyorum yeni kelime eklediğimde aşağıdaki <=4 durumunda 3 tane eleman geldi bu yüzden 5 yaptım
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
      onPageWord = element;
      options.addAll(createOptions(allWords: allWords));
      List<String?> newList = options.toList().sublist(0, 4);
      newList.shuffle();

      List<OptionModel?> newOptionModelList = [];
      for (var element in newList) {
        newOptionModelList.add(
          OptionModel(
            optionText: element ?? '',
            optionState: OptionState.none,
          ),
        );
      }
      result.add(
        QuestModel(
          word: element,
          options: newOptionModelList,
        ),
      );
    }
    examQuestList = result;
    return result;
  }

  @override
  Future<bool> decreasetheScore({Word? word, required int point}) async {
    if (word != null) {
      viewState = ViewState.loading;
      await _examService.decreasetheScore(word: word, point: point);
      viewState = ViewState.loaded;
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> increasetheScore({Word? word, required int point}) async {
    if (word != null) {
      viewState = ViewState.loading;
      await _examService.increasetheScore(word: word, point: point);
      viewState = ViewState.loaded;
      return true;
    } else {
      return false;
    }
  }
}
