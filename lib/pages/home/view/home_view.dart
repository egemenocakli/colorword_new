import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/extensions/context_extension.dart';
import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:colorword_new/core/models/word_model.dart';
import 'package:colorword_new/core/navigator/app_router.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/pages/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeScreenViewModel viewModel = locator<HomeScreenViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.readWords();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(viewModelBuilder: (_) => locator<HomeScreenViewModel>(), builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, HomeScreenViewModel homeScreenViewModel) {
    {
      return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          floatingActionButton: Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                addLearnedWordButton(),
                deleteWordButton(viewModel.onPageWord),
                addNewWordFAB(),
              ]), //addNewWordFAB(viewModel),
          appBar: AppBar(
            elevation: 2,
            title: Text(
              AppConstants.appName,
              style: TextStyle(
                  fontFamily: 'Manrope', fontWeight: FontWeight.w700, fontSize: 26, color: ColorConstants.white),
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app_outlined,
                    size: SizeConstants.appBarLargeIconSize, color: ColorConstants.iconColor),
                tooltip: LocaleKeys.mainPage_exitToolTip.locale,
                onPressed: () {
                  viewModel.signOutFromHome();
                  context.replaceRoute(const LoginRoute());
                },
              ),
            ],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: ColorConstants.appBarColors,
                ),
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.menu, color: ColorConstants.iconColor, size: SizeConstants.appBarMediumIconSize),
              tooltip: LocaleKeys.mainPage_menuIconToolTip.locale,
              onPressed: () {},
            ),
          ),
          backgroundColor: ColorConstants.backgroundColor,
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: (viewModel.words?.length == null) || ((viewModel.words?.length ?? 0) <= 0)
                    ? buildEmptyWordListPageInfo()
                    : PageView.builder(
                        reverse: false,
                        itemCount: viewModel.words?.length ?? 0,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          viewModel.onPageWord = viewModel.words?[index];
                          print(viewModel.onPageWord?.word);
                          return wordPage(context: context, word: viewModel.words?[index]);
                        },
                      ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Container deleteWordButton(Word? onPageWord) {
    return Container(
        margin: const EdgeInsets.only(bottom: 16, right: 10, top: 10, left: 10),
        child: FloatingActionButton(
          heroTag: "deleteButton",
          onPressed: () async {
            //Buraya word ün indexini ulaştırmalıyım
            await viewModel.deleteWord(viewModel.onPageWord);
          },
          backgroundColor: ColorConstants.deleteButtonColor,
          child: Icon(
            Icons.delete_outline_rounded,
            size: SizeConstants.iconSize,
            color: ColorConstants.iconWhiteColor,
          ),
        ));
  }

  Container addLearnedWordButton() {
    return Container(
        margin: const EdgeInsets.all(10),
        child: FloatingActionButton(
          heroTag: "learnedButton",
          onPressed: () {},
          backgroundColor: ColorConstants.learnedWordButton,
          child: Icon(
            Icons.task_alt_outlined,
            size: SizeConstants.iconSize,
            color: ColorConstants.iconWhiteColor,
          ),
        ));
  }

  Widget buildEmptyWordListPageInfo() {
    return wordPage(context: context, word: viewModel.createEmptyWord());
  }

  FloatingActionButton addNewWordFAB() {
    return FloatingActionButton.extended(
      heroTag: "addNewButton",
      onPressed: () {
        context.router.push(const NewWordRoute());
      },
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
          side: BorderSide(width: 1, color: ColorConstants.white)),
      icon: const Icon(Icons.add, size: 28),
      backgroundColor: ColorConstants.transparent,
      splashColor: ColorConstants.transparent,
      focusColor: ColorConstants.transparent,
      disabledElevation: 0,
      highlightElevation: 0,
      hoverColor: ColorConstants.transparent, //tıkladığındaki
      foregroundColor: ColorConstants.white, //yazı rengi
      label: Text(LocaleKeys.mainPage_addNewWord.locale, style: const TextStyle(fontSize: 20)),
      elevation: 0,
    );
  }

  Container wordPage({required BuildContext context, required Word? word}) {
    return Container(
      height: context.height,
      width: context.width,
      color: word?.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(word?.word ?? '-',
              style: TextStyle(
                  fontFamily: 'Manrope', fontWeight: FontWeight.w600, fontSize: 32, color: ColorConstants.white)),
          Text(
            word?.translatedWords?.firstOrNull ?? '-',
            style: TextStyle(fontFamily: 'Manrope', color: ColorConstants.white, fontSize: 20),
          ),
        ],
      ),
    );
  }

  Future<bool> onWillPop() async {
    return false;
  }
}
