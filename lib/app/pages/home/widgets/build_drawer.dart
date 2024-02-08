import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/auth_manager/auth_manager.dart';
import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:colorword_new/core/navigator/app_router.dart';
import 'package:flutter/material.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({super.key, required this.homeContext});

  final BuildContext homeContext;

  @override
  Drawer build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
                "${AuthManager.instance?.signedUser?.name}"
                " "
                "${AuthManager.instance?.signedUser?.lastname}",
                style: MyTextStyle.midTextStyle()),
            accountEmail: Text(AuthManager.instance?.signedUser?.email ?? '', style: MyTextStyle.xsmallTextStyle()),
            //currentAccountPicture: const FlutterLogo(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppConstants.background),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.blueAccent),
            title: Text(LocaleKeys.mainPage_profile.locale,
                style: MyTextStyle.smallTextStyle(textColor: ColorConstants.black)),

            ///TODO: autoroute guard
            onTap: () {
              context.router.push(const ProfileRoute());
            },
          ),
          ListTile(
            leading: const Icon(Icons.app_registration_rounded, color: Colors.redAccent),
            title: Text(LocaleKeys.mainPage_multipleChoise.locale,
                style: MyTextStyle.smallTextStyle(textColor: ColorConstants.black)),

            ///TODO:autoroute guard
            onTap: () {
              context.router.push(const MChoiceExamRoute());
            },
          ),
          ListTile(
            ///TODO:autoroute guard
            leading: const Icon(FontPackage.edit_alt, color: Colors.orange),
            title: Text(LocaleKeys.mainPage_writtenExam.locale,
                style: MyTextStyle.smallTextStyle(textColor: ColorConstants.black)),
            onTap: () {
              context.router.push(const WrittenExamRoute());
            },
          ),
        ],
      ),
    );
  }
}
