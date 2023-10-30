import 'dart:async';

import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:simplytranslate/simplytranslate.dart';

class NewWordViewModel extends BaseViewModel {
  //final FirestoreService _firestoreService = FirestoreService();

  // late Word word = Word();
  int number = 0;
  TextEditingController textController = TextEditingController();
  String translatedWord = "";
  String? translateResponse;
  final gt = SimplyTranslator(EngineType.libre);

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
    String sourceLanguage = "tr";
    String translateLanguage = "en";

    if (word != null) {
      viewState = ViewState.loading;
      translateResponse = await gt.trSimply(word, translateLanguage, sourceLanguage);
      viewState = ViewState.loaded;
      print(translateResponse);

      translateResponse = translateResponse?.split(' ').firstOrNull;
      //TODO:eğerki iki kelime çıkarsa anlam veya cümle çevirirse sıkıntı çıkar. cümle veya kelime olarak seçtirmek lazım
    }

    if (translateResponse != null) {
      return translateResponse;
    } else {
      translateResponse = "Something wrong";
    }
    return translateResponse;
  }
}
