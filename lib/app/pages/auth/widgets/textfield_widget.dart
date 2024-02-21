import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const TextfieldWidget({super.key, this.hintText, this.labelText, this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        validator: validator,
        autocorrect: false,
        maxLines: 1,
        minLines: 1,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          filled: true,
          labelStyle: const TextStyle(color: Colors.black),
          hintStyle: const TextStyle(color: Colors.grey),
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
        ));
  }
}
