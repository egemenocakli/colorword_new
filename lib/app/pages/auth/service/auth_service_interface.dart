import 'package:colorword_new/app/pages/auth/model/firebase_user_model.dart';

abstract class AuthServiceInterface {
  Future<FirebaseUser?> signInWithGoogle();
  Future<FirebaseUser?> getCurrentUser();
  Future<bool> signOut();
  Future<bool> updateName(String? displayName);
  Future<bool> updateEmail(String? email);
  Future<bool> deleteAccount();
  Future<bool> signUp(
      {required String email, required String password, required String name, required String lastName});
  Future<FirebaseUser?> loginWithEmailPassword({required String email, required String password});
}
