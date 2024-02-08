import 'dart:async';

import 'package:colorword_new/app/pages/profile/service/profile_interface.dart';
import 'package:colorword_new/app/pages/profile/service/profile_service.dart';
import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends BaseViewModel implements IProfileService {
  final ProfileService _profileServiceService = ProfileService();

  bool? _textEditNameEnable;
  bool? _textEditMailEnable;
  bool? _selectedChoise;
  FocusNode? _nameFocusNode = FocusNode(canRequestFocus: true);
  FocusNode? _emailFocusNode = FocusNode(canRequestFocus: true);
  late int _timeCounterValue;

  @override
  FutureOr<void> init() {
    _textEditNameEnable = false;
    _textEditMailEnable = false;
    _selectedChoise = false;
    _timeCounterValue = 10;
  }

  int get timeCounterValue => _timeCounterValue;

  set timeCounterValue(int value) {
    print(timeCounterValue);

    _timeCounterValue = value;
    notifyListeners();
  }

  FocusNode? get nameFocusNode => _nameFocusNode;

  set nameFocusNode(FocusNode? value) {
    _nameFocusNode = value;
    notifyListeners();
  }

  FocusNode? get emailFocusNode => _emailFocusNode;

  set emailFocusNode(FocusNode? value) {
    _emailFocusNode = value;
    notifyListeners();
  }

  bool? get selectedChoise => _selectedChoise;

  set selectedChoise(bool? value) {
    _selectedChoise = value;
    notifyListeners();
  }

  bool? get textEditEnable => _textEditNameEnable;

  set textEditEnable(bool? value) {
    _textEditNameEnable = value;
    notifyListeners();
  }

  bool? get textEditMailEnable => _textEditMailEnable;

  set textEditMailEnable(bool? value) {
    _textEditMailEnable = value;
    notifyListeners();
  }

  @override
  Future<void> refreshData() {
    // TODO: implement refreshData
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteAccount() async {
    return false;
    //TODO: yayınlanırken açılacak, silindikten sonra login e atmalıyız.
    //return await _profileServiceService.deleteAccount();
  }

  @override
  Future<bool> updateName(String? displayName) async {
    return await _profileServiceService.updateName(displayName);
  }

  @override
  Future<bool> updateEmail(String? email) async {
    return await _profileServiceService.updateEmail(email);
  }

  void startCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeCounterValue > 0) {
        timeCounterValue--;
      } else if (timeCounterValue <= 0) {
        timer.cancel();
      }
    });
  }
}
