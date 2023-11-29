import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/extensions/context_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/pages/exam/model/quest_model.dart';
import 'package:colorword_new/pages/exam/viewmodel/exam_viewmodel.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ExamView extends StatefulWidget {
  const ExamView({super.key});

  @override
  State<StatefulWidget> createState() => _ExamViewState();
}

class _ExamViewState extends State<ExamView> {
  final ExamViewModel viewModel = locator<ExamViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.createExamQuestList(allWords: viewModel.homeViewModel.words);
  }

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
                    itemCount: viewModel.examQuestList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return wordPage(
                        context: context,
                        questModel: viewModel.examQuestList[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildEmptyWordListPageInfo() {
    return wordPage(context: context, questModel: QuestModel(word: null, options: []));
  }

  Container wordPage({required BuildContext context, required QuestModel questModel}) {
    List<Widget> optionsWidget = questModel.options.map((e) {
      return buildOption(e);
    }).toList();

    return Container(
      height: context.height,
      width: context.width,
      color: questModel.word?.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
              const SizedBox(height: 80),
              Text(questModel.word?.word ?? '-',
                  style: TextStyle(
                      fontFamily: 'Manrope', fontWeight: FontWeight.w600, fontSize: 32, color: ColorConstants.white)),
              const SizedBox(height: 50),
            ] +
            optionsWidget,
      ),
    );
  }

  Text buildOption(String? option) {
    return Text(
      option ?? '-',
      style: TextStyle(fontFamily: 'Manrope', color: ColorConstants.white, fontSize: 20),
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