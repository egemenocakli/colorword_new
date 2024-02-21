import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/app/pages/auth/widgets/app_name_widget.dart';
import 'package:colorword_new/app/pages/splash/viewmodel/splash_viewmodel.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/extensions/context_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/locator.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return BaseView(viewModelBuilder: (_) => locator<SplashViewModel>(), builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, SplashViewModel viewModel) {
    {
      return Scaffold(
        resizeToAvoidBottomInset: false,
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
          child: const Column(
            children: [
              AppNameWidget(),
            ],
          ),
        ),
      );
    }
  }
}
