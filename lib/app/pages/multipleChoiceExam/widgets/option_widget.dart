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
          borderRadius: BorderRadius.circular(30),
          color: optionModel!.optionState.optionColor,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(30),
            splashColor: Colors.green,
            focusColor: Colors.green,
            hoverColor: Colors.green,
            highlightColor: Colors.white24,
            overlayColor: MaterialStateProperty.all(Colors.white24),
            child: Container(
              color: Colors.transparent,
              height: 60,
              padding: const EdgeInsets.all(12),
              child: Text(
                optionModel?.optionText ?? "-",
                style: TextStyle(fontFamily: 'Manrope', color: ColorConstants.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
