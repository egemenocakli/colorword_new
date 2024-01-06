import 'package:flutter/material.dart';

class MistakeIconsWidget extends StatelessWidget {
  const MistakeIconsWidget({
    super.key,
    required this.mistakes,
  });

  final int mistakes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 45),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(mistakes <= 0 ? Icons.favorite_outline_rounded : Icons.favorite_rounded, color: Colors.redAccent),
          Icon(mistakes < 2 ? Icons.favorite_outline_rounded : Icons.favorite_rounded, color: Colors.redAccent),
          Icon(mistakes < 3 ? Icons.favorite_outline_rounded : Icons.favorite_rounded, color: Colors.redAccent),
          Icon(mistakes < 4 ? Icons.favorite_outline_rounded : Icons.favorite_rounded, color: Colors.redAccent),
          Icon(mistakes < 5 ? Icons.favorite_outline_rounded : Icons.favorite_rounded, color: Colors.redAccent),
        ],
      ),
    );
  }
}
