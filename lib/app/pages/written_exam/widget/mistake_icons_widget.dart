import 'package:flutter/material.dart';

class MistakeIconsWidget extends StatelessWidget {
  const MistakeIconsWidget({
    super.key,
    required this.mistakes,
  });

  final int mistakes;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(30),
        color: Colors.black12,
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 2, left: 2, bottom: 4, top: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(mistakes <= 0 ? Icons.favorite_outline_rounded : Icons.favorite_rounded, color: Colors.redAccent),
            Icon(mistakes < 2 ? Icons.favorite_outline_rounded : Icons.favorite_rounded, color: Colors.redAccent),
            Icon(mistakes < 3 ? Icons.favorite_outline_rounded : Icons.favorite_rounded, color: Colors.redAccent),
            Icon(mistakes < 4 ? Icons.favorite_outline_rounded : Icons.favorite_rounded, color: Colors.redAccent),
            Icon(mistakes < 5 ? Icons.favorite_outline_rounded : Icons.favorite_rounded, color: Colors.redAccent),
          ],
        ),
      ),
    );
  }
}
