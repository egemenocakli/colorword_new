import 'package:colorword_new/app/pages/auth/service/auth_firebase_service.dart';
import 'package:colorword_new/app/pages/signUp/service/sign_up_interface.dart';

class SignUpService implements ISignUpService {
  final FirebaseAuthService _authService = FirebaseAuthService();
  @override
  Future<bool> signUp(
      {required String email, required String password, required String name, required String lastName}) async {
    return await _authService.signUp(email: email, password: password, name: name, lastName: lastName);
  }
}
