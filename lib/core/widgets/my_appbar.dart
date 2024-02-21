import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
    required this.context,
    this.leading,
    this.actions,
  }) : super(key: key);

  final BuildContext context;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      title: Text(
        AppConstants.appName,
        style: TextStyle(
            fontFamily: AppConstants.fontFamilyManrope,
            fontWeight: FontWeight.w700,
            fontSize: 26,
            color: ColorConstants.white),
      ),
      centerTitle: true,
      actions: actions,
      /* <Widget>[
        /* IconButton(
              icon: const Icon(Icons.menu_book_rounded),
              onPressed: () {
                context.router.push(const ExamRoute());
              },
            ), */
        IconButton(
          icon: Icon(Icons.exit_to_app_outlined,
              size: SizeConstants.appBarLargeIconSize, color: ColorConstants.iconColor),
          tooltip: LocaleKeys.mainPage_exitToolTip.locale,
          onPressed: () {
            viewModel.signOutFromHome();
            context.replaceRoute(const LoginRoute());
          },
        ),
      ], */
      leading: leading ??
          IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined, color: ColorConstants.iconColor, size: 30),
            onPressed: () {
              context.router.pop();
            },
          ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: ColorConstants.appBarColors,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
