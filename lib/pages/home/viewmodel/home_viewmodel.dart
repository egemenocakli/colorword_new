import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:colorword_new/core/models/word_model.dart';
import 'package:colorword_new/core/utility/helpers.dart';
import 'package:colorword_new/pages/auth/service/auth_firebase_service.dart';
import 'package:colorword_new/pages/home/service/home_service.dart';
import 'package:colorword_new/pages/home/service/home_service_interface.dart';

class HomeViewModel extends BaseViewModel implements IHomeService {
  final ExamService _homeService = ExamService();

  late List<Word?> _words = [];
  // late Word word = Word();
  Word? onPageWord;

  @override
  FutureOr<void> init() {}

  //getter
  List<Word?> get words => _words;

  //setter

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

  Future<void> signOutFromHome() async {
    FirebaseAuthService authenticationFirebaseService = FirebaseAuthService();

    authenticationFirebaseService.signOut();
  }

  @override
  Future<void> refreshData() {
    // TODO: implement refreshData
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteWord(Word? word) async {
    if (word != null) {
      viewState = ViewState.loading;
      //await _firestoreService.deleteWord(word).whenComplete(() {
      _homeService.deleteWord(word).whenComplete(
        () {
          readWords();
        },
      );

      viewState = ViewState.loaded;
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<Word?>> readWords() async {
    viewState = ViewState.loading;
    _words = (await _homeService.readWords()) ?? [];
    viewState = ViewState.loaded;
    return _words;
  }
}
