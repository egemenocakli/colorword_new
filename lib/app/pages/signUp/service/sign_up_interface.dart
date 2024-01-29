abstract class ISignUpService {
  Future<bool> signUp({required String email, required String password});
}
