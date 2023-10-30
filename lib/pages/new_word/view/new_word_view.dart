import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/extensions/context_extension.dart';
import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/pages/new_word/viewmodel/new_word_viewmodel.dart';
import 'package:flutter/material.dart';

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
      return Scaffold(
        appBar: AppBar(
          elevation: 2,
          title: const Text(
            AppConstants.appName,
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
            },
          ),
        ),
        backgroundColor: ColorConstants.backgroundColor,
        body: Center(
          child: Column(
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
                        colors: ColorConstants.appBarColors,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(LocaleKeys.addNewWordPage_addNewWord.locale,
                            style: TextStyle(
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: ColorConstants.white)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: (context.width / 7), vertical: context.height / 10),
                          child: TextFormField(
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
                              labelText: 'Enter New Word',
                              labelStyle: customTextStyle2,
                            ),
                          ),
                        ),
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green,
                                textStyle: const TextStyle(fontSize: 20)),
                            onPressed: () async {
                              newWordViewModel.translatedWord =
                                  await viewModel.wordTranslate(newWordViewModel.textController.text) ??
                                      "Something is Wrong";
                            },
                            child: const Text("Translate")),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Text(newWordViewModel.translatedWord,
                              style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 36,
                                  color: ColorConstants.white)),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      );
    }
  }

  TextStyle customTextStyle =
      TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w600, fontSize: 20, color: ColorConstants.white);
  TextStyle customTextStyle2 =
      TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w400, color: ColorConstants.greySh4);
//TODO:extension

/*
  final gt = SimplyTranslator(EngineType.google);

  Future<String?> wordTranslate(String? word) async {
    String sourceLanguage = "tr";
    String translateLanguage = "en";
    String? translateResponse;

    if (word != null) {
      translateResponse = await gt.trSimply(word, translateLanguage, sourceLanguage);
    }
    print(translateResponse);

    if (translateResponse != null) {
      return translateResponse;
    } else {
      translateResponse = "Something wrong";
    }
    return translateResponse;
  }
  */
}
