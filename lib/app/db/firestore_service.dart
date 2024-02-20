import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorword_new/app/db/db_base.dart';
import 'package:colorword_new/app/pages/auth/model/firebase_user_model.dart';
import 'package:colorword_new/core/auth_manager/auth_manager.dart';
import 'package:colorword_new/app/models/word_model.dart';
import 'package:colorword_new/core/auth_manager/model/user_model.dart';
import 'package:flutter/material.dart';

class FirestoreService implements DbBase {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  //final AuthViewModel _authViewModel = locator<AuthViewModel>();
  //late final appUser = _authViewModel.firebaseUser;
  //User? signedUser = AuthManager.instance?.signedUser;
  //üsttekiler ile Appuser bilgilerine ulaşabiliriz

  //Normalde yukarıdaki appUser ı kullanıyordum ancak logout sonrası loginde eski bilgiler kalıyor.
  //authmanager.instance.signed user ı bir signedUser a atadığımızda yine aynı durum oluyor eski bilgiler kalıyor.

  @override
  Future<bool> deleteWord(Word? word) async {
    bool sonuc = false;
    try {
      await db
          .collection("users")
          .doc(AuthManager.instance?.signedUser?.userId)
          .collection("words")
          .doc(word!.wordId)
          .delete()
          .then((value) {
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
          .doc(AuthManager.instance?.signedUser?.userId)
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
  Future<List<Word?>?> readWords() async {
    List<Word> words = [];

    try {
      await db
          .collection("users")
          .doc(AuthManager.instance?.signedUser?.userId)
          .collection("words")
          .get()
          .then((value) {
        for (var element in value.docs) {
          words.add(Word.fromMap(element.data()));
        }
      });

      //Eğer kişi ilk defa giriyorsa userinfo çalışsın kişi bilgileri kaydedilsin.
      //Şuanlık kalktı
      /* if (words.isEmpty) {
        createUserInfo();
      } */
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

      await db
          .collection("users")
          .doc(AuthManager.instance?.signedUser?.userId)
          .collection("words")
          .add(word.toMap())
          .then((value) async {
        await db
            .collection("users")
            .doc(AuthManager.instance?.signedUser?.userId)
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
          .doc(AuthManager.instance?.signedUser?.userId)
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

  Future<bool> createUserInfo({FirebaseUser? firebaseUser}) async {
    bool sonuc = false;
    try {
      if (firebaseUser != null) {
        User user = User(
            email: firebaseUser.email,
            userId: firebaseUser.userId,
            lastname: firebaseUser.lastname,
            name: firebaseUser.name,
            photo: "empty");
        await db.collection("users").doc(firebaseUser.userId).collection("userInfo").add(user.toMap());
      }
    } catch (e) {
      sonuc = false;
      debugPrint("db_firestore_service.createUserInfo işleminde hata:$e");
    }
    return sonuc;
  }

  Future<bool> increasetheScore({Word? word, required int point}) async {
    bool sonuc = false;
    try {
      word!.score = word.score! + point;

      await db
          .collection("users")
          .doc(AuthManager.instance?.signedUser?.userId)
          .collection("words")
          .doc(word.wordId.toString())
          .update(word.toMap())
          .then((value) {
        sonuc = true;
      });
    } catch (e) {
      sonuc = false;
      debugPrint("db_firestore_service.increasetheScore işleminde hata:$e");
    }
    return sonuc;
  }

  Future<bool> decreasetheScore({Word? word, required int point}) async {
    bool sonuc = false;

    try {
      if (word!.score! >= 1) {
        word.score = word.score! - point;
      } else {
        word.score = 0;
      }
      await db
          .collection("users")
          .doc(AuthManager.instance?.signedUser?.userId)
          .collection("words")
          .doc(word.wordId.toString())
          .update(word.toMap())
          .then((value) {
        sonuc = true;
      });
    } catch (e) {
      sonuc = false;
      debugPrint("db_firestore_service.decreasetheScore işleminde hata:$e");
    }
    return sonuc;
  }
}
