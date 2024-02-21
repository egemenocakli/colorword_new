import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/app/pages/multipleChoiceExam/model/option_model.dart';
import 'package:flutter/material.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget({
    super.key,
    required this.onTap,
    required this.optionModel,
  });

  final VoidCallback onTap;
  final OptionModel? optionModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Material(
          borderRadius: AllBorderRadius.xlargeBorderRadius(),
          color: optionModel!.optionState.optionColor,
          child: InkWell(
            onTap: onTap,
            borderRadius: AllBorderRadius.xlargeBorderRadius(),
            splashColor: ColorConstants.green,
            focusColor: ColorConstants.green,
            hoverColor: ColorConstants.green,
            highlightColor: ColorConstants.optionShade,
            overlayColor: MaterialStateProperty.all(ColorConstants.optionShade),
            child: Container(
              color: ColorConstants.transparent,
              padding: const EdgeInsets.all(12),
              child:
                  Text(optionModel?.optionText ?? "-", style: MyTextStyle.midTextStyle(), textAlign: TextAlign.center),
            ),
          ),
        ),
      ),
    );
  }
}
