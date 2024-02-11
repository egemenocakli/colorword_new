import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/app/pages/auth/widgets/app_name_widget.dart';
import 'package:colorword_new/app/pages/auth/widgets/footer_widgets.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:colorword_new/core/utility/helpers.dart';
import 'package:colorword_new/core/utility/view_helper.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/app/pages/auth/viewmodel/auth_viewmodel.dart';
import 'package:colorword_new/app/pages/auth/widgets/login_button_widget.dart';
import 'package:colorword_new/app/pages/auth/widgets/language_text_button_widget.dart';
import 'package:colorword_new/app/pages/auth/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:easy_localization/easy_localization.dart';

@RoutePage()
class AuthView extends StatefulWidget with ViewHelper {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
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
    // ignore: avoid_print some package problems, when i delete this doesnt work localizations., avoid_print
    print(context.locale);
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppNameWidget(backgroundColor: backgroundColor),
              loginForm(viewModel),
              LanguageTextButtonWidget(
                context: context,
              ),
              FooterWidgets(
                authViewModel: viewModel,
              )
            ],
          ),
        ));
  }

  Column loginForm(AuthViewModel viewModel) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: TextfieldWidget(hintText: LocaleKeys.login_login.locale, controller: viewModel.emailTextController),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child:
              TextfieldWidget(hintText: LocaleKeys.login_password.locale, controller: viewModel.passwordTextController),
        ),
        //TODO:Validate sonrası aktifleştirilecek buton.
        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: LoginButtonWidget(
              viewModel: viewModel,
              email: viewModel.emailTextController.text,
              password: viewModel.passwordTextController.text),
        ),
      ],
    );
  }
}
