import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:colorword_new/app/pages/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';

class LoginButtonWidget extends StatelessWidget {
  final AuthViewModel viewModel;
  final String email;
  final String password;

  const LoginButtonWidget({
    super.key,
    required this.viewModel,
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 200,
      child: ElevatedButton(
          style: ButtonStyle(
              elevation: const MaterialStatePropertyAll(20),
              backgroundColor: const MaterialStatePropertyAll(Colors.white54),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))),
          onPressed: () async {
            //TODO:validate
/*             await viewModel.signInWithEmailPassword(email: email, password: password).then((value) {
              context.replaceRoute(const HomeRoute());
            }); */

            /* await viewModel.signInWithGoogle().then((value) {
              if (value != null) {
                context.replaceRoute(const HomeRoute());
              } else {}
            }); */
          },
          child: Text(
            LocaleKeys.login_login.locale,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          )),
    );
  }
}
