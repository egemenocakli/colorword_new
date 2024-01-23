import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/extensions/context_extension.dart';
import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:colorword_new/app/models/word_model.dart';
import 'package:colorword_new/core/navigator/app_router.dart';
import 'package:colorword_new/core/widgets/my_appbar.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/app/pages/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel viewModel = locator<HomeViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.readWords();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModelBuilder: (_) => locator<HomeViewModel>(),
        builder: _buildScreen);
  }

  ///TODO: sayfadaki widgetlar parçalanacak widgets klasörüne taşınacak
  Widget _buildScreen(BuildContext context, HomeViewModel viewModel) {
    {
      return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          drawer: buildDrawer(context),
          floatingActionButton: buildFab(viewModel),
          appBar: buildAppBar(viewModel, context),
          backgroundColor: ColorConstants.backgroundColor,
          body: buildBody(viewModel),
        ),
      );
    }
  }

  Column buildBody(HomeViewModel viewModel) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: (viewModel.words.isEmpty)
              ? buildEmptyWordListPageInfo()
              : PageView.builder(
                  reverse: false,
                  itemCount: viewModel.words.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    viewModel.onPageWord = viewModel.words[index];
                    return wordPage(
                        context: context, word: viewModel.words[index]);
                  },
                ),
        ),
      ],
    );
  }

  MyAppBar buildAppBar(HomeViewModel viewModel, BuildContext context) {
    return MyAppBar(
      leading: DrawerButton(
          style: ButtonStyle(
              iconSize: MaterialStatePropertyAll(SizeConstants.iconLSize))),
      context: context,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.exit_to_app_outlined,
              size: SizeConstants.appBarLargeIconSize,
              color: ColorConstants.iconColor),
          tooltip: LocaleKeys.mainPage_exitToolTip.locale,
          onPressed: () {
            viewModel.signOutFromHome();
            context.replaceRoute(const AuthRoute());
          },
        ),
      ],
    );
  }

  Padding buildFab(HomeViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            deleteWordButton(viewModel.onPageWord),
            addNewWordFAB(),
          ]),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
                "${viewModel.signedUser?.name}"
                " "
                "${viewModel.signedUser?.lastname}",
                style: MyTextStyle.midTextStyle()),
            accountEmail: Text(viewModel.signedUser?.email ?? '',
                style: MyTextStyle.xsmallTextStyle()),
            //currentAccountPicture: const FlutterLogo(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppConstants.background),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.blueAccent),
            title: Text(LocaleKeys.mainPage_profile.locale,
                style: MyTextStyle.smallTextStyle(
                    textColor: ColorConstants.black)),

            ///TODO: autoroute guard
            onTap: () {
              context.router.push(const ProfileRoute());
            },
          ),
          ListTile(
            leading: const Icon(Icons.app_registration_rounded,
                color: Colors.redAccent),
            title: Text(LocaleKeys.mainPage_multipleChoise.locale,
                style: MyTextStyle.smallTextStyle(
                    textColor: ColorConstants.black)),

            ///TODO:autoroute guard
            onTap: () {
              context.router.push(const MChoiceExamRoute());
            },
          ),
          ListTile(
            ///TODO:autoroute guard
            leading: const Icon(FontPackage.edit_alt, color: Colors.orange),
            title: Text(LocaleKeys.mainPage_writtenExam.locale,
                style: MyTextStyle.smallTextStyle(
                    textColor: ColorConstants.black)),
            onTap: () {
              context.router.push(const WrittenExamRoute());
            },
          ),
        ],
      ),
    );
  }

  Container deleteWordButton(Word? onPageWord) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: FloatingActionButton(
          heroTag: "deleteButton",
          onPressed: () async {
            await viewModel.deleteWord(viewModel.onPageWord);
          },
          backgroundColor: ColorConstants.deleteButtonColor,
          child: Icon(
            Icons.delete_outline_rounded,
            size: SizeConstants.iconLSize,
            color: ColorConstants.iconWhiteColor,
          ),
        ));
  }

  Widget buildEmptyWordListPageInfo() {
    return wordPage(context: context, word: viewModel.createEmptyWord());
  }

  Container addNewWordFAB() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: FloatingActionButton(
        heroTag: "addNewButton",
        onPressed: () {
          context.router.push(const NewWordRoute());
        },
        backgroundColor: ColorConstants.learnedWordButton,
        child: Icon(Icons.add,
            size: SizeConstants.iconLSize,
            color: ColorConstants.iconWhiteColor),
      ),
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
              style: MyTextStyle.xlargeTextStyle(fontWeight: FontWeight.w600)),
          Text(word?.translatedWords?.firstOrNull ?? '-',
              style: MyTextStyle.midTextStyle()),
          Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "${LocaleKeys.mainPage_score.locale}: ${word!.score}",
                style: MyTextStyle.smallTextStyle(fontWeight: FontWeight.w500),
              )),
        ],
      ),
    );
  }

  Future<bool> onWillPop() async {
    return false;
  }
}
///TODO:another pc github control