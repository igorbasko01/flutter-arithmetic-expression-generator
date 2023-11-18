import 'package:arithmetic_expressions_generator/models/exercise.dart';

sealed class ArithmeticState {}

class InitialArithmeticState extends ArithmeticState {}

class NewExerciseArithmeticState extends ArithmeticState {
  final List<Exercise> exercises;

  NewExerciseArithmeticState(this.exercises);
}

class AnswerCheckArithmeticState extends ArithmeticState {
  final bool isCorrect;
  final Exercise exercise;

  AnswerCheckArithmeticState(this.isCorrect, this.exercise);
}