import 'dart:async';
import 'dart:math';
import 'package:colorword_new/app/pages/multipleChoiceExam/repository/mchoice_exam_repository.dart';
import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/app/models/word_model.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/app/pages/multipleChoiceExam/model/option_model.dart';
import 'package:colorword_new/app/pages/multipleChoiceExam/model/quest_model.dart';
import 'package:colorword_new/app/pages/multipleChoiceExam/service/mchoice_exam_service_interface.dart';
import 'package:colorword_new/app/pages/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';

class MChoiceExamViewModel extends BaseViewModel implements IMChoiceExamService {
  final MChoiceExamRepository _examRepository = MChoiceExamRepository();
  HomeViewModel homeViewModel = locator<HomeViewModel>();

  List<QuestModel> examQuestList = [];
  late List<Word?>? examWords;
  Set<String?> options = {};
  late Word? onPageWord;
  Color _optionsButtonColor = ColorConstants.optionsButtonDefaultColor;
  int? _pageIndex;
  late int lastPageNumber;
  late List<bool> _examResultList = List.filled(homeViewModel.words.length, false);
  late int falseAnswers;
  late int correctAnswers;

  @override
  Future<void> refreshData() {
    // TODO: implement refreshData
    throw UnimplementedError();
  }

  @override
  FutureOr<void> init() {
    examWords = homeViewModel.words;
  }

  //getter
  Color get optionsButtonColor => _optionsButtonColor;
  int? get pageIndex => _pageIndex;
  List<bool> get examResultList => _examResultList;
  //setter

  set examResultList(List<bool> value) {
    _examResultList = value;
    notifyListeners();
  }

  set pageIndex(int? value) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageIndex = value;
      notifyListeners();
    });
  }

  set optionsButtonColor(Color value) {
    viewState = ViewState.loading;
    _optionsButtonColor = value;
    viewState = ViewState.loaded;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future<void> reloadWords() async {
    await homeViewModel.readWords();
  }

  Future<List<String?>> createOptions({required List<Word?>? allWords}) async {
    Random random = Random.secure();

    options.clear();
    options.add(onPageWord?.translatedWords?[0]);
    for (int i = 0; i < 4; i++) {
      options.add(allWords![random.nextInt(allWords.length)]?.translatedWords?.first);
    }
    if (options.length < 4) {
      for (int i = 0; i < 4; i++) {
        options.add(allWords![random.nextInt(allWords.length)]?.translatedWords?.first);
      }
    }
    return options.toList();
  }

  Future<List<QuestModel?>> createExamQuestList({required List<Word?>? allWords}) async {
    options.clear();
    List<QuestModel> result = [];
    if (allWords != null) {
      for (var element in allWords) {
        onPageWord = element;
        options.addAll(await createOptions(allWords: allWords));

        List<String?> newList;
        if (options.length > 3) {
          newList = options.toList().sublist(0, 4);
          print(newList);
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
        } else {
          options.addAll(await createOptions(allWords: allWords));
        }

        ///TODO: burası 7 kelime eklenmeden sayfayı çalıştırmıyor
      }
      examQuestList = result;
      return result;
    } else {
      return [];
    }
  }

  @override
  Future<bool> decreasetheScore({Word? word, required int point}) async {
    if (word != null) {
      viewState = ViewState.loading;
      await _examRepository.decreasetheScore(word: word, point: point);
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
      await _examRepository.increasetheScore(word: word, point: point);
      viewState = ViewState.loaded;
      return true;
    } else {
      return false;
    }
  }

  void answerCounter() {
    falseAnswers = examResultList.where((element) => element == false).length;
    correctAnswers = examResultList.where((element) => element == true).length;
  }
}
