import 'package:colorword_new/pages/auth/model/app_user_model.dart';

abstract class AuthServiceInterface {
  Future<AppUser?> signInWithGoogle();
  Future<AppUser?> getCurrentUser();
  Future<bool> signOut();
}
