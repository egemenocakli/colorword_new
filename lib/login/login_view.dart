import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/navigator/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
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
              onPressed: () {
                context.router.push(const HomeScreenRoute());
              },
              child: const Text("Google ile giriş"))
        ]),
      ),
    );
  }
}
