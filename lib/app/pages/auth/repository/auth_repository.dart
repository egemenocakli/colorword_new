import 'package:colorword_new/app/pages/auth/model/firebase_user_model.dart';
import 'package:colorword_new/app/pages/auth/service/auth_firebase_service.dart';
import 'package:colorword_new/app/pages/auth/service/auth_service_interface.dart';

/// Bu sayfada verilerin hangi kaynaktan alınacağına dair yönlendirme işlemleri yapılmaktadır.
///
class AuthRepository extends AuthServiceInterface {
  late final FirebaseAuthService _firebaseAuthService;

  AuthRepository() {
    _firebaseAuthService = FirebaseAuthService();
  }

  @override
  Future<FirebaseUser?> getCurrentUser() async {
    return await _firebaseAuthService.getCurrentUser();
  }

  @override
  Future<FirebaseUser?> signInWithGoogle() async {
    return await _firebaseAuthService.signInWithGoogle();
  }

  @override
  Future<bool> signOut() async {
    return await _firebaseAuthService.signOut();
  }
}
