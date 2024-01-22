import 'package:colorword_new/app/pages/auth/widgets/app_name_animation_widget.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:flutter/material.dart';

class AppNameWidget extends StatelessWidget {
  const AppNameWidget({super.key, required this.backgroundColor});

  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        //bottom azalttım telefonda iyi olması için, emülatör harici bottom 80, düzenlemem gerekli
        padding: const EdgeInsets.only(top: 150, bottom: 120, left: 20, right: 20),
        child: Container(
          child: const Center(
            child: AppNameAnimationWidget(
                text: AppConstants.appName,
                textStyle:
                    TextStyle(fontFamily: AppConstants.fontFamilyManrope, fontSize: 46, fontWeight: FontWeight.w700),
                duration: Duration(milliseconds: 500),
                startColor: Colors.white),
          ),
        ),
      ),
    );
  }
}
