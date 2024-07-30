import 'dart:math';

import 'package:get/get.dart';

class WordController extends GetxController {
  RxInt currentQuestion = 0.obs;

  List<String> getAnswer(String word) {
    const String alphabet = 'abcdefghijklmnopqrstuvwxyz';
    Random random = Random();
    List<String> randomLetters = [];

    for (int i = 0; i < 12 - word.length; i++) {
      int randomIndex = random.nextInt(alphabet.length);
      randomLetters.add(alphabet[randomIndex]);
    }
    List<String> combinedList = [...randomLetters, ...word.split('')];

    combinedList.shuffle();

    return combinedList;
  }

  void nextQuestion() {
    if (currentQuestion.value != 4 - 1) {
      currentQuestion++;
    } else {
      currentQuestion.value = 0;
    }
  }
}
