import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/app/pages/written_exam/widget/end_of_exam_result_widget.dart';
import 'package:colorword_new/app/pages/written_exam/widget/hint_button_widget.dart';
import 'package:colorword_new/app/pages/written_exam/widget/skip_button_widget.dart';
import 'package:colorword_new/app/pages/written_exam/widget/text_field_widget.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/extensions/context_extension.dart';
import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:colorword_new/app/models/word_model.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/app/pages/written_exam/viewmodel/written_exam_viewmodel.dart';
import 'package:colorword_new/app/pages/home/viewmodel/home_viewmodel.dart';
import 'package:colorword_new/core/widgets/arrow_back_page_number_widget.dart';
import 'package:colorword_new/app/pages/written_exam/widget/hint_word_widget.dart';
import 'package:colorword_new/app/pages/written_exam/widget/mistake_icons_widget.dart';
import 'package:colorword_new/app/pages/written_exam/widget/word_in_center.dart';
import 'package:flutter/material.dart';

@RoutePage()
class WrittenExamView extends StatefulWidget {
  const WrittenExamView({Key? key}) : super(key: key);

  @override
  State<WrittenExamView> createState() => _HomeViewState();
}

class _HomeViewState extends State<WrittenExamView> {
  final HomeViewModel homeViewModel = locator<HomeViewModel>();
  final WrittenExamViewModel viewModel = locator<WrittenExamViewModel>();
  TextEditingController controller = TextEditingController();
  PageController pageController = PageController(keepPage: false);
  List<FocusNode> focusNode = [];

