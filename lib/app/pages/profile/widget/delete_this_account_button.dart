import 'package:colorword_new/app/pages/profile/viewmodel/profile_viewmodel.dart';
import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:colorword_new/core/widgets/my_alert_dialog.dart';
import 'package:flutter/material.dart';

class DeleteThisAccountButton extends StatelessWidget {
  const DeleteThisAccountButton({super.key, required this.profileViewModel});
  final ProfileViewModel profileViewModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        onPressed: () async {
          profileViewModel.selectedChoise = await showDialog(
              context: context,
              builder: (context) => MyAlertDialog(
                  title: LocaleKeys.profilePage_deleteAccount.locale,
                  rejectButtonText: LocaleKeys.profilePage_cancel.locale,
                  content: LocaleKeys.profilePage_deleteInfoMessage.locale,
                  confirmButtonText: LocaleKeys.profilePage_confirm.locale));

          if (profileViewModel.selectedChoise == true) {
            profileViewModel.deleteAccount();
          } else {}
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: AllBorderRadius.smallBorderRadius(),
          ),
        ),
        child: Text(LocaleKeys.profilePage_deleteThisAccount.locale,
            style: MyTextStyle.smallTextStyle(textColor: Colors.white, fontWeight: FontWeight.w700)),
      ),
    );
  }
}
