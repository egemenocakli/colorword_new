import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/extensions/context_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:flutter/material.dart';

class ArrowBackPageNumberWidget extends StatelessWidget {
  const ArrowBackPageNumberWidget(
      {super.key, required this.wordsLength, required this.pageIndex, required BuildContext context});

  final int wordsLength;
  final int pageIndex;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 30),
          child: IconButton(
              onPressed: () {
                context.router.pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: ColorConstants.black,
                size: 32,
              )),
        ),
        pageNumber(context, wordsLength, pageIndex)
      ],
    );
  }
}

Padding pageNumber(BuildContext context, int wordsLength, int pageIndex) {
  return Padding(
    padding: EdgeInsets.only(top: 20.0, left: context.width - 100),
    child: Text("${pageIndex + 1}" "/" "$wordsLength",
        style: const TextStyle(fontFamily: AppConstants.fontFamilyManrope, fontWeight: FontWeight.w600)),
  );
}
