abstract class ISignUpService {
  Future<bool> signUp(
      {required String email, required String password, required String name, required String lastName});
}
