import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/navigator/app_router.dart';
import 'package:flutter/material.dart';

class AddNewWordFabButton extends StatelessWidget {
  const AddNewWordFabButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: FloatingActionButton(
        heroTag: "addNewButton",
        onPressed: () {
          context.router.push(const NewWordRoute());
        },
        backgroundColor: ColorConstants.learnedWordButton,
        child: Icon(Icons.add, size: SizeConstants.iconLSize, color: ColorConstants.iconWhiteColor),
      ),
    );
  }
}
