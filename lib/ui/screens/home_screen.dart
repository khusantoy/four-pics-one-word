import 'package:flutter/material.dart';
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
  int currentUserAnswer = 0;
  List<String> userAnswer = [];
  List<String> answers = [];

  void _handleAnswerTap(int index, String word) {
    setState(() {
      userAnswer[currentUserAnswer] = answers[index];
      answers[index] = '';

      if (userAnswer.join('') == word && !userAnswer.contains('')) {
        Future.delayed(const Duration(milliseconds: 500), () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text("Correct 👍"),
              );
            },
          );
        });

        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });

        Future.delayed(const Duration(seconds: 1), () {
          context.read<PuzzleBloc>().add(NextPuzzleEvent());
          _resetPuzzle(word);
        });
      } else if (!userAnswer.contains('') && userAnswer.join('') != word) {
        Future.delayed(const Duration(milliseconds: 500), () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text("Incorrect 👎"),
              );
            },
          );
        });

        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });

        Future.delayed(const Duration(seconds: 1), () {
          context.read<PuzzleBloc>().add(NextPuzzleEvent());
          _resetPuzzle(word);
        });
      }

      if (currentUserAnswer < userAnswer.length - 1) {
        currentUserAnswer++;
      } else {
        currentUserAnswer = 0;
      }
    });
  }

  void _resetPuzzle(String word) {
    answers.clear();
    userAnswer.clear();
    currentUserAnswer = 0;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<PuzzleBloc, PuzzleState>(
          bloc: context.read<PuzzleBloc>()..add(GetPuzzleEvent()),
          builder: (context, state) {
            if (state is LoadedPuzzleState) {
              final puzzle = state.puzzle;
              final images = puzzle['images'];
              final word = puzzle['word'];

              if (userAnswer.isEmpty && answers.isEmpty) {
                userAnswer = List.generate(word.length, (index) => '');
                answers = wordController.getAnswer(word);
              }

              return Column(
                children: [
                  SizedBox(
                    height: 450,
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
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(word.length, (index) {
                      return Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.blue),
                        ),
                        child: Center(
                          child: Text(
                            userAnswer[index].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 40),
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
                          onTap: () => _handleAnswerTap(index, word),
                          child: answers[index] == ''
                              ? const SizedBox()
                              : Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 4),
                                  ),
                                  child: Center(
                                    child: Text(
                                      answers[index].toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            if (state is CompletedPuzzleState) {
              return const Center(
                child: Text(
                  "Game Over",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
