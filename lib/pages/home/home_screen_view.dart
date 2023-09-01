import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/pages/home/home_screen_viewmodel.dart';
import 'package:flutter/material.dart';

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          BaseView<HomeScreenViewModel>(viewModelBuilder: (_) => locator<HomeScreenViewModel>(), builder: _buildScreen),
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
        AppConstants.appName,
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.exit_to_app_outlined, size: 32, color: ColorConstants.iconColor),
          tooltip: LocaleKeys.mainPage_exitToolTip.locale,
          onPressed: () {
            viewModel.signOutFromHome();
            context.router.pop();
          },
        ),
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: ColorConstants.appBarColors,
          ),
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.menu, color: ColorConstants.iconColor, size: 30),
        tooltip: LocaleKeys.mainPage_menuIconToolTip.locale,
        onPressed: () {},
      ),
    ),
    backgroundColor: ColorConstants.backgroundColor,
    body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(LocaleKeys.mainPage_words.locale),
        TextButton(
          onPressed: () => throw Exception(),
          child: const Text("Throw Test Exception"),
        ),
      ]),
    ),
  );
}
