import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/extensions/context_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/pages/exam/model/option_model.dart';
import 'package:colorword_new/pages/exam/model/quest_model.dart';
import 'package:colorword_new/pages/exam/viewmodel/exam_viewmodel.dart';
import 'package:colorword_new/pages/exam/widgets/option_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ExamView extends StatefulWidget {
  const ExamView({super.key});

  @override
  State<StatefulWidget> createState() => _ExamViewState();
}

class _ExamViewState extends State<ExamView> {
  final ExamViewModel viewModel = locator<ExamViewModel>();
  final controller = PageController(initialPage: 0);

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
                    controller: controller,
                    reverse: false,
                    itemCount: viewModel.examQuestList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return wordPage(
                        viewModel: viewModel,
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
    return wordPage(context: context, questModel: QuestModel(word: null, options: []), viewModel: viewModel);
  }

  Container wordPage(
      {required BuildContext context, required QuestModel questModel, required ExamViewModel viewModel}) {
    return Container(
      height: context.height,
      width: context.width,
      color: questModel.word?.color,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(height: 80),
        Text(questModel.word?.word ?? '-',
            style: TextStyle(
                fontFamily: 'Manrope', fontWeight: FontWeight.w600, fontSize: 32, color: ColorConstants.white)),
        const SizedBox(height: 50),
        buildOption(optionModelList: questModel.options, questModel: questModel),
      ]),
    );
  }

//option model, text,renk, buton renk değişim optionState adında enum oluştur
//optionWidget sadece optionModel alsın

  //Column buildOption({required List<String?> option, required ExamViewModel viewModel}) {
  Widget buildOption({required List<OptionModel?> optionModelList, required QuestModel questModel}) {
    return optionModelList.isEmpty
        ? Container()
        : ListView.builder(
            //padding: EdgeInsets.symmetric(horizontal: context.width /3 ),
            shrinkWrap: true,
            itemCount: optionModelList.length,
            itemBuilder: (context, index) {
              return OptionWidget(
                optionModel: optionModelList[index],
                onTap: () {
                  //Birkere tıklanınca doğru olan yeşil diğerleri kırmızı yansın
                  //tıklanan doğruysa bunları da kenarda tutmak lazım kullanıcı bildi diye
                  setState(() {
                    if (questModel.word?.translatedWords?[0] == optionModelList[index]?.optionText) {
                      for (var element in optionModelList) {
                        element?.optionState = OptionState.wrong;
                      }
                      optionModelList[index]?.optionState = OptionState.correct;
                    } else {
                      for (var element in optionModelList) {
                        if (questModel.word?.translatedWords?[0] == element?.optionText) {
                          element?.optionState = OptionState.correct;
                        } else {
                          element?.optionState = OptionState.wrong;
                        }
                      }
                    }
                  });
                },
              );
            },
          );
  }
}



/**
   //Column buildOption({required List<String?> option, required ExamViewModel viewModel}) {
  Widget buildOption({required List<OptionModel?> optionModel, required QuestModel questModel}) {
    return optionModel.isEmpty
        ? Container()
        : Column(
            children: [
              OptionWidget(
                optionModel: optionModel[0],
                onTap: () {
                  if (questModel.word?.translatedWords?[0] == optionModel[0]?.optionText) {
                    optionModel[0]?.optionState = OptionState.correct;
                  } else if (questModel.word?.translatedWords?[0] != optionModel[0]?.optionText) {
                    optionModel[0]?.optionState = OptionState.wrong;
                  }
                },
              ),
              OptionWidget(
                optionModel: optionModel[1],
                onTap: () {
                  if (questModel.word?.translatedWords?[0] == optionModel[1]?.optionText) {
                    optionModel[1]?.optionState = OptionState.correct;
                  } else if (questModel.word?.translatedWords?[0] != optionModel[1]?.optionText) {
                    optionModel[1]?.optionState = OptionState.wrong;
                  }
                },
              ),
              OptionWidget(
                optionModel: optionModel[2],
                onTap: () {
                  if (questModel.word?.translatedWords?[0] == optionModel[2]?.optionText) {
                    optionModel[2]?.optionState = OptionState.correct;
                  } else if (questModel.word?.translatedWords?[0] != optionModel[2]?.optionText) {
                    optionModel[2]?.optionState = OptionState.wrong;
                  }
                },
              ),
              OptionWidget(
                optionModel: optionModel[3],
                onTap: () {
                  if (questModel.word?.translatedWords?[0] == optionModel[3]?.optionText) {
                    optionModel[3]?.optionState = OptionState.correct;
                  } else if (questModel.word?.translatedWords?[0] != optionModel[3]?.optionText) {
                    optionModel[3]?.optionState = OptionState.wrong;
                  }
                },
              ),
            ],
          );
  }
 */

/**
 import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/extensions/context_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/pages/exam/model/quest_model.dart';
import 'package:colorword_new/pages/exam/viewmodel/exam_viewmodel.dart';
import 'package:colorword_new/pages/exam/widgets/option_inkwell_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ExamView extends StatefulWidget {
  const ExamView({super.key});

  @override
  State<StatefulWidget> createState() => _ExamViewState();
}

class _ExamViewState extends State<ExamView> {
  final ExamViewModel viewModel = locator<ExamViewModel>();
  final controller = PageController(initialPage: 0);

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
                    controller: controller,
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
      if (e == viewModel.homeViewModel.onPageWord?.translatedWords?[0] && viewModel.isTap == true) {
        viewModel.optionsButtonColor = ColorConstants.optionsButtonCorrectColor;
      } else if (e != viewModel.homeViewModel.onPageWord?.translatedWords?[0]) {
        viewModel.optionsButtonColor = ColorConstants.optionsButtonDefaultColor;
      }

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

  Widget buildOption(List<String?> option) {
    return OptionWidget(viewModel: viewModel,optionList: option,onTap: (){
      
    },);
  }

/*   //Inkwell
  Text buildOption(String? option) {
    return Text(
      option ?? '-',
      style: TextStyle(fontFamily: 'Manrope', color: ColorConstants.white, fontSize: 20),
    );
  } */
}


/**
 * 
 * Center(
          child: Container(
            child: Text(viewmodel.examWords?[1]?.word ?? "Your wordlist empty", style: const TextStyle(fontSize: 32)),
          ),
        ),
 */

 */
