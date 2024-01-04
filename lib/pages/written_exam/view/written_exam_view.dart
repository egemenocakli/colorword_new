import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/extensions/context_extension.dart';
import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:colorword_new/core/models/word_model.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/pages/written_exam/viewmodel/written_exam_viewmodel.dart';
import 'package:colorword_new/pages/home/viewmodel/home_viewmodel.dart';
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
  late int falseAnswers;
  late int correctAnswers;
  int hintIndex = 0;

  @override
  void initState() {
    super.initState();
    focusNode = List.generate(homeViewModel.words.length, (index) => FocusNode());
    viewModel.lastPageNumber = homeViewModel.words.length - 1;
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
      viewModel.mistakes = 3;
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
          arrowBackButton(context),
          centerOfWord(word),
          hintWord(word),
          textFieldWidget(pageIndex, word),
          mistakeIcons(),
          hintButton(word),
        ],
      ),
    );
  }

  Row arrowBackButton(BuildContext context) {
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
        pageNumber(context)
      ],
    );
  }

  Padding pageNumber(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0, left: context.width - 100),
      child: Text("${viewModel.pageIndex + 1}" "/" "${homeViewModel.words.length}",
          style: const TextStyle(fontFamily: AppConstants.fontFamilyManrope, fontWeight: FontWeight.w600)),
    );
  }

  Padding centerOfWord(Word? word) {
    return Padding(
      padding: const EdgeInsets.only(top: 200.0),
      child: Text(
        word?.translatedWords?.firstOrNull ?? '-',
        style: TextStyle(
          fontFamily: AppConstants.fontFamilyManrope,
          color: ColorConstants.white,
          fontSize: 26,
        ),
      ),
    );
  }

  Padding hintWord(Word? word) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text(
        viewModel.hintText,
        style: TextStyle(
          fontFamily: AppConstants.fontFamilyManrope,
          color: ColorConstants.white,
          fontSize: 18,
        ),
      ),
    );
  }

  Padding textFieldWidget(pageIndex, Word? word) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: TextField(
        style: const TextStyle(
          letterSpacing: 10,
          fontSize: 26,
          color: Colors.white60,
        ),
        focusNode: focusNode[pageIndex],
        autocorrect: false,
        autofillHints: const [],
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
        controller: controller,
        maxLines: 1,
        maxLength: word?.word?.length ?? 1,
        autofocus: true,
        onChanged: (value) {
          setState(() {
            if (word?.word == controller.text) {
              viewModel.increasetheScore(point: 3, word: word);
              viewModel.examResultList[pageIndex] = true;
              nextPage();
              controller.clear();
            } else if (word?.word != controller.text && controller.text.length == word?.word?.length) {
              viewModel.mistakes = viewModel.mistakes - 1;
              if (viewModel.mistakes <= 0) {
                viewModel.decreasetheScore(point: 2, word: word);
                viewModel.examResultList[pageIndex] = false;
                nextPage();
                controller.clear();
                //TODO:Bilemediniz animasyonu
              }
            }
          });
        },
        onEditingComplete: () {
          if (word?.word == controller.text) {
            viewModel.increasetheScore(point: 3, word: word);
            viewModel.examResultList[pageIndex] = true;
            nextPage();
            controller.clear();
            //TODO:Bildiniz animasyonu
          }
        },
        cursorColor: Colors.white12,
        decoration: const InputDecoration(
          counterStyle: TextStyle(color: Colors.white54),
          border: InputBorder.none,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white54), // Odaklandığında çizgi rengi
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // Genel durumda çizgi rengi
          ),
        ),
      ),
    );
  }

  Widget mistakeIcons() {
    return Padding(
      padding: const EdgeInsets.only(left: 45),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(viewModel.mistakes < 1 ? Icons.favorite_outline_rounded : Icons.favorite_rounded,
              color: Colors.redAccent),
          Icon(viewModel.mistakes < 2 ? Icons.favorite_outline_rounded : Icons.favorite_rounded,
              color: Colors.redAccent),
          Icon(viewModel.mistakes < 3 ? Icons.favorite_outline_rounded : Icons.favorite_rounded,
              color: Colors.redAccent),
        ],
      ),
    );
  }

  Future<void> nextPage() async {
    if (viewModel.pageIndex != viewModel.lastPageNumber) {
      cleanHintText();
      pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.linear);
    } else if (viewModel.pageIndex == viewModel.lastPageNumber) {
      answerCounter();
      await snackbarWidget();
      await Future.delayed(const Duration(seconds: 5));
      // ignore: use_build_context_synchronously
      context.router.pop();
    }
  }

  void cleanHintText() {
    viewModel.hintText = "";
    hintIndex = 0;
  }

  void answerCounter() {
    //TODO:Word objesinde kaç kere yanlış bilindiğini tutabiliriz.
    falseAnswers = viewModel.examResultList.where((element) => element == false).length;
    correctAnswers = viewModel.examResultList.where((element) => element == true).length;
  }

  Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>> snackbarWidget() async {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      content: Column(children: [
        Text(LocaleKeys.writtenExam_congratulations.locale),
        Text(LocaleKeys.writtenExam_totalQuestion.locale + homeViewModel.words.length.toString()),
        Text(LocaleKeys.writtenExam_totalCorrectAnswer.locale + correctAnswers.toString()),
        Text(LocaleKeys.writtenExam_totalWrongAnswer.locale + falseAnswers.toString())
      ]),
      duration: const Duration(seconds: 5),
    ));
  }

  Widget hintButton(Word? word) {
    return Padding(
      padding: const EdgeInsets.only(right: 40.0),
      child: Align(
        alignment: Alignment.topRight,
        child: InkWell(
          onTap: () {
            if (hintIndex < homeViewModel.words[viewModel.pageIndex]!.word!.length) {
              _addLetterToController(homeViewModel.words[viewModel.pageIndex]!.word![hintIndex]);
              hintIndex = hintIndex + 1;
            }
          },
          child: Icon(
            Icons.lightbulb_outlined,
            color: Colors.grey.shade300,
            size: 26,
          ),
        ),
      ),
    );
  }

  void _addLetterToController(String letter) {
    viewModel.hintText += letter;
  }
}
