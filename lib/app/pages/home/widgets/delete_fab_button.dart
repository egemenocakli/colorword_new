import 'package:colorword_new/app/pages/home/viewmodel/home_viewmodel.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:flutter/material.dart';

class DeleteFabButton extends StatelessWidget {
  const DeleteFabButton({super.key, required this.homeViewModel});
  final HomeViewModel homeViewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: FloatingActionButton(
          heroTag: "deleteButton",
          onPressed: () async {
            await homeViewModel.deleteWord(homeViewModel.onPageWord);
          },
          backgroundColor: ColorConstants.deleteButtonColor,
          child: Icon(
            Icons.delete_outline_rounded,
            size: SizeConstants.iconLSize,
            color: ColorConstants.iconWhiteColor,
          ),
        ));
  }
}
