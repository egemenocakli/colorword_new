import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/extensions/context_extension.dart';
import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:colorword_new/app/models/word_model.dart';
import 'package:colorword_new/core/navigator/app_router.dart';
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
    //viewModel.getUserInfos();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(viewModelBuilder: (_) => locator<HomeViewModel>(), builder: _buildScreen);
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
                    return wordPage(context: context, word: viewModel.words[index]);
                  },
                ),
        ),
      ],
    );
  }

  AppBar buildAppBar(HomeViewModel viewModel, BuildContext context) {
    return AppBar(
      elevation: 2,
      title: Text(
        AppConstants.appName,
        style: TextStyle(
            fontFamily: AppConstants.fontFamilyManrope,
            fontWeight: FontWeight.w700,
            fontSize: 26,
            color: ColorConstants.white),
      ),
      centerTitle: true,
      actions: <Widget>[
        /* IconButton(
              icon: const Icon(Icons.menu_book_rounded),
              onPressed: () {
                context.router.push(const ExamRoute());
              },
            ), */
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
      /* leading: IconButton(
            icon: Icon(Icons.menu, color: ColorConstants.iconColor, size: SizeConstants.appBarMediumIconSize),
            tooltip: LocaleKeys.mainPage_menuIconToolTip.locale,
            onPressed: () {},
          ), */
    );
  }

  Padding buildFab(HomeViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //direction: Axis.horizontal,
          //alignment: WrapAlignment.end,
          //crossAxisAlignment: WrapCrossAlignment.end,
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
            accountName: Text("${viewModel.signedUser?.name}" " " "${viewModel.signedUser?.lastname}",
                style: const TextStyle(fontFamily: AppConstants.fontFamilyManrope)),
            accountEmail: Text(viewModel.signedUser?.email ?? '',
                style: const TextStyle(fontFamily: AppConstants.fontFamilyManrope)),
            currentAccountPicture: const FlutterLogo(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppConstants.background),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.blueAccent),
            title: const Text("Profile", style: TextStyle(fontFamily: AppConstants.fontFamilyManrope)),

            ///TODO:
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.app_registration_rounded, color: Colors.redAccent),
            title: const Text("Multiple-Choice Exam", style: TextStyle(fontFamily: AppConstants.fontFamilyManrope)),

            ///TODO:
            onTap: () {
              context.router.push(const ExamRoute());
            },
          ),
          ListTile(
            ///TODO:
            leading: const Icon(FontPackage.edit_alt, color: Colors.orange),
            title: const Text("Written Exam", style: TextStyle(fontFamily: AppConstants.fontFamilyManrope)),
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
        child: Icon(Icons.add, size: SizeConstants.iconLSize, color: ColorConstants.iconWhiteColor),
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
              style: TextStyle(
                  fontFamily: AppConstants.fontFamilyManrope,
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  color: ColorConstants.white)),
          Text(
            word?.translatedWords?.firstOrNull ?? '-',
            style: TextStyle(fontFamily: AppConstants.fontFamilyManrope, color: ColorConstants.white, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Text("Score: ${word!.score}",
              style: TextStyle(
                  fontFamily: AppConstants.fontFamilyManrope,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: ColorConstants.white)),
        ],
      ),
    );
  }

  Future<bool> onWillPop() async {
    return false;
  }
}
