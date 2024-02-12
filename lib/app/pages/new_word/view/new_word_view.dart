import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/app/pages/new_word/widget/add_word_fab_button_widget.dart';
import 'package:colorword_new/app/pages/new_word/widget/enter_word_text_widget.dart';
import 'package:colorword_new/app/pages/new_word/widget/entered_word_text_form_field.dart';
import 'package:colorword_new/app/pages/new_word/widget/select_language_widget.dart';
import 'package:colorword_new/app/pages/new_word/widget/translate_button_widget.dart';
import 'package:colorword_new/app/pages/new_word/widget/translated_word_widget.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/core/extensions/context_extension.dart';
import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:colorword_new/app/models/word_model.dart';
import 'package:colorword_new/core/utility/helpers.dart';
import 'package:colorword_new/core/widgets/my_appbar.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/app/pages/new_word/viewmodel/new_word_viewmodel.dart';
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

  Widget _buildScreen(BuildContext context, NewWordViewModel viewModel) {
    {
      return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          floatingActionButton: AddWordFabButtonWidget(
            viewModel: viewModel,
            onPressed: () async {
              if (viewModel.textController!.text.isNotEmpty && viewModel.textController?.text != null) {
                viewModel.translatedWord = await viewModel.wordTranslate(viewModel.textController?.text) ??
                    LocaleKeys.addNewWordPage_cantFindWord;
                addWord();
                mySnackbarWidget(
                    content: Text(LocaleKeys.addNewWordPage_alreadyAdded.locale,
                        textAlign: TextAlign.center, style: MyTextStyle.smallTextStyle()),
                    duration: const Duration(milliseconds: 1200),
                    context: context);
              }
            },
          ),
          resizeToAvoidBottomInset: true, //false'dı
          appBar: MyAppBar(
            context: context,
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
                        const EnterWordTextWidget(),
                        SelectLanguage(
                            sourceLanguage: viewModel.sourceLanguage,
                            translateLanguage: viewModel.translateLanguage,
                            viewModel: viewModel),
                        EnteredWordTextFormField(viewModel: viewModel),
                        TranslateButtonWidget(viewModel: viewModel),
                        TranslatedWordWidget(viewModel: viewModel),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      );
    }
  }

  Future<bool> onWillPop() async {
    await viewModel.reloadWords();
    viewModel.disposeAllValues();
    return true;
  }

  //TODO: aynı kelime varsa uyarı, bu kelime zaten ekli
  Future<void> addWord() async {
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