  @override
  void initState() {
    super.initState();
    focusNode = List.generate(homeViewModel.words.length, (index) => FocusNode());
    viewModel.lastPageNumber = homeViewModel.words.length - 1;
    viewModel.examResultList = List.filled(viewModel.homeViewModel.words.length, false);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(viewModelBuilder: (_) => locator<WrittenExamViewModel>(), builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, WrittenExamViewModel viewModel) {
    {
      return Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: (homeViewModel.words.isEmpty)
                  ? buildEmptyWordListPageInfo()
                  : PageView.builder(
                      onPageChanged: (int pageIndex) {
                        changeFocus(pageIndex);
                      },
                      physics: const NeverScrollableScrollPhysics(),
                      controller: pageController,
                      pageSnapping: true,
                      allowImplicitScrolling: false,
                      reverse: false,
                      itemCount: homeViewModel.words.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int pageIndex) {
                        viewModel.pageIndex = pageIndex;
                        homeViewModel.onPageWord = homeViewModel.words[pageIndex];
                        return wordPage(context: context, word: homeViewModel.words[pageIndex], pageIndex: pageIndex);
                      },
                    ),
            ),
          ],
        ),
      );
    }
  }

  void changeFocus(int pageIndex) {
    controller.clear();
    Future.delayed(const Duration(seconds: 1), () {
      focusNode[pageIndex].requestFocus();
      viewModel.mistakes = 5;
    });
  }

  Widget buildEmptyWordListPageInfo() {
    return wordPage(context: context, word: homeViewModel.createEmptyWord());
  }

  Container wordPage({required BuildContext context, required Word? word, pageIndex}) {
    return Container(
      height: context.height,
      width: context.width,
      color: word?.color,
      child: Column(
        children: [
          ArrowBackPageNumberWidget(
            context: context,
            wordsLength: homeViewModel.words.length,
            pageIndex: pageIndex,
          ),
          hintButtonWidget(word: word, pageIndex: pageIndex),
          WordInCenter(translatedWord: word?.translatedWords?.firstOrNull ?? '-'),
          HintWordWidget(hintText: viewModel.hintText),
          examTextFieldWidget(pageIndex: pageIndex, word: word),
        ],
      ),
    );
  }

  ExamTextFieldWidget examTextFieldWidget({pageIndex, Word? word}) {
    return ExamTextFieldWidget(
      controller: controller,
      focusNode: focusNode[pageIndex],
      onChanged: (value) {
        setState(() {
          if (word?.word == controller.text) {
            viewModel.increasetheScore(point: 5, word: word);
            viewModel.examResultList[pageIndex] = true;
            snackbarWidget(
                content: Text(LocaleKeys.writtenExam_correct.locale,
                    textAlign: TextAlign.center, style: MyTextStyle.smallTextStyle()),
                duration: const Duration(seconds: 1));
            nextPage();
            controller.clear();
          } else if (word?.word != controller.text && controller.text.length == word?.word?.length) {
            viewModel.mistakes = viewModel.mistakes - 1;
            if (viewModel.mistakes <= 0) {
              viewModel.decreasetheScore(point: 2, word: word);
              viewModel.examResultList[pageIndex] = false;
              snackbarWidget(
                content: Text(LocaleKeys.writtenExam_false.locale,
                    textAlign: TextAlign.center, style: MyTextStyle.smallTextStyle()),
                duration: const Duration(seconds: 1),
              );
              nextPage();
              controller.clear();
            }
          }
        });
      },
      onEditingComplete: () {
        if (word?.word == controller.text) {
          viewModel.increasetheScore(point: 5, word: word);
          viewModel.examResultList[pageIndex] = true;
          snackbarWidget(
              content: Text(LocaleKeys.writtenExam_correct.locale,
                  textAlign: TextAlign.center, style: MyTextStyle.smallTextStyle()),
              duration: const Duration(seconds: 1));
          nextPage();
          controller.clear();
        }
      },
      word: word,
    );
  }

  Widget hintButtonWidget({Word? word, pageIndex}) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            skipButtonWidget(word, pageIndex),
            HintButtonWidget(
              onTap: () {
                if (viewModel.hintIndex < homeViewModel.words[viewModel.pageIndex]!.word!.length) {
                  viewModel.addLetterToController(homeViewModel.words[viewModel.pageIndex]!.word![viewModel.hintIndex]);
                  viewModel.hintIndex = viewModel.hintIndex + 1;
                  viewModel.mistakes = viewModel.mistakes - 1;
                  if (viewModel.mistakes <= 0) {
                    viewModel.decreasetheScore(point: 2, word: word);
                    viewModel.examResultList[viewModel.pageIndex] = false;
                    nextPage();
                    controller.clear();
                  }
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5.0, top: 10),
              child: MistakeIconsWidget(
                mistakes: viewModel.mistakes,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget skipButtonWidget(Word? word, pageIndex) {
    return SkipButtonWidget(onTap: () {
      viewModel.mistakes = viewModel.mistakes - 5;
      if (viewModel.mistakes <= 0) {
        viewModel.decreasetheScore(point: 2, word: word);
        viewModel.examResultList[pageIndex] = false;
        snackbarWidget(
          content: Text(LocaleKeys.writtenExam_skip.locale,
              textAlign: TextAlign.center, style: MyTextStyle.smallTextStyle()),
          duration: const Duration(seconds: 1),
        );
        nextPage();
        controller.clear();
      }
    });
  }

  Future<void> nextPage() async {
    if (viewModel.pageIndex != viewModel.lastPageNumber) {
      viewModel.cleanHintText();
      /* pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.linear); */
      pageController.nextPage(duration: const Duration(seconds: 1), curve: const Threshold(0.8));
    } else if (viewModel.pageIndex == viewModel.lastPageNumber) {
      viewModel.answerCounter();
      await snackbarWidget(
          content: EndOfExamResultWidget(
              totalQuestions: homeViewModel.words.length,
              correctAnswers: viewModel.correctAnswers,
              falseAnswers: viewModel.falseAnswers),
          duration: const Duration(seconds: 5));
      await Future.delayed(const Duration(seconds: 5));
      // ignore: use_build_context_synchronously
      context.router.pop();
    }
  }

  //TODO:pratik hale getirilecek
  Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>> snackbarWidget(
      {required Widget content, required Duration duration}) async {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: ColorConstants.black,
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
      padding: const EdgeInsets.only(right: 5.0, left: 15.0, bottom: 8.0, top: 8.0),
      closeIconColor: ColorConstants.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      content: content,
      duration: duration,
    ));
  }

  void hintButtonOnTap(Word? word) {
    if (viewModel.hintIndex < homeViewModel.words[viewModel.pageIndex]!.word!.length) {
      viewModel.addLetterToController(homeViewModel.words[viewModel.pageIndex]!.word![viewModel.hintIndex]);
      viewModel.hintIndex = viewModel.hintIndex + 1;
      viewModel.mistakes = viewModel.mistakes - 1;
      if (viewModel.mistakes <= 0) {
        viewModel.decreasetheScore(point: 2, word: word);
        viewModel.examResultList[viewModel.pageIndex] = false;
        nextPage();
        controller.clear();
      }
    }
  }
}
