import 'dart:async';

import 'package:colorword_new/app/pages/profile/service/profile_interface.dart';
import 'package:colorword_new/app/pages/profile/service/profile_service.dart';
import 'package:colorword_new/core/auth_manager/auth_manager.dart';
import 'package:colorword_new/core/auth_manager/model/user_model.dart';
import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends BaseViewModel implements IProfileService {
  final ProfileService _profileServiceService = ProfileService();
  TextEditingController? userNametextController = TextEditingController();
  TextEditingController? userLastNametextController = TextEditingController();
  TextEditingController? userEmailtextController = TextEditingController();
  TextEditingController? userIDtextController = TextEditingController();
  User? signedUser = AuthManager.instance?.signedUser;
  String? _fullName;
  bool? _textEditNameEnable;
  bool? _textEditMailEnable;
  bool? _selectedChoise;
  FocusNode? _nameFocusNode = FocusNode(canRequestFocus: true);
  FocusNode? _emailFocusNode = FocusNode(canRequestFocus: true);

  @override
  FutureOr<void> init() {
    _fullName = "${signedUser?.name}" " " "${signedUser?.lastname}";
    userNametextController?.text = _fullName ?? "Unknown";
    userEmailtextController?.text = signedUser!.email ?? "Unknown";
    userIDtextController?.text = signedUser!.userId ?? "Unknown";

    _textEditNameEnable = false;
    _textEditMailEnable = false;
    _selectedChoise = false;
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

  String? get fullName => _fullName;

  set fullName(String? value) {
    _fullName = value;
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
    //TODO: yayınlanırken açılacak
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
}
