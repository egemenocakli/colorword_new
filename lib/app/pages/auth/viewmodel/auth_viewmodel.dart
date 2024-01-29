import 'dart:async';
import 'package:colorword_new/core/auth_manager/auth_manager.dart';
import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:colorword_new/app/pages/auth/model/firebase_user_model.dart';
import 'package:colorword_new/app/pages/auth/repository/auth_repository.dart';
import 'package:colorword_new/app/pages/auth/service/auth_service_interface.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends BaseViewModel implements AuthServiceInterface {
  late final AuthRepository _authRepository;
  late FirebaseUser? _firebaseUser;

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  AuthViewModel() {
    _authRepository = AuthRepository();
  }

  @override
  FutureOr<void> init() {}

  FirebaseUser? get firebaseUser => _firebaseUser;

  set firebaseUser(FirebaseUser? firebaseUser) {
    _firebaseUser = firebaseUser;

    AuthManager.instance?.signedUser = firebaseUser?.toUser();
  }

  @override
  Future<FirebaseUser?> getCurrentUser() async {
    return await _authRepository.getCurrentUser();
  }

  @override
  Future<FirebaseUser?> signInWithGoogle() async {
    try {
      viewState = ViewState.loading;
      firebaseUser = await _authRepository.signInWithGoogle();
      viewState = ViewState.loaded;
    } catch (e) {
      viewState = ViewState.error;
    }

    viewState = ViewState.loaded;
    return firebaseUser;
  }

  @override
  Future<bool> signOut() async {
    return await _authRepository.signOut();
  }

  @override
  Future<void> refreshData() {
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteAccount() {
    throw UnimplementedError();
  }

  @override
  Future<bool> updateName(String? displayName) {
    throw UnimplementedError();
  }

  @override
  Future<bool> updateEmail(String? email) {
    throw UnimplementedError();
  }

  @override
  Future<bool> signUp({required String email, required String password}) async {
    return await _authRepository.signUp(email: email, password: password);
  }

  @override
  Future<bool> loginWithEmailPassword({required String email, required String password}) async {
    bool sonuc;
    sonuc = await _authRepository.loginWithEmailPassword(
        email: emailTextController.text, password: passwordTextController.text);
    print("login sonucu: $sonuc");
    return sonuc;
  }
}


/*
  final FirebaseAuthService _authenticationFirebaseService = FirebaseAuthService();
  Future<AppUser> signIn() async {
    return await _authenticationFirebaseService.signInWithGoogle();
  }

  Future<void> signOut() async {
    _authenticationFirebaseService.signOut();
  }*/