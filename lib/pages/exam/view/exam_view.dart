import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/extensions/context_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/models/word_model.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/pages/exam/viewmodel/exam_viewmodel.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ExamView extends StatefulWidget {
  const ExamView({super.key});

  @override
  State<StatefulWidget> createState() => _ExamViewState();
}

class _ExamViewState extends State<ExamView> {
  final ExamViewModel viewmodel = locator<ExamViewModel>();

  @override
  Widget build(BuildContext context) {
    return BaseView(viewModelBuilder: (_) => locator<ExamViewModel>(), builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, ExamViewModel viewModel) {
    return Scaffold(
      backgroundColor: viewModel.examWords![1]!.color,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: (viewModel.examWords?.length == null) || ((viewModel.examWords?.length ?? 0) <= 0)
                ? buildEmptyWordListPageInfo()
                : PageView.builder(
                    reverse: false,
                    itemCount: viewModel.examWords?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      viewmodel.createOtherOptions(viewModel.examWords, viewModel.homeViewModel.onPageWord);
                      viewModel.homeViewModel.onPageWord = viewModel.examWords?[index];
                      print(viewModel.homeViewModel.onPageWord!.word);
                      return wordPage(context: context, word: viewModel.examWords?[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildEmptyWordListPageInfo() {
    return wordPage(context: context, word: viewmodel.homeViewModel.createEmptyWord());
  }

  Container wordPage({required BuildContext context, required Word? word}) {
    return Container(
      height: context.height,
      width: context.width,
      color: word?.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 80),
          Text(word?.word ?? '-',
              style: TextStyle(
                  fontFamily: 'Manrope', fontWeight: FontWeight.w600, fontSize: 32, color: ColorConstants.white)),
          const SizedBox(height: 50),
          Text(
            viewmodel.options?[0] ?? '-',
            style: TextStyle(fontFamily: 'Manrope', color: ColorConstants.white, fontSize: 20),
          ),
          SizedBox(height: SizeConstants.wordBetweenSize),
          Text(
            viewmodel.options?[1] ?? '-',
            style: TextStyle(fontFamily: 'Manrope', color: ColorConstants.white, fontSize: 20),
          ),
          SizedBox(height: SizeConstants.wordBetweenSize),
          Text(
            viewmodel.options?[2] ?? '-',
            style: TextStyle(fontFamily: 'Manrope', color: ColorConstants.white, fontSize: 20),
          ),
          SizedBox(height: SizeConstants.wordBetweenSize),
          Text(
            viewmodel.options?[3] ?? '-',
            style: TextStyle(fontFamily: 'Manrope', color: ColorConstants.white, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
/**
 * 
 * Center(
          child: Container(
            child: Text(viewmodel.examWords?[1]?.word ?? "Your wordlist empty", style: const TextStyle(fontSize: 32)),
          ),
        ),
 */