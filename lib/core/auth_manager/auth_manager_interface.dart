import 'package:colorword_new/core/auth_manager/model/user_model.dart';

abstract class IAuthManager {
  //Kalan oturum süresinin hesaplanması
  //Oturum süresi dolunca logout olma
  User? get signedUser;
}
