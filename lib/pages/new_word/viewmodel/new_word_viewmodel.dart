import 'dart:async';

import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:colorword_new/core/enums/enum.dart';
import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:simplytranslate/simplytranslate.dart';

class NewWordViewModel extends BaseViewModel {
  //final FirestoreService _firestoreService = FirestoreService();

  // late Word word = Word();
  int number = 0;
  TextEditingController textController = TextEditingController();
  String translatedWord = "";
  String? translateResponse;
  final gt = SimplyTranslator(EngineType.google);
  String sourceLanguage = "TR";
  String translateLanguage = "EN";

  @override
  FutureOr<void> init() {}

  @override
  Future<void> refreshData() {
    // TODO: implement refreshData
    throw UnimplementedError();
  }

  //getter

  //setter

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
}
