import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:colorword_new/core/navigator/app_router.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/pages/auth/viewmodel/auth_viewmodel.dart';
import 'package:colorword_new/pages/auth/widgets/language_text_button_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginView2 extends StatefulWidget {
  const LoginView2({super.key});

  @override
  State<LoginView2> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView2> {
  @override
  Widget build(BuildContext context) {
    return BaseView(viewModelBuilder: (_) => locator<AuthViewModel>(), builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, AuthViewModel viewModel) {
    {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage(AppConstants.background), fit: BoxFit.cover),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                appNameTitle(context),
                const SizedBox(height: 60),
                LanguageTextButtonWidget(context: context),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    backgroundTranspCard(context),
                    loginMessage(context),
                    loginButton(context, viewModel),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  Positioned loginButton(BuildContext context, AuthViewModel viewModel) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.3,
      right: MediaQuery.of(context).size.width * 0.3,
      child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(ColorConstants.buttonColor)),
          onPressed: () async {
            await viewModel.signInWithGoogle().then((value) {
              if (value != null) {
                context.replaceRoute(const HomeRoute());
              } else {}
            });
          },
          child: const Text(
            LocaleKeys.login_signWithGoogle,
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  Positioned loginMessage(BuildContext context) {
    return Positioned(
        right: MediaQuery.of(context).size.width * 0.3,
        top: MediaQuery.of(context).size.width * 0.1,
        height: 220,
        child: Text(
          textAlign: TextAlign.center,
          LocaleKeys.login_loginMessage.locale,
          style: const TextStyle(color: Colors.white),
        ));
  }

  Positioned backgroundTranspCard(BuildContext context) {
    return Positioned(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.6,
        color: Colors.white24,
      ),
    );
  }

  Text appNameTitle(BuildContext context) =>
      Text(AppConstants.appName, style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.white));
}

///TODO: Sayfa düzenlenecek gösterim sadece taslaktır
///TODO: Verilen size değerleri ekrana göre değişebilen esnek yapıya dönüştürülecek.
