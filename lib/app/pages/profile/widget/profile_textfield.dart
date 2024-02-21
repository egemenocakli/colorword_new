import 'package:colorword_new/core/extensions/context_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  const ProfileTextField(
      {super.key, this.textController, this.labelText, this.enabled, this.editOnTap, this.sendOnTap, this.focusNode});

  final TextEditingController? textController;
  final String? labelText;
  final bool? enabled;
  final VoidCallback? editOnTap;
  final VoidCallback? sendOnTap;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: context.width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white12),
          borderRadius: AllBorderRadius.mediumBorderRadius(),
          color: Colors.white12),
      child: Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: TextFormField(
                enabled: enabled,
                autofocus: true,
                focusNode: focusNode,
                cursorHeight: 24,
                maxLines: 1,
                controller: textController,
                style: MyTextStyle.smallTextStyle(overflow: TextOverflow.ellipsis),
                decoration: InputDecoration(
                  labelText: labelText,
                  labelStyle: MyTextStyle.smallTextStyle(textColor: Colors.white38),
                ),
              ),
            ),
          ),
          const VerticalDivider(
            color: Colors.white38,
            thickness: 2,
            width: 2,
          ),
          enabled == false
              ? IconButton(
                  color: Colors.white,
                  disabledColor: Colors.grey,
                  icon: const Icon(Icons.edit_note_rounded, size: 26),
                  onPressed: editOnTap,
                )
              : IconButton(
                  disabledColor: Colors.grey,
                  onPressed: sendOnTap,
                  icon: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                  ))
        ],
      ),
    );
  }
}
