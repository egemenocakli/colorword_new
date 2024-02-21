import 'package:colorword_new/app/pages/signUp/service/sign_up_interface.dart';
import 'package:colorword_new/app/pages/signUp/service/sign_up_service.dart';

class SignUpRepository implements ISignUpService {
  final SignUpService _signUpService = SignUpService();

  @override
  Future<bool> signUp(
      {required String email, required String password, required String name, required String lastName}) async {
    return await _signUpService.signUp(email: email, password: password, name: name, lastName: lastName);
  }
}
