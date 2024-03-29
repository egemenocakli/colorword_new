import 'package:colorword_new/app/db/firestore_service.dart';
import 'package:colorword_new/app/pages/auth/model/firebase_user_model.dart';
import 'package:colorword_new/app/pages/auth/service/auth_service_interface.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:firebase_auth/firebase_auth.dart';
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
        userId: user.uid,
        email: user.email!,
        name: user.displayName != null ? user.displayName!.split(" ")[0] : "",
        lastname:
            user.displayName != null && user.displayName!.split(" ").length > 1 ? user.displayName!.split(" ")[1] : "",
        photo: user.photoURL ?? "");
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

  @override
  Future<bool> signUp(
      {required String email, required String password, required String name, required String lastName}) async {
    try {
      UserCredential userCredential;
      userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      _appUser = _userFromEmail(uid: userCredential.user!.uid, name: name, lastName: lastName, email: email);
      FirestoreService firestoreService = FirestoreService();
      if (_appUser != null) {
        firestoreService.createUserInfo(firebaseUser: _appUser);
        updateName("${_appUser?.name} ${_appUser?.lastname}");
      }

      printUserDetails();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<FirebaseUser?> loginWithEmailPassword({required String email, required String password}) async {
    try {
      UserCredential userCredential;
      userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      _appUser = _userFromFirebase(userCredential.user!);
      getCurrentUser();
      printUserDetails();
      return _appUser;
    } catch (e) {
      return null;
    }
  }

  FirebaseUser? _userFromEmail(
      {required String uid, required String email, required String? name, required String? lastName}) {
    _appUser = FirebaseUser(
        userId: uid, //user.providerData[0].uid,
        email: email,
        name: name ?? "",
        lastname: lastName ?? "",
        photo: "");
    //Şuanlık kalktı
    /* FirestoreService firestoreService = FirestoreService();
    firestoreService.createUserInfo(); */
    return _appUser;
  }

  void printUserDetails() {
    print("Kullanıcı bilgileri:\n"
        "${_appUser?.name} "
        "${_appUser?.lastname} "
        "${_appUser?.email} "
        "${_appUser?.userId}");
  }
}
