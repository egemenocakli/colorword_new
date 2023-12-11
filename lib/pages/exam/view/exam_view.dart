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
            shrinkWrap: true,
            itemCount: optionModelList.length,
            itemBuilder: (context, index) {
              return OptionWidget(
                optionModel: optionModelList[index],
                onTap: () {
                  onTapStation(questModel, optionModelList, index);
                },
              );
            },
          );
  }

  //sadece bir kere tıklanabilmeli
  void onTapStation(QuestModel questModel, List<OptionModel?> optionModelList, int index) {
    setState(() {
      changeThePage(controller);
      if (questModel.word?.translatedWords?[0] == optionModelList[index]?.optionText) {
        viewModel.increasetheScore(word: questModel.word, point: 2);
        for (var element in optionModelList) {
          element?.optionState = OptionState.wrong;
        }
        optionModelList[index]?.optionState = OptionState.correct;
      } else {
        viewModel.decreasetheScore(word: questModel.word, point: 1);
        for (var element in optionModelList) {
          if (questModel.word?.translatedWords?[0] == element?.optionText) {
            element?.optionState = OptionState.correct;
          } else {
            element?.optionState = OptionState.wrong;
          }
        }
      }
    });
  }

  //belki geçişi doğru yanlış bildiriminden sonra yapmalıyız
  //kişi doğru yanlışı görebilmeli sonra sayfa değişmeli
  //eğer son sayfadaysa durumunu ele al
  void changeThePage(PageController controller) {
    //controller.nextPage(duration: const Duration(seconds: 2), curve: const ElasticInCurve(4));
    //controller.nextPage(duration: const Duration(seconds: 1), curve: const Threshold(0.8)); //direkt anlık geçiş
    //controller.nextPage(duration: const Duration(seconds: 4), curve: Curves.easeInOutQuint);
    controller.nextPage(duration: const Duration(seconds: 4), curve: Curves.easeInOutQuint);
  }
}
