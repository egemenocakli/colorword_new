import 'dart:async';
import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/services/auth/auth_firebase_service.dart';

class LoginViewModel extends BaseViewModel {
  @override
  FutureOr<void> init() {}

  final AuthenticationFirebaseService _authenticationFirebaseService = AuthenticationFirebaseService();

  Future<bool> signIn() async {
    bool sonuc = await _authenticationFirebaseService.signInWithGoogle();
    print("giriş $sonuc");
    return sonuc;
  }
/*
  late final GoogleSignInAccount? _googleUser;
  
  //getters
  GoogleSignInAccount? get googleUser => _googleUser;
  //setters
      set googleUser(GoogleSignInAccount value) {
    _googleUser = value;
    reloadState();
  }
  */
  /*
  
    set onChangedDropDownVal(String value) {
    _onChangedDropDownVal = value;
    reloadState();
  }
   */

//Google auth

/*
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      throw FirebaseAuthException(code: e.toString());
    }
  }
*/

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
