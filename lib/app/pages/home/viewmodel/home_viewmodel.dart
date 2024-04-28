import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorword_new/app/pages/home/repository/home_repository.dart';
import 'package:colorword_new/app/pages/new_word/viewmodel/new_word_viewmodel.dart';
import 'package:colorword_new/app/pages/profile/viewmodel/profile_viewmodel.dart';
import 'package:colorword_new/core/auth_manager/auth_manager.dart';
import 'package:colorword_new/core/auth_manager/model/user_model.dart';
import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:colorword_new/app/models/word_model.dart';
import 'package:colorword_new/core/utility/helpers.dart';
import 'package:colorword_new/app/pages/auth/model/firebase_user_model.dart';
import 'package:colorword_new/app/pages/auth/service/auth_firebase_service.dart';
import 'package:colorword_new/app/pages/auth/viewmodel/auth_viewmodel.dart';
import 'package:colorword_new/app/pages/home/service/home_service_interface.dart';

class HomeViewModel extends BaseViewModel implements IHomeService {
  final HomeRepository _homeRepository = HomeRepository();
  final AuthViewModel _authViewModel = AuthViewModel();
  late User? signedUser;
  ProfileViewModel profileViewModel = ProfileViewModel();

  late List<Word?> _words = [];
  Word? onPageWord;
  FirebaseUser? _currentAppUser;

  @override
  FutureOr<void> init() {
    signedUser = AuthManager.instance?.signedUser;
  }

  //getter
  List<Word?> get words => _words;

  FirebaseUser? get currentAppUser => _currentAppUser;

  //setter

  set currentAppUser(FirebaseUser? value) {
    _currentAppUser = value;
    notifyListeners();
  }

  Future<FirebaseUser?> getUserInfos() async {
    return await _authViewModel.getCurrentUser();
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

  Future<void> signOutFromHome() async {
    FirebaseAuthService authenticationFirebaseService = FirebaseAuthService();

    await authenticationFirebaseService.signOut();
    AuthManager.instance?.signedUser = User(email: "", lastname: "", name: "", photo: "", userId: "");
    _words = [];
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
      await _homeRepository.deleteWord(word).whenComplete(
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
    _words = (await _homeRepository.readWords()) ?? [];
    viewState = ViewState.loaded;
    return _words;
  }

  bool checkAnyEmptyTranslates({required List<Word?> wordList}) {
    List<Word?> getList;
    bool isAnyEmpty = false;
    getList = wordList;

    for (var word in getList) {
      if (word!.translatedWords!.isEmpty) {
        isAnyEmpty = true;
      } else {}
    }
    updateEmptyWords(wordList: wordList);
    return isAnyEmpty;
  }

  Future<void> updateEmptyWords({required List<Word?> wordList}) async {
    NewWordViewModel newWordViewModel = NewWordViewModel();
    String? translateResponse;
    List<Word?> getList;

    getList = wordList;

    for (var word in getList) {
      if (word!.translatedWords!.isEmpty) {
        translateResponse = await newWordViewModel.wordTranslate(word: word.word);

        Word newTranslatedWord = word;
        newTranslatedWord.translatedWords?.add(translateResponse);

        updateWord(newTranslatedWord);
      }
    }
    readWords();
  }

  @override
  Future<bool> updateWord(Word? word) async {
    if (word != null) {
      viewState = ViewState.loading;
      await _homeRepository.updateWord(word).whenComplete(
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
}
