import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/app/pages/signUp/viewmodel/sign_up_viewmodel.dart';
import 'package:colorword_new/core/widgets/custom_textfield_widget.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/extensions/context_extension.dart';
import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:colorword_new/core/widgets/custom_elevated_button.dart';
import 'package:colorword_new/core/widgets/my_appbar.dart';
import 'package:colorword_new/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@RoutePage()
class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView(viewModelBuilder: (_) => locator<SignUpViewModel>(), builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, SignUpViewModel viewModel) {
    return Scaffold(
      appBar: MyAppBar(context: context),
      backgroundColor: ColorConstants.backgroundColor,
      body: Container(
        height: context.height,
        width: context.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: ColorConstants.backgroundGradientColors,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 30, right: 30),
                  child: CustomTextField(
                    labelText: LocaleKeys.signUp_name.locale,
                    textController: viewModel.nameTextController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[a-z A-Z]+$'))],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: CustomTextField(
                    labelText: LocaleKeys.signUp_lastName.locale,
                    textController: viewModel.lastNameTextController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[a-z A-Z]+$'))],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: CustomTextField(
                    labelText: LocaleKeys.signUp_phone.locale,
                    textController: viewModel.phoneTextController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$'))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: CustomTextField(
                    labelText: LocaleKeys.profilePage_email.locale,
                    textController: viewModel.emailTextController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value != null || value!.isNotEmpty) {
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return "Enter Correct Email Address";
                        } else {
                          return null;
                        }
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: CustomTextField(
                    labelText: "Password",
                    textController: viewModel.passwordTextController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validator: (p0) {
                      if (viewModel.passwordTextController.text != viewModel.repeatPasswordTextController.text) {
                        return "Passwords does not match";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: CustomTextField(
                    labelText: "Repeat Password",
                    textController: viewModel.repeatPasswordTextController,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    validator: (p0) {
                      if (viewModel.passwordTextController.text != viewModel.repeatPasswordTextController.text) {
                        return "Passwords does not match";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: CustomElevatedButton(
                    onPressed: () async {
                      if (viewModel.nameTextController.text.isNotEmpty &&
                          viewModel.lastNameTextController.text.isNotEmpty &&
/*                           viewModel.emailTextController.text.isNotEmpty &&
                          viewModel.phoneTextController.text.isNotEmpty && */
                          viewModel.passwordTextController.text.isNotEmpty &&
                          viewModel.repeatPasswordTextController.text.isNotEmpty &&
                          viewModel.passwordTextController.text == viewModel.repeatPasswordTextController.text) {
                        if (formKey.currentState!.validate()) {
                          await viewModel.signUp(
                              email: viewModel.emailTextController.text,
                              password: viewModel.passwordTextController.text);
                          /* name: viewModel.nameTextController.text,
                              lastName: viewModel.lastNameTextController.text);  */
                        }
                      }
                    },
                    onButtonText: LocaleKeys.login_signUp.locale,
                    buttonColor: ColorConstants.optionsButtonCorrectColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
