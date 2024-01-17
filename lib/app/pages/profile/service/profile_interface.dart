abstract class IProfileService {
  Future<bool> updateName(String? displayName);
  Future<bool> updateEmail(String? email);
  Future<bool> deleteAccount();
}
