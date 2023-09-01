import 'package:flutter/material.dart';

mixin ViewHelper {
  void showSnackBarMessage({
    required BuildContext context,
    String? message,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black, duration: duration ?? const Duration(seconds: 5), content: Text(message ?? '')));
  }
}
