import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/app/pages/profile/viewmodel/profile_viewmodel.dart';
import 'package:colorword_new/app/pages/profile/widget/delete_this_account_button.dart';
import 'package:colorword_new/app/pages/profile/widget/profile_textfield.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/extensions/context_extension.dart';
import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:colorword_new/core/widgets/my_appbar.dart';
import 'package:colorword_new/locator.dart';
import 'package:flutter/material.dart';

///TODO: profil bilgilerini gösterme, -ad soyad, email /eğer firebasede bilgileri düzenleme servisi varsa düzenlenecek
///hesabı silme, sildikten sonra uygulamadan atmakta lazım

@RoutePage()
class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return BaseView(viewModelBuilder: (_) => locator<ProfileViewModel>(), builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, ProfileViewModel viewModel) {
    {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorConstants.backgroundColor,
        appBar: MyAppBar(
          context: context,
        ),
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Container(
                  decoration: BoxDecoration(borderRadius: AllBorderRadius.mediumBorderRadius(), color: Colors.white10),
                  height: context.height - 150,
                  width: context.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            LocaleKeys.profilePage_userInfos.locale,
                            style: MyTextStyle.midTextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 5, top: 30),
                          child: ProfileTextField(
                            textController: viewModel.userNametextController,
                            labelText: LocaleKeys.profilePage_fullName.locale,
                            enabled: viewModel.textEditEnable,
                            focusNode: viewModel.nameFocusNode,
                            editOnTap: () {
                              viewModel.textEditEnable = true;
                              viewModel.nameFocusNode = FocusNode();
                              viewModel.nameFocusNode?.requestFocus();
                            },
                            sendOnTap: () {
                              if (viewModel.fullName != viewModel.userNametextController?.text) {
                                viewModel.updateName(viewModel.userNametextController?.text);
                              }

                              viewModel.textEditEnable = false;
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 5, top: 30),
                          child: ProfileTextField(
                            textController: viewModel.userEmailtextController,
                            labelText: LocaleKeys.profilePage_email.locale,
                            enabled: viewModel.textEditMailEnable,
                            focusNode: viewModel.emailFocusNode,
                            editOnTap: () {
                              viewModel.textEditMailEnable = true;
                              viewModel.emailFocusNode = FocusNode();
                              viewModel.emailFocusNode?.requestFocus();
                            },
                            sendOnTap: () {
                              if (viewModel.signedUser?.email != viewModel.userEmailtextController?.text) {
                                viewModel.updateEmail(viewModel.userEmailtextController?.text);
                              }
                              viewModel.textEditMailEnable = false;
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 5, top: 30),
                          child: ProfileTextField(
                            textController: viewModel.userIDtextController,
                            labelText: LocaleKeys.profilePage_userId.locale,
                            enabled: false,
                            editOnTap: null,
                          )),
                      DeleteThisAccountButton(
                        profileViewModel: viewModel,
                        /* confirmTextWidget: viewModel.timeCounterValue != 0
                            ? Text("CountDown:  ${viewModel.timeCounterValue}")
                            : Text(LocaleKeys.profilePage_confirm.locale, style: MyTextStyle.smallTextStyle()), */
                      ),
                      /* TextButton(
                        child: Text("Geri sayım  ${viewModel.timeCounterValue}"),
                        onPressed: () {
                          viewModel.startCountdown();
                        },
                      ), */
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
