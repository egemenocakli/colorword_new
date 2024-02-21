import 'package:colorword_new/core/auth_manager/auth_manager_interface.dart';
import 'package:colorword_new/core/auth_manager/model/user_model.dart';

//Kalan oturum süresinin hesaplanması
//Oturum süresi dolunca logout olma
///Singleton
class AuthManager implements IAuthManager {
  static AuthManager? _instance;
  static AuthManager? get instance {
    _instance ??= AuthManager._init();
    return _instance;
  }

  AuthManager._init();

  User? _signedUser;

  @override
  User? get signedUser {
    return _signedUser;
  }

  set signedUser(User? user) {
    _signedUser = user;
  }
}
