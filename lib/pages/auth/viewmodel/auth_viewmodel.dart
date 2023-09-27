import 'dart:async';
import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:colorword_new/pages/auth/model/app_user_model.dart';
import 'package:colorword_new/pages/auth/repository/auth_repository.dart';
import 'package:colorword_new/pages/auth/service/auth_service_interface.dart';

class AuthViewModel extends BaseViewModel implements AuthServiceInterface {
  late final AuthRepository _authRepository;
  late AppUser? appUser;

  AuthViewModel() {
    _authRepository = AuthRepository();
  }

  @override
  FutureOr<void> init() {}

  @override
  Future<AppUser?> getCurrentUser() async {
    return await _authRepository.getCurrentUser();
  }

  @override
  Future<AppUser?> signInWithGoogle() async {
    try {
      viewState = ViewState.loading;
      appUser = await _authRepository.signInWithGoogle();
      viewState = ViewState.loaded;
    } catch (e) {
      viewState = ViewState.error;
    }

    viewState = ViewState.loaded;
    return appUser;
  }

  @override
  Future<bool> signOut() async {
    return await _authRepository.signOut();
  }

  @override
  Future<void> refreshData() {
    // TODO: implement refreshData
    throw UnimplementedError();
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