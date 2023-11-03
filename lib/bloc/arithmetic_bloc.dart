import 'dart:math';

import 'package:arithmetic_expressions_generator/bloc/arithmetic_event.dart';
import 'package:arithmetic_expressions_generator/bloc/arithmetic_state.dart';
import 'package:arithmetic_expressions_generator/models/arithmetic_operation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArithmeticBloc extends Bloc<ArithmeticEvent, ArithmeticState> {
  ArithmeticBloc() : super(InitialArithmeticState()) {
    on<GenerateNewExerciseArithmeticEvent>(
        _onGenerateNewExerciseArithmeticEvent);
  }

  void _onGenerateNewExerciseArithmeticEvent(
      GenerateNewExerciseArithmeticEvent event, Emitter<ArithmeticState> emit) {
    if (event.operation == ArithmeticOperation.addition) {
      emit(_generateAdditionExercise());
    } else if (event.operation == ArithmeticOperation.subtraction) {
      emit(_generateSubtractionExercise());
    } else if (event.operation == ArithmeticOperation.multiplication) {
      emit(_generateMultiplicationExercise());
    } else if (event.operation == ArithmeticOperation.division) {
      emit(_generateDivisionExercise());
    }
  }

  NewExerciseArithmeticState _generateAdditionExercise() {
    var random = Random();
    var operand1 = random.nextInt(31);
    var operand2 = random.nextInt(31);
    return NewExerciseArithmeticState(
        operand1, operand2, ArithmeticOperation.addition, operand1 + operand2);
  }

  NewExerciseArithmeticState _generateSubtractionExercise() {
    var random = Random();
    var first = random.nextInt(31);
    var second = random.nextInt(31);
    var operand1 = max(first, second);
    var operand2 = min(first, second);
    return NewExerciseArithmeticState(operand1, operand2,
        ArithmeticOperation.subtraction, operand1 - operand2);
  }

  NewExerciseArithmeticState _generateMultiplicationExercise() {
    var random = Random();
    var operand1 = random.nextInt(11);
    var operand2 = random.nextInt(6);
    return NewExerciseArithmeticState(operand1, operand2,
        ArithmeticOperation.multiplication, operand1 * operand2);
  }

  NewExerciseArithmeticState _generateDivisionExercise() {
    var random = Random();
    var first = random.nextInt(6) + 1;
    var second = random.nextInt(6) + 1;
    var operand1 = max(first, second);
    var operand2 = min(first, second);
    return NewExerciseArithmeticState(
        operand1, operand2, ArithmeticOperation.division, operand1 ~/ operand2);
  }
}
