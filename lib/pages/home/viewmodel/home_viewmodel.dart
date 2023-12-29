import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:colorword_new/core/models/word_model.dart';
import 'package:colorword_new/core/utility/helpers.dart';
import 'package:colorword_new/pages/auth/model/app_user_model.dart';
import 'package:colorword_new/pages/auth/service/auth_firebase_service.dart';
import 'package:colorword_new/pages/auth/viewmodel/auth_viewmodel.dart';
import 'package:colorword_new/pages/home/service/home_service.dart';
import 'package:colorword_new/pages/home/service/home_service_interface.dart';

class HomeViewModel extends BaseViewModel implements IHomeService {
  final HomeService _homeService = HomeService();
  final AuthViewModel _authViewModel = AuthViewModel();

  late List<Word?> _words = [];
  // late Word word = Word();
  Word? onPageWord;
  AppUser? _currentAppUser;

  @override
  FutureOr<void> init() {}

  //getter
  List<Word?> get words => _words;

  AppUser? get currentAppUser => _currentAppUser;

  //setter

  set currentAppUser(AppUser? value) {
    _currentAppUser = value;
    notifyListeners();
  }

  Future<AppUser?> getUserInfos() async {
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
