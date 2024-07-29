import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:four_pics_one_word/blocs/puzzle/puzzle_bloc.dart';
import 'package:four_pics_one_word/controllers/word_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final wordController = Get.put(WordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<PuzzleBloc, PuzzleState>(
          bloc: context.read<PuzzleBloc>()..add(GetPuzzleEvent()),
          builder: (context, state) {
            print(state);
            if (state is LoadedPuzzleState) {
              final puzzle = state.puzzle;
              final images = puzzle['images'];
              final word = puzzle['word'];

              int currentUserAnswer = 0;

              List<String> userAnswer = [];
              List<String> answers = [];

              userAnswer = List.generate(
                word.length,
                (index) {
                  return '';
                },
              );
              return Column(
                children: [
                  SizedBox(
                    height: 450,
                    child: Expanded(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          final image = images[index];
                          return Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              border: Border.all(width: 4, color: Colors.amber),
                            ),
                            child: Image.asset(
                              image,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      word.length,
                      (index) {
                        return Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(width: 4),
                          ),
                          child: Center(
                            child: Text(userAnswer[index].toUpperCase()),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: answers.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              userAnswer[currentUserAnswer] = answers[index];
                              answers[index] = '';

                              if (userAnswer.join('') == word &&
                                  !userAnswer.contains('')) {
                                wordController.incrementCorrect();
                                Get.defaultDialog(
                                  barrierDismissible: false,
                                  title: "Correct 👍",
                                );
                                wordController.nextQuestion();
                                if (wordController.currentQuestion.value == 0) {
                                  Future.delayed(const Duration(seconds: 4),
                                      () {
                                    Get.defaultDialog(
                                      barrierDismissible: false,
                                      title: "Your statistics",
                                      content: Column(
                                        children: [
                                          Text(
                                              "Correct answer: ${wordController.correctAnswers}"),
                                          Text(
                                              "Incorrect answer: ${wordController.inCorrectAnswers}")
                                        ],
                                      ),
                                      cancel: TextButton(
                                          onPressed: () {
                                            SystemNavigator.pop();
                                          },
                                          child: const Text("Exit")),
                                      confirm: FilledButton(
                                        onPressed: () {
                                          setState(() {
                                            wordController.reset();
                                            Get.back();
                                          });
                                        },
                                        child: const Text("Again"),
                                      ),
                                    );
                                  });
                                }
                                answers = wordController.answers;
                                userAnswer = List.generate(
                                  wordController.question['answer'].length,
                                  (index) {
                                    return '';
                                  },
                                );
                                Future.delayed(const Duration(seconds: 3), () {
                                  Get.back();
                                });
                                currentUserAnswer = -1;
                              } else if (!userAnswer.contains('') &&
                                  userAnswer.join('') !=
                                      wordController.question['answer']
                                          .join('')) {
                                Get.defaultDialog(
                                  barrierDismissible: false,
                                  title: "Incorrect 👎",
                                  content: Image.asset("assets/gifs/no.gif"),
                                );
                                wordController.nextQuestion();
                                if (wordController.currentQuestion.value == 0) {
                                  Future.delayed(const Duration(seconds: 4),
                                      () {
                                    Get.defaultDialog(
                                      barrierDismissible: false,
                                      title: "Your statistics",
                                      content: Column(
                                        children: [
                                          Text(
                                              "Correct answer: ${wordController.correctAnswers}"),
                                          Text(
                                              "Incorrect answer: ${wordController.inCorrectAnswers}")
                                        ],
                                      ),
                                      cancel: TextButton(
                                          onPressed: () {
                                            SystemNavigator.pop();
                                          },
                                          child: const Text("Exit")),
                                      confirm: FilledButton(
                                        onPressed: () {
                                          setState(() {
                                            wordController.reset();
                                            Get.back();
                                          });
                                        },
                                        child: const Text("Again"),
                                      ),
                                    );
                                  });
                                }
                                wordController.incrementInCorrect();
                                answers = wordController.answers;
                                userAnswer = List.generate(
                                  wordController.question['answer'].length,
                                  (index) {
                                    return '';
                                  },
                                );
                                Future.delayed(const Duration(seconds: 3), () {
                                  Get.back();
                                });
                                currentUserAnswer = -1;
                              }

                              if (currentUserAnswer < userAnswer.length - 1) {
                                currentUserAnswer++;
                              } else {
                                currentUserAnswer = 0;
                              }
                            });
                          },
                          child: answers[index] == ''
                              ? const SizedBox()
                              : SizedBox(
                                  width: 55,
                                  height: 55,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.lightGreen,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        answers[index].toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        );
                      },
                    ),
                  )
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
