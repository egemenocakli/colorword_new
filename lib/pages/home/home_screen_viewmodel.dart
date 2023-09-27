import 'dart:async';
import 'package:colorword_new/core/app_data/db/firestore_service.dart';
import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:colorword_new/core/models/word_model.dart';
import 'package:colorword_new/core/utility/helpers.dart';
import 'package:colorword_new/pages/auth/service/auth_firebase_service.dart';
import 'package:flutter/material.dart';

class HomeScreenViewModel extends BaseViewModel {
  final FirestoreService _firestoreService = FirestoreService();
  late List<Word?>? words = [];
  late Word word = Word();

  @override
  FutureOr<void> init() {}

  //getter

  //setter

  Future<List<Word?>?> getWordList() async {
    ///TODO: BURADA ÖNCE STATE DEĞİŞİMİ SONRASINDA STATE DEĞİŞİMİ EKLİYCEM Kİ SAYFA YENİLENSİN
    viewState = ViewState.loading;
    words = await _firestoreService.readWords();
    viewState = ViewState.loaded;
    getOneWord(words);
    /*
    if (words![0] == null) {
      words![0]!.word = "empty";
      return words;
    }
    */
    return words;
  }

  Future<Word?> getOneWord(List<Word?>? words) async {
    if (words != null) {
      word = words[0]!;
    }
    return word;
  }

  Future<void> addWord() async {
    Color wordColor = Helpers.randomColor();
    Word newWord = Word(word: "5.kelime", color: wordColor, translatedWords: ["5.kelime anlamı"]);
    await _firestoreService.addWord(newWord);
  }

  Future<void> signOutFromHome() async {
    FirebaseAuthService authenticationFirebaseService = FirebaseAuthService();

    authenticationFirebaseService.signOut();
  }

  @override
  Future<void> refreshData() {
    // TODO: implement refreshData
    throw UnimplementedError();
  }
}
