import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:four_pics_one_word/data/repository/puzzle_repo.dart';

part 'puzzle_state.dart';
part 'puzzle_event.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  final PuzzleRepo _puzzleRepo;
  int _currentPuzzleIndex = 0;

  PuzzleBloc({required PuzzleRepo puzzleRepo})
      : _puzzleRepo = puzzleRepo,
        super(InitialPuzzleState()) {
    on<GetPuzzleEvent>(_getPuzzle);
    on<NextPuzzleEvent>(_nextPuzzle);
    on<GenerateAnswersEvent>(_handleGenerateAnswersEvent);
  }

  void _getPuzzle(GetPuzzleEvent event, Emitter<PuzzleState> emit) {
    print("Getting puzzle"); // Logging
    try {
      final puzzle = _puzzleRepo.puzzles[_currentPuzzleIndex];
      print("Puzzle loaded: $puzzle"); // Logging
      emit(LoadedPuzzleState(puzzle));
    } catch (e) {
      print("Error loading puzzle: $e"); // Logging
      emit(ErrorPuzzleState(e.toString()));
    }
  }

  void _nextPuzzle(NextPuzzleEvent event, Emitter<PuzzleState> emit) {
    try {
      final puzzles = _puzzleRepo.puzzles;
      if (_currentPuzzleIndex < puzzles.length - 1) {
        _currentPuzzleIndex++;
        emit(LoadedPuzzleState(puzzles[_currentPuzzleIndex]));
      } else {
        emit(CompletedPuzzleState());
      }
    } catch (e) {
      emit(ErrorPuzzleState(e.toString()));
    }
  }

  void _handleGenerateAnswersEvent(
      GenerateAnswersEvent event, Emitter<PuzzleState> emit) {
    print("Generating answers for word: ${event.word}"); // Logging
    final answers = _generateAnswers(event.word);
    print("Generated answers: $answers"); // Logging
    emit(GeneratedAnswersState(answers));
  }

  List<String> _generateAnswers(String word) {
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
}
