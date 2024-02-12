import 'dart:async';

import 'package:colorword_new/app/pages/written_exam/repository/written_exam_repository.dart';
import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:colorword_new/app/models/word_model.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/app/pages/home/viewmodel/home_viewmodel.dart';
import 'package:colorword_new/app/pages/written_exam/service/written_exam_interface.dart';
import 'package:flutter/material.dart';

class WrittenExamViewModel extends BaseViewModel implements IWrittenExamService {
  final WrittenExamRepository _writtenExamRepository = WrittenExamRepository();
  final HomeViewModel homeViewModel = locator<HomeViewModel>();
  int _mistakes = 5;
  int _pageIndex = 0;
  late int lastPageNumber;
  late List<bool> _examResultList = List.filled(homeViewModel.words.length, false);
  String _hintText = "";
  late int falseAnswers;
  late int correctAnswers;
  int hintIndex = 0;

  @override
  FutureOr<void> init() {}

  @override
  Future<void> refreshData() {
    throw UnimplementedError();
  }

  String get hintText => _hintText;

  set hintText(String value) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _hintText = value;
      notifyListeners();
    });
  }

  List<bool> get examResultList => _examResultList;

  set examResultList(List<bool> value) {
    _examResultList = value;
    notifyListeners();
  }

  int get pageIndex => _pageIndex;

  set pageIndex(int value) {
    if (_pageIndex == value) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageIndex = value;
      notifyListeners();
    });
  }

  int get mistakes => _mistakes;

  set mistakes(int value) {
    _mistakes = value;
    notifyListeners();
  }

  @override
  Future<bool> decreasetheScore({Word? word, required int point}) async {
    if (word != null) {
      viewState = ViewState.loading;
      await _writtenExamRepository.decreasetheScore(word: word, point: point);
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
      await _writtenExamRepository.increasetheScore(word: word, point: point);
      viewState = ViewState.loaded;
      return true;
    } else {
      return false;
    }
  }

  void cleanHintText() {
    hintText = "";
    hintIndex = 0;
  }

  void answerCounter() {
    //TODO:Word objesinde kaç kere yanlış bilindiğini tutabiliriz.
    falseAnswers = examResultList.where((element) => element == false).length;
    correctAnswers = examResultList.where((element) => element == true).length;
  }

  void addLetterToController(String letter) {
    hintText += letter;
  }
}
