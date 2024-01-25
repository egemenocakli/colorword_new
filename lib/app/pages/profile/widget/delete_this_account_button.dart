import 'dart:async';

import 'package:colorword_new/app/pages/profile/viewmodel/profile_viewmodel.dart';
import 'package:colorword_new/app/pages/profile/widget/profile_alert_dialog.dart';
import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:flutter/material.dart';

class DeleteThisAccountButton extends StatefulWidget {
  const DeleteThisAccountButton({super.key, required this.profileViewModel});
  final ProfileViewModel profileViewModel;

  @override
  State<DeleteThisAccountButton> createState() => _DeleteThisAccountButtonState();
}

class _DeleteThisAccountButtonState extends State<DeleteThisAccountButton> {
  String? confirmButtonText;
  @override
  void initState() {
    super.initState();
    confirmButtonText = LocaleKeys.profilePage_confirm.locale;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        onPressed: () async {
          showCounterDialog(mainContext: context, profileViewModel: widget.profileViewModel);
          if (widget.profileViewModel.selectedChoise == true) {
            widget.profileViewModel.deleteAccount();
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

  late final StreamSubscription checkSessionExpiration = Stream.periodic(
    const Duration(seconds: 10),
    (computationCount) {},
  ).listen((event) async {});

  Stream<int> countdownStream(int countDownValue) async* {
    while (countDownValue > 0) {
      countDownValue -= 1;
      await Future.delayed(const Duration(seconds: 1));

      yield countDownValue;
    }
  }

  showCounterDialog({
    required BuildContext mainContext,
    required ProfileViewModel profileViewModel,
  }) {
    showDialog(
        context: mainContext,
        builder: (context) {
          return StreamBuilder(
            stream: countdownStream.call(15),
            builder: (context, snapshot) {
              int? counterValue = snapshot.data ?? 15;
              return ProfileAlertDialog(
                confirmOnPressed: counterValue == 0
                    ? () {
                        if (counterValue == 0) {
                          profileViewModel.deleteAccount();
                          checkSessionExpiration.pause();
                        }
                      }
                    : () {},
                cancelOnPressed: () {
                  checkSessionExpiration.pause();
                  Navigator.pop(context);
                },
                backgroundColor: counterValue != 0 ? ColorConstants.grey : ColorConstants.alertCancelButton,
                title: LocaleKeys.profilePage_deleteAccount.locale,
                rejectButtonText: LocaleKeys.profilePage_cancel.locale,
                content: LocaleKeys.profilePage_deleteInfoMessage.locale,
                confirmButtonText:
                    counterValue != 0 ? "$confirmButtonText ($counterValue)" : LocaleKeys.profilePage_confirm.locale,
              );
            },
          );
        });
  }
}
