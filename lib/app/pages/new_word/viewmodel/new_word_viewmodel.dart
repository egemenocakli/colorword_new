import 'dart:async';
import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:colorword_new/core/enums/enum.dart';
import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/app/models/word_model.dart';
import 'package:colorword_new/locator.dart';
import 'package:colorword_new/app/pages/home/viewmodel/home_viewmodel.dart';
import 'package:colorword_new/app/pages/new_word/service/new_word_service.dart';
import 'package:colorword_new/app/pages/new_word/service/new_word_service_interface.dart';
import 'package:flutter/material.dart';
import 'package:simplytranslate/simplytranslate.dart';

class NewWordViewModel extends BaseViewModel implements INewWordService {
  final NewWordService _newWordService = NewWordService();
  TextEditingController? textController = TextEditingController();
  String translatedWord = "";
  String? translateResponse;
  final gt = SimplyTranslator(EngineType.google);
  String sourceLanguage = "TR";
  String translateLanguage = "EN";
  final HomeViewModel homeViewModel = locator<HomeViewModel>();
  bool _isSame = false;

  @override
  FutureOr<void> init() {}

  @override
  Future<void> refreshData() {
    // TODO: implement refreshData
    throw UnimplementedError();
  }

  void disposeAllValues() {
    translatedWord = "";
    translateResponse = "";
    textController?.text = "";
  }

  //getter
  bool get isSame => _isSame;

  //setter
  set isSame(bool value) {
    _isSame = value;
    notifyListeners();
  }

  Future<void> reloadWords() async {
    await homeViewModel.readWords();
  }

  Future<String?> wordTranslate(String? word) async {
    if (word != null) {
      viewState = ViewState.loading;
      translateResponse = await gt.trSimply(word, translateLanguage, sourceLanguage);
      viewState = ViewState.loaded;
      print(translateResponse);

      //Bir kelime çevirisinde defalarca aynı şeyi dönüyor bunun için firstü alıcaktım ama cümle çevirisinde bozuluyor.
      if (translateResponse?.split(' ').first == translateResponse?.split(' ').last) {
        translateResponse = translateResponse?.split(' ').first;
      }

      //TODO:eğerki iki kelime çıkarsa anlam veya cümle çevirirse sıkıntı çıkar. cümle veya kelime olarak seçtirmek lazım
    }

    if (translateResponse != null) {
      return translateResponse;
    } else {
      translateResponse = "Something wrong";
    }
    return translateResponse;
  }

  changeLanguage() {
    //TODO: Elimle atama yaptım eğer diğer dilleri de eklersek aşağıdaki mantık yürümeyecek.
    if (sourceLanguage == TranslateLanguages.turkish.languageShortName) {
      viewState = ViewState.loading;
      sourceLanguage = TranslateLanguages.english.languageShortName;
      translateLanguage = TranslateLanguages.turkish.languageShortName;
      viewState = ViewState.loaded;
    } else {
      viewState = ViewState.loading;
      sourceLanguage = TranslateLanguages.turkish.languageShortName;
      translateLanguage = TranslateLanguages.english.languageShortName;
      viewState = ViewState.loaded;
    }
  }

  void clearVeriables() {
    translatedWord = "";
    translateResponse = "";
    textController?.text = "";
  }

  @override
  Future<bool> addWord(Word? word) async {
    isSame = await compareWordWithList(word!);
    if (isSame != true) {
      return await _newWordService.addWord(word);
    } else {
      return isSame;
    }
  }

  Future<bool> compareWordWithList(Word newWord) async {
    if (homeViewModel.words.isNotEmpty) {
      for (int i = 0; i < homeViewModel.words.length;) {
        if (newWord.word == homeViewModel.words[i]!.word) {
          isSame = true;
          return isSame;
        } else {
          i++;
        }
      }
      return false;
    } else {
      return false;
    }
  }
}
