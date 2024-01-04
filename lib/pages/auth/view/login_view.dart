import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:colorword_new/core/utility/helpers.dart';
import 'package:colorword_new/core/utility/view_helper.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/pages/auth/viewmodel/auth_viewmodel.dart';
import 'package:colorword_new/pages/auth/widgets/app_name_animation_widget.dart';
import 'package:colorword_new/pages/auth/widgets/login_button_widget.dart';
import 'package:colorword_new/pages/auth/widgets/language_text_button_widget.dart';
import 'package:colorword_new/pages/auth/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: unused_import
import 'package:easy_localization/easy_localization.dart';

@RoutePage()
class LoginView extends StatefulWidget with ViewHelper {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late Color backgroundColor;
  late AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return BaseView(viewModelBuilder: (_) => locator<AuthViewModel>(), builder: _buildScreen);
  }

  @override
  void initState() {
    backgroundColor = Helpers.randomColor();
    super.initState();
  }

  Widget _buildScreen(BuildContext context, AuthViewModel viewModel) {
    // ignore: avoid_print some package problems, when i delete this doesnt work localizations.
    print(context.locale);
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              appName(),
              loginForm(viewModel),
              LanguageTextButtonWidget(
                context: context,
              ),
              footerWidgets(),
            ],
          ),
        ));
  }

  Widget appName() {
    return Expanded(
      flex: 2,
      child: Padding(
        //bottom azalttım telefonda iyi olması için
        padding: const EdgeInsets.only(top: 150, bottom: 120, left: 20, right: 20),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: ColorConstants.white),
          child: Center(
            child: AppNameAnimationWidget(
                text: AppConstants.appName,
                textStyle: const TextStyle(
                    fontFamily: AppConstants.fontFamilyManrope, fontSize: 46, fontWeight: FontWeight.w700),
                duration: const Duration(milliseconds: 500),
                startColor: backgroundColor),
          ),
        ),
      ),
    );
  }

  Column loginForm(AuthViewModel viewModel) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: TextfieldWidget(hintText: LocaleKeys.login_login.locale),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: TextfieldWidget(hintText: LocaleKeys.login_password.locale),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: LoginButtonWidget(viewModel: viewModel),
        ),
      ],
    );
  }

  Column footerWidgets() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 60.0, top: 10),
          child: Divider(
            height: 1,
            color: Colors.grey,
            thickness: 0.5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: SizedBox(
            height: 50,
            width: 200,
            child: Material(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              child: InkWell(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Image(image: AssetImage(AppConstants.googleIcon), height: 28),
                    ),
                    Text(
                      LocaleKeys.login_signWithGoogle.locale,
                      style: GoogleFonts.roboto(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(LocaleKeys.login_dontHaveAccount.locale,
                    style: GoogleFonts.roboto(fontWeight: FontWeight.w600, color: Colors.white38)),
              ),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white12),
                child: TextButton(
                    onPressed: () {},
                    child: Text(LocaleKeys.login_signIn.locale,
                        style: GoogleFonts.roboto(color: Colors.white54, fontSize: 20, fontWeight: FontWeight.w700))),
              )
            ],
          ),
        )
      ],
    );
  }
}
