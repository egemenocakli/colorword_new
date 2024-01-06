import 'dart:async';
import 'package:colorword_new/core/auth_manager/auth_manager.dart';
import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:colorword_new/app/pages/auth/model/firebase_user_model.dart';
import 'package:colorword_new/app/pages/auth/repository/auth_repository.dart';
import 'package:colorword_new/app/pages/auth/service/auth_service_interface.dart';

class AuthViewModel extends BaseViewModel implements AuthServiceInterface {
  late final AuthRepository _authRepository;
  late FirebaseUser? _firebaseUser;

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