import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Word {
  late final String? wordId;
  late String? word;
  late List<String?>? translatedWords;
  late Color? color;
  late int? score;
  late Timestamp? lastUpdateDate;
  late Timestamp? addDate;

  Word({this.wordId, this.word, this.translatedWords, this.color, this.score = 0, this.lastUpdateDate, this.addDate});

  Map<String, dynamic> toMap() {
    return {
      'wordId': wordId,
      'word': word?.toLowerCase(),
      'translatedWords': translatedWords,
      'color': "#${color.toString().substring(9, 16)}",
      'score': score,
      'lastUpdateDate': lastUpdateDate,
      'addDate': addDate
    };
  }

  Word.fromMap(Map<String, dynamic> map) : wordId = map['wordId'] {
    word = map['word'].toString().toLowerCase();
    translatedWords = loverCaseFromList(List.from(map['translatedWords']));
    color = (map['color'] == ""
        ? null
        : Color(int.tryParse('FF${(map['color']).toString().replaceAll('#', '')}', radix: 16)!))!;
    score = map['score'];
    lastUpdateDate = map['lastUpdateDate'];
    addDate = map['addDate'];
  }

  List<String> loverCaseFromList(List<String> list) {
    List<String> newList = [];

    for (String item in list) {
      newList.add(item.toLowerCase());
    }
    return newList;
  }
}
