import 'package:colorword_new/app/pages/auth/model/firebase_user_model.dart';
import 'package:colorword_new/app/pages/auth/service/auth_service_interface.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService implements AuthServiceInterface {
  final _firebaseAuth = fb.FirebaseAuth.instance;
  FirebaseUser? _appUser;

  FirebaseUser? get user => _appUser;

  @override
  Future<FirebaseUser?> getCurrentUser() async {
    _appUser = _userFromFirebase(_firebaseAuth.currentUser!);
    return _appUser;
  }

  @override
  Future<FirebaseUser?> signInWithGoogle() async {
    //AppUser? appUser;
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        fb.UserCredential userCredential = await _firebaseAuth.signInWithCredential(
            fb.GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken));
        _appUser = _userFromFirebase(userCredential.user!);
      }
    }
    print("Giriş yapan kullanıcı bilgileri:\n"
        "${_appUser?.name} "
        "${_appUser?.lastname} "
        "${_appUser?.email} "
        "${_appUser?.userId}");

    return _appUser;
  }

  @override
  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut().then((value) {});
      return true;
    } catch (e) {
      print("signOut sırasında hata oluştu: $e");
      return false;
    }
  }

  FirebaseUser? _userFromFirebase(fb.User user) {
    _appUser = FirebaseUser(
        userId: user.uid, //user.providerData[0].uid,
        email: user.email!,
        name: user.displayName!.split(" ")[0],
        lastname: user.displayName!.split(" ").isNotEmpty ? user.displayName!.split(" ")[1] : "",
        photo: user.photoURL!);
    return _appUser;
  }

  @override
  Future<bool> updateName(String? displayName) async {
    try {
      if (displayName != null) {
        await _firebaseAuth.currentUser?.updateDisplayName(displayName);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateEmail(String? email) async {
    try {
      if (email != null) {
        await _firebaseAuth.currentUser?.updateEmail(email);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteAccount() async {
    try {
      await _firebaseAuth.currentUser?.delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
