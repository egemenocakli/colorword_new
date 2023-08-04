import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/pages/home/home_screen_viewmodel.dart';
import 'package:flutter/material.dart';

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<HomeScreenViewModel>(vmBuilder: (_) => HomeScreenViewModel(), builder: _buildScreen),
    );
  }
}

@RoutePage()
class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

Widget _buildScreen(BuildContext context, HomeScreenViewModel viewModel) {
  return Scaffold(
    appBar: AppBar(
      title: const Text(
        "ColorWord",

        ///TODO: string değerler başka yerden
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.exit_to_app_outlined, size: 32),
          tooltip: 'Exit',
          onPressed: () {
            viewModel.signOutFromHome();
            context.router.pop();
          },
        ),
      ],
      backgroundColor: ColorConstants.appBarColor,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        tooltip: 'Menu Icon',
        onPressed: () {},
      ),
    ),
    backgroundColor: ColorConstants.backgroundColor,
    body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("English Words"),
      TextButton(
          onPressed: () {
            viewModel.signOutFromHome();
            context.router.pop();
          },
          child: const Text("Cıkıs"))
    ])),
  );
}










/*
@RoutePage()
class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF725A7A),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("English Words"),
        TextButton(
            onPressed: () {
              context.router.pop();
            },
            child: const Text("Cıkıs"))
      ])),
    );
  }
}
*/