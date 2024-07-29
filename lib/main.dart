import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:four_pics_one_word/blocs/puzzle/puzzle_bloc.dart';
import 'package:four_pics_one_word/data/repository/puzzle_repo.dart';
import 'package:four_pics_one_word/ui/screens/home_screen.dart';

void main() {
  final PuzzleRepo puzzleRepo = PuzzleRepo();

  runApp(
    RepositoryProvider(
      create: (context) => puzzleRepo,
      child: BlocProvider(
        create: (context) => PuzzleBloc(puzzleRepo: puzzleRepo),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
