import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/extensions/context_extension.dart';
import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:colorword_new/core/widgets/arrow_back_page_number_widget.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/app/pages/multipleChoiceExam/model/option_model.dart';
import 'package:colorword_new/app/pages/multipleChoiceExam/model/quest_model.dart';
import 'package:colorword_new/app/pages/multipleChoiceExam/viewmodel/mchoice_exam_viewmodel.dart';
import 'package:colorword_new/app/pages/multipleChoiceExam/widgets/option_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MChoiceExamView extends StatefulWidget {
  const MChoiceExamView({super.key});

  @override
  State<StatefulWidget> createState() => _MChoiceExamViewState();
}

class _MChoiceExamViewState extends State<MChoiceExamView> {
  final MChoiceExamViewModel viewModel = locator<MChoiceExamViewModel>();
  final controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    reloadWordList();
    viewModel.createExamQuestList(allWords: viewModel.examWords!);
    viewModel.examResultList = List.filled(viewModel.homeViewModel.words.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(viewModelBuilder: (_) => locator<MChoiceExamViewModel>(), builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, MChoiceExamViewModel viewModel) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: viewModel.examWords![1]!.color,
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: (viewModel.examWords?.length == null) ||
                      viewModel.options.length < 3 ||
                      ((viewModel.examWords?.length ?? 0) <= 0)
                  ? buildEmptyWordListPageInfo(viewModel.pageIndex ?? 1)
                  : PageView.builder(
                      allowImplicitScrolling: false,
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller,
                      reverse: false,
                      itemCount: viewModel.examQuestList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int pageIndex) {
                        viewModel.pageIndex = pageIndex;
                        return wordPage(
                            viewModel: viewModel,
                            context: context,
                            questModel: viewModel.examQuestList[pageIndex],
                            pageIndex: pageIndex);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmptyWordListPageInfo(int pageIndex) {
    return wordPage(
        context: context, questModel: QuestModel(word: null, options: []), viewModel: viewModel, pageIndex: pageIndex);
  }

  Container wordPage(
      {required BuildContext context,
      required QuestModel questModel,
      required MChoiceExamViewModel viewModel,
      required int pageIndex}) {
    return Container(
      height: context.height,
      width: context.width,
      color: questModel.word?.color,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: ArrowBackPageNumberWidget(
              wordsLength: viewModel.examQuestList.length, pageIndex: pageIndex, context: context),
        ),
        Text(questModel.word?.word ?? '-',
            style: MyTextStyle.xlargeTextStyle(fontWeight: FontWeight.w600, fontSize: 32), textAlign: TextAlign.center),
        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: buildOption(optionModelList: questModel.options, questModel: questModel, pageIndex: pageIndex),
        ),
      ]),
    );
  }

  Widget buildOption(
      {required List<OptionModel?> optionModelList, required QuestModel questModel, required int pageIndex}) {
    return optionModelList.isEmpty
        ? Container()
        : ListView.builder(
            shrinkWrap: true,
            itemCount: optionModelList.length,
            itemBuilder: (context, index) {
              return OptionWidget(
                optionModel: optionModelList[index],
                onTap: () {
                  onTapStation(questModel, optionModelList, index, pageIndex);
                },
              );
            },
          );
  }

  //sadece bir kere tıklanabilmeli
  void onTapStation(QuestModel questModel, List<OptionModel?> optionModelList, int index, int pageIndex) {
    setState(() {
      if (questModel.word?.translatedWords?[0] == optionModelList[index]?.optionText) {
        viewModel.increasetheScore(word: questModel.word, point: 3);
        viewModel.examResultList[pageIndex] = true;
        snackbarWidget(
            content: Text(LocaleKeys.writtenExam_correct.locale,
                textAlign: TextAlign.center, style: MyTextStyle.smallTextStyle()),
            duration: const Duration(milliseconds: 1200));
        for (var element in optionModelList) {
          element?.optionState = OptionState.wrong;
        }
        optionModelList[index]?.optionState = OptionState.correct;
        nextPage(controller);
      } else {
        viewModel.decreasetheScore(word: questModel.word, point: 2);
        viewModel.examResultList[pageIndex] = false;
        snackbarWidget(
          content: Text(LocaleKeys.writtenExam_false.locale,
              textAlign: TextAlign.center, style: MyTextStyle.smallTextStyle()),
          duration: const Duration(milliseconds: 1200),
        );
        for (var element in optionModelList) {
          if (questModel.word?.translatedWords?[0] == element?.optionText) {
            element?.optionState = OptionState.correct;
          } else {
            element?.optionState = OptionState.wrong;
          }
        }
        nextPage(controller);
      }
    });
  }

  Future<void> nextPage(PageController controller) async {
    if (viewModel.pageIndex != viewModel.lastPageNumber) {
      controller.nextPage(duration: const Duration(seconds: 3), curve: const Threshold(0.8));
    } else if (viewModel.pageIndex == viewModel.lastPageNumber) {
      viewModel.answerCounter();
      await snackbarWidget(content: endOfExamWidget(), duration: const Duration(seconds: 5));
      await Future.delayed(const Duration(seconds: 5));
      // ignore: use_build_context_synchronously
      context.router.pop();
    }
  }

  //TODO:pratik hale getirilecek
  Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>> snackbarWidget(
      {required Widget content, required Duration duration}) async {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.black,
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
      padding: const EdgeInsets.only(right: 5.0, left: 15.0, bottom: 8.0, top: 8.0),
      closeIconColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      content: content,
      duration: duration,
    ));
  }

  Widget endOfExamWidget() {
    return Column(children: [
      Text(
        LocaleKeys.writtenExam_congratulations.locale,
        style: MyTextStyle.smallTextStyle(),
      ),
      Text(
        LocaleKeys.writtenExam_totalQuestion.locale + viewModel.examWords!.length.toString(),
        style: MyTextStyle.smallTextStyle(),
      ),
      Text(
        LocaleKeys.writtenExam_totalCorrectAnswer.locale + viewModel.correctAnswers.toString(),
        style: MyTextStyle.smallTextStyle(),
      ),
      Text(
        LocaleKeys.writtenExam_totalWrongAnswer.locale + viewModel.falseAnswers.toString(),
        style: MyTextStyle.smallTextStyle(),
      )
    ]);
  }

  Future<bool> onWillPop() async {
    await viewModel.reloadWords();
    return true;
  }

  void reloadWordList() async {
    viewModel.examWords?.clear();
    viewModel.examWords?.addAll(viewModel.homeViewModel.words);
    viewModel.lastPageNumber = viewModel.examQuestList.length;
  }
}
