part of 'puzzle_bloc.dart';

sealed class PuzzleState {}

final class InitialPuzzleState extends PuzzleState {}

final class LoadedPuzzleState extends PuzzleState {
  final Map<String, dynamic> puzzle;

  LoadedPuzzleState(this.puzzle);
}

class CompletedPuzzleState extends PuzzleState {}

class ErrorPuzzleState extends PuzzleState {
  final String message;

  ErrorPuzzleState(this.message);
}

class GeneratedAnswersState extends PuzzleState {
  final List<String> answers;

  GeneratedAnswersState(this.answers);
}
