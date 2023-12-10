import 'dart:async';
import 'dart:math';
import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/models/word_model.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/pages/exam/model/option_model.dart';
import 'package:colorword_new/pages/exam/model/quest_model.dart';
import 'package:colorword_new/pages/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';

class ExamViewModel extends BaseViewModel {
  List<QuestModel> examQuestList = [];

  HomeViewModel homeViewModel = locator<HomeViewModel>();
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
    //notifyListeners();
  }

  set isTap(bool value) {
    viewState = ViewState.loading;
    _isTap = value;
    viewState = ViewState.loaded;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  List<String?> createOptions({required List<Word?> allWords}) {
    var random = Random(4);

    options.clear();
    options.add(onPageWord?.translatedWords?[0]);
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
      onPageWord = element;

      //random olarak al shuffle kullanma performans kaybı

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

      /* newList.map((e) {
        newOptionModelList.add(
          OptionModel(
            optionText: e ?? '',
            optionState: OptionState.none,
          ),
        );
      }); */

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
}
/*
import 'dart:async';
import 'dart:math';
import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/models/word_model.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/pages/exam/model/quest_model.dart';
import 'package:colorword_new/pages/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';

class ExamViewModel extends BaseViewModel {
  List<QuestModel> examQuestList = [];

  HomeViewModel homeViewModel = locator<HomeViewModel>();
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
    //notifyListeners();
  }

  set isTap(bool value) {
    viewState = ViewState.loading;
    _isTap = value;
    viewState = ViewState.loaded;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  List<String?> createOptions({required List<Word?> allWords}) {
    var random = Random(4);

    options.clear();
    options.add(onPageWord?.translatedWords?[0]);
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
      onPageWord = element;

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
 */