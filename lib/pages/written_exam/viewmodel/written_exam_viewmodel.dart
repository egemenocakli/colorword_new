import 'dart:async';

import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:colorword_new/core/models/word_model.dart';
import 'package:colorword_new/pages/written_exam/service/written_exam_interface.dart';
import 'package:colorword_new/pages/written_exam/service/written_exam_service.dart';
import 'package:flutter/material.dart';

class WrittenExamViewModel extends BaseViewModel implements IWrittenExamService {
  final WrittenExamService _writtenExamService = WrittenExamService();
  int _mistakes = 3;
  int _pageIndex = 0;

  @override
  FutureOr<void> init() {}

  @override
  Future<void> refreshData() {
    // TODO: implement refreshData
    throw UnimplementedError();
  }

  int get pageIndex => _pageIndex;

  set pageIndex(int value) {
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
      await _writtenExamService.decreasetheScore(word: word, point: point);
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
      await _writtenExamService.increasetheScore(word: word, point: point);
      viewState = ViewState.loaded;
      return true;
    } else {
      return false;
    }
  }
}
