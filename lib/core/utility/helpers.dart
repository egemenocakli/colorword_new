import 'package:flutter/material.dart';
import 'dart:math';

class Helpers {
  static Color randomColor() {
    int min = 0;
    int max = 200;
    Random random = Random();
    return Color.fromARGB(
        255, (min + random.nextInt(max - min)), (min + random.nextInt(max - min)), (min + random.nextInt(max - min)));
  }
}
