import 'package:colorword_new/core/init/constants.dart';
import 'package:flutter/material.dart';

enum OptionState {
  none,
  correct,
  wrong,
}

class OptionModel {
  final String? optionText;
  OptionState optionState;

  OptionModel({
    required this.optionText,
    required this.optionState,
  });
}

extension OptionStateExtension on OptionState {
  Color get optionColor {
    switch (this) {
      case OptionState.correct:
        return ColorConstants.optionsButtonCorrectColor;
      case OptionState.wrong:
        return ColorConstants.optionsButtonWrongColor;
      default:
        return ColorConstants.optionsButtonDefaultColor;
    }
  }
}
