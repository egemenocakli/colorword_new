import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/extensions/context_extension.dart';
import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:colorword_new/app/models/word_model.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/app/pages/new_word/viewmodel/new_word_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../../../core/utility/helpers.dart';

@RoutePage()
class NewWordView extends StatefulWidget {
  const NewWordView({Key? key}) : super(key: key);

  @override
  State<NewWordView> createState() => _NewWordViewState();
}

class _NewWordViewState extends State<NewWordView> {
  final NewWordViewModel viewModel = locator<NewWordViewModel>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(viewModelBuilder: (_) => locator<NewWordViewModel>(), builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, NewWordViewModel newWordViewModel) {
    /*
    TextEditingController textController = TextEditingController();
    String translatedWord = "";
    */

    {
      return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          floatingActionButton: addNewWordFAB(),
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 2,
            title: Text(
              AppConstants.appName,
              style: TextStyle(
                  fontFamily: 'Manrope', fontWeight: FontWeight.w700, fontSize: 26, color: ColorConstants.white),
            ),
            centerTitle: true,
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
              icon: Icon(Icons.arrow_back_ios_outlined, color: ColorConstants.iconColor, size: 30),
              tooltip: LocaleKeys.mainPage_menuIconToolTip.locale,
              onPressed: () {
                context.router.pop();
                viewModel.reloadWords();
              },
            ),
          ),
          backgroundColor: ColorConstants.backgroundColor,
          body: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    height: context.height,
                    width: context.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                        colors: ColorConstants.backgroundGradientColors,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: context.height * 0.06),
                        pleaseEnterWordText(),
                        languageField(),
                        enteredWordTextFormField(newWordViewModel),
                        translateButton(newWordViewModel),
                        translatedWord(newWordViewModel),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      );
    }
  }

  Text pleaseEnterWordText() {
    return Text(LocaleKeys.addNewWordPage_addNewWord.locale,
        style:
            TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w600, fontSize: 20, color: ColorConstants.white));
  }

  Row languageField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            alignment: Alignment.center,
            height: 80,
            width: 60,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black12,
                side: const BorderSide(width: 0.1, strokeAlign: 20, color: Colors.transparent),
              ),
              onPressed: (null),
              child: Text(viewModel.translateLanguage, style: TextStyle(color: ColorConstants.white)),
            )),
        SizedBox(width: context.width * 0.1),
        IconButton(
            onPressed: () async {
              await viewModel.changeLanguage();
            },
            icon: const Icon(Icons.cached_outlined)),
        SizedBox(width: context.width * 0.1),
        Container(
            alignment: Alignment.center,
            height: 80,
            width: 60,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black12,
                side: const BorderSide(width: 0.1, strokeAlign: 20, color: Colors.transparent),
              ),
              onPressed: (null),
              child: Text(viewModel.sourceLanguage, style: TextStyle(color: ColorConstants.white)),
            ))
      ],
    );
  }

  Padding enteredWordTextFormField(NewWordViewModel newWordViewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 15),
      child: TextFormField(
        maxLines: (viewModel.textController!.text.length > 30) ? 2 : 1,
        controller: newWordViewModel.textController,
        style: customTextStyle,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(color: ColorConstants.greySh4)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.greySh4),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          labelText: LocaleKeys.addNewWordPage_enterNewWord.locale,
          labelStyle: customTextStyle2,
        ),
      ),
    );
  }

  OutlinedButton translateButton(NewWordViewModel newWordViewModel) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            foregroundColor: ColorConstants.white,
            backgroundColor: ColorConstants.buttonColorPink,
            textStyle: const TextStyle(fontSize: 20)),
        onPressed: () async {
          newWordViewModel.translatedWord = await viewModel.wordTranslate(newWordViewModel.textController?.text) ??
              LocaleKeys.addNewWordPage_cantFindWord;
        },
        child: Text(LocaleKeys.addNewWordPage_translate.locale));
  }

  Padding translatedWord(NewWordViewModel newWordViewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Text(newWordViewModel.translatedWord,
          style:
              TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w600, fontSize: 36, color: ColorConstants.white)),
    );
  }

  FloatingActionButton addNewWordFAB() {
    return FloatingActionButton(
        backgroundColor: ColorConstants.buttonColor,
        foregroundColor: ColorConstants.white,
        onPressed: viewModel.translateResponse != null && viewModel.translateResponse != "" ? addWord : null,
        child: const Icon(
          Icons.task_alt_outlined,
          size: 28,
        ));
  }

//TODO:extension
  TextStyle customTextStyle =
      TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w600, fontSize: 20, color: ColorConstants.white);
  TextStyle customTextStyle2 =
      TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w400, color: ColorConstants.greySh4);

  Future<bool> onWillPop() async {
    await viewModel.reloadWords();
    return true;
  }

  addWord() async {
    viewModel
        .addWord(
      Word(
        word: viewModel.textController?.text,
        translatedWords: [
          viewModel.translatedWord,
        ],
        color: Helpers.randomColor(),
      ),
    )
        .whenComplete(() {
      viewModel.clearVeriables();
    });
  }
}
