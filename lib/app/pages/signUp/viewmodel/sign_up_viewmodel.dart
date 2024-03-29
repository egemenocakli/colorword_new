import 'dart:async';
import 'package:colorword_new/app/pages/auth/viewmodel/auth_viewmodel.dart';
import 'package:colorword_new/app/pages/signUp/repository/sign_up_repository.dart';
import 'package:colorword_new/app/pages/signUp/service/sign_up_interface.dart';
import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:flutter/material.dart';

class SignUpViewModel extends BaseViewModel implements ISignUpService {
  final SignUpRepository _signUpRepository = SignUpRepository();
  AuthViewModel authViewModel = AuthViewModel();

  TextEditingController nameTextController = TextEditingController();
  TextEditingController lastNameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController repeatPasswordTextController = TextEditingController();

  @override
  FutureOr<void> init() {}

  @override
  Future<void> refreshData() async {}

  @override
  Future<bool> signUp(
      {required String email, required String password, required String name, required String lastName}) async {
    bool sonuc;
    sonuc = await _signUpRepository.signUp(email: email, password: password, name: name, lastName: lastName);
    print("kayıt sonucu : $sonuc");
    return sonuc;
  }
}
