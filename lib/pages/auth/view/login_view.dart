import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:colorword_new/core/utility/helpers.dart';
import 'package:colorword_new/core/utility/view_helper.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/pages/auth/viewmodel/auth_viewmodel.dart';
import 'package:colorword_new/pages/auth/widgets/login_button_widget.dart';
import 'package:colorword_new/pages/auth/widgets/language_text_button_widget.dart';
import 'package:colorword_new/pages/auth/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage()
class LoginView extends StatefulWidget with ViewHelper {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late Color backgroundColor;

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
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              appName(),
              loginForm(viewModel),
              //TODO:dil değişince ekran yenilenmeli önceki halinde ekstra bir şeye gerek duyulmamıştı loginView2 de kullanılabiliyor
              //languageWidget(context),
              LanguageTextButtonWidget(
                context: context,
              ),
              footerWidgets(),
            ],
          ),
        ));
  }

  Padding languageWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: LanguageTextButtonWidget(
        context: context,
      ),
    );
  }

  Expanded appName() {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.only(top: 150),
        child: Text(
          AppConstants.appName,
          style:
              TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w700, fontSize: 36, color: ColorConstants.white),
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
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white10),
            //color: Colors.black12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //TODO: sayfa rengi değişince bozuluyor
                Text(LocaleKeys.login_dontHaveAccount.locale, style: GoogleFonts.roboto(fontWeight: FontWeight.w400)),
                TextButton(
                    onPressed: () {},
                    child: Text("Sign in",
                        style: GoogleFonts.roboto(color: Colors.white54, fontSize: 20, fontWeight: FontWeight.w700)))
              ],
            ),
          ),
        )
      ],
    );
  }
}
