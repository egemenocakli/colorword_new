import 'package:colorword_new/app/pages/auth/service/auth_firebase_service.dart';
import 'package:colorword_new/app/pages/profile/service/profile_interface.dart';

class ProfileService implements IProfileService {
  //final FirestoreService _firestoreService = FirestoreService();
  final FirebaseAuthService _authService = FirebaseAuthService();

  @override
  Future<bool> updateName(String? displayName) async {
    return await _authService.updateName(displayName);
  }

  @override
  Future<bool> updateEmail(String? email) async {
    return await _authService.updateEmail(email);
  }

  @override
  Future<bool> deleteAccount() async {
    return await _authService.deleteAccount();
  }
}
