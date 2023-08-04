import 'dart:async';

import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:colorword_new/core/services/auth/auth_firebase_service.dart';

class HomeScreenViewModel extends BaseViewModel {
  @override
  FutureOr<void> init() {}

  //getter
  //setter

  Future<void> signOutFromHome() async {
    AuthenticationFirebaseService authenticationFirebaseService = AuthenticationFirebaseService();

    authenticationFirebaseService.signOut();
  }
}
