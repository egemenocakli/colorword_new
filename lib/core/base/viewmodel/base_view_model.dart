import 'dart:async';
import 'package:flutter/material.dart';
import '../../utility/view_helper.dart';

enum ViewState {
  idle,
  loading,
  loaded,
  error,
  disposed,
}

abstract class BaseViewModel extends ChangeNotifier with ViewHelper {
  late ViewState _viewState;
  FutureOr<void> _initState;
  bool refreshIndicatorRunning = false;
  Future<void> refreshData();

  BaseViewModel() {
    load();
  }

  FutureOr<void> init();

  void load() async {
    viewState = ViewState.loading;
    _initState = init();
    await _initState;
    viewState = ViewState.loaded;
  }

  ViewState get viewState => _viewState;

  set viewState(ViewState value) {
    _viewState = value;
    scheduleMicrotask(() {
      notifyListeners();
    });
  } //Setters

  void reloadState() {
    if (viewState != ViewState.loading) notifyListeners();
  }

  @override
  void dispose() {
    viewState = ViewState.disposed;
    super.dispose();
  }
}
