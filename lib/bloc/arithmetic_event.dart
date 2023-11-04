import 'package:arithmetic_expressions_generator/models/arithmetic_operation.dart';

sealed class ArithmeticEvent {}

class GenerateNewExerciseArithmeticEvent extends ArithmeticEvent {
  final ArithmeticOperation operation;
  final bool hideResultOnly;
  final int maxOperandValue;
  final int numberOfExercises;

  GenerateNewExerciseArithmeticEvent(this.operation,
      {this.hideResultOnly = false, this.maxOperandValue = 30, this.numberOfExercises = 1});
}
