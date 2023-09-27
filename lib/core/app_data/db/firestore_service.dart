import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorword_new/core/app_data/db/db_base.dart';
import 'package:colorword_new/core/models/word_model.dart';
import 'package:colorword_new/pages/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../../locator.dart';

class FirestoreService implements DbBase {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final AuthViewModel _authViewModel = locator<AuthViewModel>();
  late final appUser = _authViewModel.appUser;
  //üsttekiler ile Appuser bilgilerine ulaşabiliriz

  @override
  Future<bool> deleteWord(Word word) async {
    bool sonuc = false;
    try {
      await db.collection("users").doc(appUser?.userId).collection("words").doc(word.wordId).delete().then((value) {
        sonuc = true;
      });
    } catch (e) {
      sonuc = false;
      debugPrint("db_firestore_service.deleteWord işleminde hata:$e");
    }

    return sonuc;
  }

  @override
  Future<Word?> readWord(String wordId) async {
    Word? word;
    try {
      await db
          .collection("users")
          .doc(appUser?.userId)
          .collection("words")
          .where('wordId', isEqualTo: wordId)
          .get()
          .then((value) {
        word = Word.fromMap(value.docs[0].data());
      });
    } catch (e) {
      debugPrint("db_firestore_service.readWord işleminde hata:$e");
    }

    return word;
  }

  @override
  Future<List<Word>> readWords() async {
    List<Word> words = [];

    try {
      //TODO: .doc düzeltilecek "_userViewModel.user.userId"
      await db.collection("users").doc(appUser?.userId).collection("words").get().then((value) {
        for (var element in value.docs) {
          words.add(Word.fromMap(element.data()));
        }
      });
    } catch (e) {
      debugPrint("db_firestore_service.readWords işleminde hata:$e");
    }

    return words;
  }

  @override
  Future<bool> addWord(Word word) async {
    bool sonuc = false;

    try {
      word.addDate = Timestamp.now();
      word.lastUpdateDate = Timestamp.now();

      await db.collection("users").doc(appUser?.userId).collection("words").add(word.toMap()).then((value) async {
        await db
            .collection("users")
            .doc(appUser?.userId)
            .collection("words")
            .doc(value.id)
            .update({'wordId': value.id});
      }).whenComplete(() {
        sonuc = true;
      });
    } catch (e) {
      sonuc = false;
      debugPrint("db_firestore_service.addWord işleminde hata:$e");
    }

    return sonuc;
  }

  @override
  Future<bool> updateWord(Word word) async {
    bool sonuc = false;

    try {
      word.lastUpdateDate = Timestamp.now();

      await db
          .collection("users")
          .doc(appUser?.userId)
          .collection("words")
          .doc(word.wordId.toString())
          .update(word.toMap())
          .then((value) {
        sonuc = true;
      });
    } catch (e) {
      sonuc = false;
      debugPrint("db_firestore_service.updateWord işleminde hata:$e");
    }

    return sonuc;
  }

  ///  FirestoreService fs_service = locator<FirestoreService>();
  ///  fs_service.transferWords("/users/111158171752851796884/words", "/users/FZORGACKmeV6nGOoRjs3k30bnGz1/words");
  Future<bool> transferWords(String sourcePath, String targetPath) async {
    await db.collection(sourcePath).get().then((value) async {
      for (var element in value.docs) {
        await db.collection(targetPath).add(element.data());
      }
    });

    return true;
  }
}
