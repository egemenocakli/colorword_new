import 'package:flutter/material.dart';

class HintButtonWidget extends StatelessWidget {
  const HintButtonWidget({
    super.key,
    required this.onTap,
  });

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.black12),
      height: 40,
      width: 40,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onTap: onTap,
          child: const Icon(
            Icons.lightbulb_outlined,
            color: Colors.orangeAccent,
            size: 26,
          ),
        ),
      ),
    );
  }
}
