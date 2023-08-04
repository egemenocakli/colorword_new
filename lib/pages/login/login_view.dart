import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/navigator/app_router.dart';
import 'package:colorword_new/pages/login/login_viewmodel.dart';
import 'package:flutter/material.dart';

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<LoginViewModel>(vmBuilder: (_) => LoginViewModel(), builder: _buildScreen),
    );
  }
}

@RoutePage()
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

Widget _buildScreen(BuildContext context, LoginViewModel viewModel) {
  return Scaffold(
    body: Center(
      child: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
        ),
        Text("ColorWord", style: Theme.of(context).textTheme.headlineLarge),
        const Placeholder(
          fallbackHeight: 200,
          fallbackWidth: 300,
        ),
        const Text("Merhaba"),
        const Text("Devam etmek için lütfen giriş yapınız."),
        ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange)),
            onPressed: () async {
              bool sonuc = await viewModel.signIn();
              if (sonuc) {
                context.router.push(const HomeScreenRoute());
              } else {
                context.router.push(const LoginRoute());
              }
            },
            child: const Text("Google ile giriş"))
      ]),
    ),
  );
}
