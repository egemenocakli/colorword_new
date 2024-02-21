import 'package:colorword_new/core/extensions/context_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.textController,
      this.labelText,
      this.enabled,
      this.editOnTap,
      this.sendOnTap,
      this.focusNode,
      this.keyboardType,
      this.textInputAction,
      this.autofocus,
      this.borderRadius,
      this.inputFormatters,
      this.validator});

  final TextEditingController? textController;
  final String? labelText;
  final bool? enabled;
  final VoidCallback? editOnTap;
  final VoidCallback? sendOnTap;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool? autofocus;
  final BorderRadiusGeometry? borderRadius;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: context.width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white12),
          borderRadius: borderRadius ?? AllBorderRadius.mediumBorderRadius(),
          color: Colors.white12),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 5),
        child: TextFormField(
          enabled: enabled ?? true,
          autofocus: autofocus ?? true,
          focusNode: focusNode,
          cursorHeight: 24,
          maxLines: 1,
          controller: textController,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          validator: validator,
          style: MyTextStyle.smallTextStyle(overflow: TextOverflow.ellipsis),
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: MyTextStyle.smallTextStyle(textColor: Colors.white38),
          ),
        ),
      ),
    );
  }
}
