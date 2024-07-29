part of 'puzzle_bloc.dart';

sealed class PuzzleEvent {}

final class GetPuzzleEvent extends PuzzleEvent {}

final class NextPuzzleEvent extends PuzzleEvent {}

final class GenerateAnswersEvent extends PuzzleEvent {
  final String word;

  GenerateAnswersEvent(this.word);
}
