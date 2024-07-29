import 'dart:math';

import 'package:get/get.dart';

class WordController extends GetxController {
  RxInt inCorrectAnswers = 0.obs;
  RxInt correctAnswers = 0.obs;

  RxInt currentQuestion = 0.obs;

  List<Map<String, dynamic>> questions = [
    {
      'question': "Bozordan bir oldim. Uyga ming keldim.",
      'answer': ['a', 'n', 'o', 'r']
    },
    {
      'question': "Yerdagi to'q sariq tirnoq.",
      'answer': ['s', 'a', 'b', 'z', 'i']
    },
    {
      'question': "Ortib, achchiq qizil meva, Oq dengizda suzar kema.",
      'answer': ['d', 'a', 'z', 'm', 'o', 'l']
    },
    {
      'question': "Tinmas bitta, Tinglar mingta.",
      'answer': ['r', 'a', 'd', 'i', 'o']
    },
    {
      'question': "Sen ichida tursang tikka, Olib chiqar yuksaklikka.",
      'answer': ['l', 'i', 'f', 't']
    },
    {
      'question': "Olmasang yarim nafas, Yo'ldan o'tgani qo'ymas.",
      'answer': ['v', 'e', 'r', 'g', 'u', 'l']
    },
    {
      'question': "Odamzodda nima ko'p?",
      'answer': ['u', 'm', 'i', 'd']
    },
    {
      'question': "Suv qayerda ustundek turadi?",
      'answer': ['q', 'u', 'd', 'u', 'q']
    },
    {
      'question':
          "Besh harfdan iborat bo'lgan sichqon ushlaydigan qopqonni topa olasizmi?",
      'answer': ['m', 'u', 's', 'h', 'u', 'k']
    },
    {
      'question':
          "Kunlardan bir kun chol o'g'liga o'ttiz tiyin berib shunday debdi: — O'g'lim, shu pulga narsa olib kelginki, biz ham, tovug'imiz ham, qo'zimiz ham to'yadigan bo'lsin. Bola nima olib kelishi kerak?",
      'answer': ['q', 'o', 'v', 'u', 'n']
    }
  ];

  Map<String, dynamic> get question {
    return questions[currentQuestion.value];
  }

  List<String> get answers {
    const String alphabet = 'abcdefghijklmnopqrstuvwxyz';
    Random random = Random();
    List<String> randomLetters = [];

    for (int i = 0;
        i < 10 - questions[currentQuestion.value]['answer'].length;
        i++) {
      int randomIndex = random.nextInt(alphabet.length);
      randomLetters.add(alphabet[randomIndex]);
    }
    List<String> combinedList = [
      ...randomLetters,
      ...questions[currentQuestion.value]['answer']
    ];

    combinedList.shuffle();

    return combinedList;
  }

  void incrementInCorrect() {
    inCorrectAnswers++;
  }

  void incrementCorrect() {
    correctAnswers++;
  }

  void nextQuestion() {
    if (currentQuestion.value != questions.length - 1) {
      currentQuestion++;
    } else {
      currentQuestion.value = 0;
    }
  }

  void reset() {
    correctAnswers = 0.obs;
    inCorrectAnswers = 0.obs;
  }
}