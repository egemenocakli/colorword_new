import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/extensions/context_extension.dart';
import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:colorword_new/core/models/word_model.dart';
import 'package:colorword_new/core/navigator/app_router.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/pages/home/home_viewmodel.dart';
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
    viewModel.getWordList();
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
          floatingActionButton: addNewWordFAB(viewModel),
          appBar: AppBar(
            elevation: 2,
            title: const Text(
              AppConstants.appName,
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app_outlined, size: 32, color: ColorConstants.iconColor),
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
              icon: Icon(Icons.menu, color: ColorConstants.iconColor, size: 30),
              tooltip: LocaleKeys.mainPage_menuIconToolTip.locale,
              onPressed: () {},
            ),
          ),
          backgroundColor: ColorConstants.backgroundColor,
          body: Center(
            child: Column(
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
                            return wordPage(context: context, word: viewModel.words?[index]);
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget buildEmptyWordListPageInfo() {
    return wordPage(context: context, word: viewModel.createEmptyWord());
  }

  FloatingActionButton addNewWordFAB(HomeScreenViewModel viewModel) {
    return FloatingActionButton.extended(
      onPressed: () {
        //viewModel.addWord();
        context.router.push(const NewWordRoute());
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)), side: BorderSide(width: 1, color: Colors.white)),
      icon: const Icon(Icons.add, size: 28),
      backgroundColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      disabledElevation: 0,
      highlightElevation: 0,
      hoverColor: Colors.transparent, //tıkladığındaki
      foregroundColor: Colors.white, //yazı rengi
      label: const Text("Add New Word", style: TextStyle(fontSize: 20)),
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
            style: TextStyle(fontFamily: 'Manrope', color: ColorConstants.white),
          )
        ],
      ),
    );
  }

  Future<bool> onWillPop() async {
    return false;
  }
}
