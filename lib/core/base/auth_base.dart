import 'package:colorword_new/core/models/user_model.dart';

abstract class AuthBase {
  Future<User> signInWithGoogle();
  Future<User> currentUser();
  Future<bool> signOut();
}
