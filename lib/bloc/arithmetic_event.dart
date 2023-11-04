import 'package:arithmetic_expressions_generator/models/arithmetic_operation.dart';

sealed class ArithmeticEvent {}

class GenerateNewExerciseArithmeticEvent extends ArithmeticEvent {
  final ArithmeticOperation operation;
  final bool hideResultOnly;

  GenerateNewExerciseArithmeticEvent(this.operation, {this.hideResultOnly = false});
}