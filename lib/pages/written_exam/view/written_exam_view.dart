import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/extensions/context_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
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

  @override
  void initState() {
    super.initState();
    focusNode = List.generate(homeViewModel.words.length, (index) => FocusNode());
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
                      controller: pageController,
                      pageSnapping: true,
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
          mistakeIcons(),
          textFieldWidget(pageIndex, word),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Text(
              word?.translatedWords?.firstOrNull ?? '-',
              style: TextStyle(fontFamily: AppConstants.fontFamilyManrope, color: ColorConstants.white, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
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

  Padding mistakeIcons() {
    return Padding(
      padding: const EdgeInsets.only(right: 50, top: 200),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
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

  Padding textFieldWidget(pageIndex, Word? word) {
    return Padding(
      padding: const EdgeInsets.only(top: 70, left: 50, right: 50),
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
              nextPage();
              controller.clear();
            } else if (word?.word != controller.text && controller.text.length == word?.word?.length) {
              viewModel.mistakes = viewModel.mistakes - 1;
              if (viewModel.mistakes <= 0) {
                print("başarısız deneme sayısı " "${viewModel.mistakes}");
                viewModel.decreasetheScore(point: 2, word: word);

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

  void nextPage() {
    pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.linear);
  }
}



//Gelecekte klasik test yöntemini değiştirirsem kullanacağım
/* import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/pages/classic_exam/viewmodel/classic_exam_viewmodel.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ClassicExamView extends StatefulWidget {
  const ClassicExamView({Key? key}) : super(key: key);

  @override
  State<ClassicExamView> createState() => _HomeViewState();
}

class _HomeViewState extends State<ClassicExamView> {
  //final HomeViewModel viewModel = locator<HomeViewModel>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(viewModelBuilder: (_) => locator<ClassicExamViewModel>(), builder: _buildScreen);
  }

  List<TextEditingController> controllers = List.generate(5, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(5, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  Widget _buildScreen(BuildContext context, ClassicExamViewModel viewModel) {
    {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Harf Girişi'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: 30.0,
                      child: TextField(
                        controller: controllers[index],
                        focusNode: focusNodes[index],
                        maxLength: 1,
                        obscureText: false, // Metni gizle
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          counter: SizedBox.shrink(), // Counter'ı gizle
                        ),
                        onChanged: (value) {
                          if (value.length == 1 && index < 4) {
                            FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                          } else if (value.isEmpty && index > 0) {
                            FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                          }
                        },
                        onEditingComplete: () {
                          //eğer cevapla eşleşmiyorsa belki burada hepsini sildiririm
                          if (index > 0) {
                            FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
 */