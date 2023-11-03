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
    var hidden = random.nextInt(3);
    var operand1 = Operand(random.nextInt(31), isVisible: hidden != 0);
    var operand2 = Operand(random.nextInt(31), isVisible: hidden != 1);
    var result = Operand(operand1 + operand2, isVisible: hidden != 2);
    return NewExerciseArithmeticState(operand1, operand2,
        ArithmeticOperation.addition, result);
  }

  NewExerciseArithmeticState _generateSubtractionExercise() {
    var random = Random();
    var hidden = random.nextInt(3);
    var first = random.nextInt(31);
    var second = random.nextInt(31);
    var operand1 = Operand(max(first, second), isVisible: hidden != 0);
    var operand2 = Operand(min(first, second), isVisible: hidden != 1);
    var result = Operand(operand1 - operand2, isVisible: hidden != 2);
    return NewExerciseArithmeticState(operand1, operand2,
        ArithmeticOperation.subtraction, result);
  }

  NewExerciseArithmeticState _generateMultiplicationExercise() {
    var random = Random();
    var hidden = random.nextInt(3);
    var operand1 = Operand(random.nextInt(11), isVisible: hidden != 0);
    var operand2 = Operand(random.nextInt(6), isVisible: hidden != 1);
    var result = Operand(operand1 * operand2, isVisible: hidden != 2);
    return NewExerciseArithmeticState(operand1, operand2,
        ArithmeticOperation.multiplication, result);
  }

  NewExerciseArithmeticState _generateDivisionExercise() {
    var random = Random();
    var hidden = random.nextInt(3);
    var first = random.nextInt(6) + 1;
    var second = random.nextInt(6) + 1;
    var operand1 = Operand(max(first, second), isVisible: hidden != 0);
    var operand2 = Operand(min(first, second), isVisible: hidden != 1);
    var result = Operand(operand1 ~/ operand2, isVisible: hidden != 2);
    return NewExerciseArithmeticState(operand1, operand2,
        ArithmeticOperation.division, result);
  }
}
