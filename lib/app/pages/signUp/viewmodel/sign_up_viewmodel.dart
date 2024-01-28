import 'dart:async';
import 'package:colorword_new/app/pages/signUp/service/sign_up_interface.dart';
import 'package:colorword_new/app/pages/signUp/service/sign_up_service.dart';
import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:flutter/material.dart';

class SignUpViewModel extends BaseViewModel implements ISignUpService {
  final SignUpService _signInService = SignUpService();

  TextEditingController nameTextController = TextEditingController();
  TextEditingController lastNameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController repeatPasswordTextController = TextEditingController();

  @override
  FutureOr<void> init() {}

  @override
  Future<void> refreshData() async {}

  @override
  Future<bool> signUp(
      {required String email, required String password, required String name, required String lastName}) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      return await _signInService.signUp(email: email, password: password, name: name, lastName: lastName);
    } else {
      return false;
    }
  }
}
