import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorword_new/core/app_data/db/firestore_service.dart';
import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:colorword_new/core/models/word_model.dart';
import 'package:colorword_new/core/utility/helpers.dart';
import 'package:colorword_new/pages/auth/service/auth_firebase_service.dart';
import 'package:flutter/material.dart';

class HomeScreenViewModel extends BaseViewModel {
  final FirestoreService _firestoreService = FirestoreService();
  late List<Word?>? words = [];
  // late Word word = Word();
  int number = 0;

  @override
  FutureOr<void> init() {}

  //getter

  //setter

  Future<List<Word?>?> getWordList() async {
    ///TODO: BURADA ÖNCE STATE DEĞİŞİMİ SONRASINDA STATE DEĞİŞİMİ EKLİYCEM Kİ SAYFA YENİLENSİN
    viewState = ViewState.loading;
    words = await _firestoreService.readWords();
    viewState = ViewState.loaded;

    return words;
  }

  Word createEmptyWord() {
    Word emptyWord = Word(
        addDate: Timestamp.now(),
        color: Helpers.randomColor(),
        lastUpdateDate: Timestamp.now(),
        score: 0,
        translatedWords: ["Boş"],
        word: "Empty",
        wordId: "1");

    return emptyWord;
  }

  Future<void> addWord() async {
    Color wordColor = Helpers.randomColor();
    number = number + 1;
    Word newWord = Word(word: "$number.kelime", color: wordColor, translatedWords: ["$number.kelime anlamı"]);
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
