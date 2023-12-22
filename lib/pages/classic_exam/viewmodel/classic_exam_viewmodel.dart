import 'dart:async';

import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';

class ClassicExamViewModel extends BaseViewModel {
  @override
  FutureOr<void> init() {}
/*
  Color? get onPageColor => _onPageColor;

  set onPageColor(Color? value) {
    viewState = ViewState.loading;
    _onPageColor = value;
    viewState = ViewState.loaded;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
*/
  @override
  Future<void> refreshData() {
    // TODO: implement refreshData
    throw UnimplementedError();
  }
}
