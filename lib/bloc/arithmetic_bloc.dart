import 'dart:math';

import 'package:arithmetic_expressions_generator/bloc/arithmetic_event.dart';
import 'package:arithmetic_expressions_generator/bloc/arithmetic_state.dart';
import 'package:arithmetic_expressions_generator/models/arithmetic_operation.dart';
import 'package:arithmetic_expressions_generator/models/operand.dart';
import 'package:arithmetic_expressions_generator/utils/random_number_generator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArithmeticBloc extends Bloc<ArithmeticEvent, ArithmeticState> {
  final RandomNumberGenerator random;

  ArithmeticBloc({RandomNumberGenerator? randomGenerator})
      : random = randomGenerator ?? DefaultRandomNumberGenerator(),
        super(InitialArithmeticState()) {
    on<GenerateNewExerciseArithmeticEvent>(
        _onGenerateNewExerciseArithmeticEvent);
  }

  void _onGenerateNewExerciseArithmeticEvent(
      GenerateNewExerciseArithmeticEvent event, Emitter<ArithmeticState> emit) {
    var hiddenOperand = _selectHiddenOperand(event.hideResultOnly);
    if (event.operation == ArithmeticOperation.addition) {
      emit(_generateAdditionExercise(hiddenOperand));
    } else if (event.operation == ArithmeticOperation.subtraction) {
      emit(_generateSubtractionExercise(hiddenOperand));
    } else if (event.operation == ArithmeticOperation.multiplication) {
      emit(_generateMultiplicationExercise(hiddenOperand));
    } else if (event.operation == ArithmeticOperation.division) {
      emit(_generateDivisionExercise(hiddenOperand));
    }
  }

  int _selectHiddenOperand(bool hideResultOnly) {
    if (hideResultOnly) {
      return 2;
    } else {
      return random.nextInt(3);
    }
  }

  NewExerciseArithmeticState _generateAdditionExercise(int hiddenOperand) {
    var operand1 = Operand(random.nextInt(31), isVisible: hiddenOperand != 0);
    var operand2 = Operand(random.nextInt(31), isVisible: hiddenOperand != 1);
    var result = Operand(operand1 + operand2, isVisible: hiddenOperand != 2);
    return NewExerciseArithmeticState(
        operand1, operand2, ArithmeticOperation.addition, result);
  }

  NewExerciseArithmeticState _generateSubtractionExercise(int hiddenOperand) {
    var first = random.nextInt(31);
    var second = random.nextInt(31);
    var operand1 = Operand(max(first, second), isVisible: hiddenOperand != 0);
    var operand2 = Operand(min(first, second), isVisible: hiddenOperand != 1);
    var result = Operand(operand1 - operand2, isVisible: hiddenOperand != 2);
    return NewExerciseArithmeticState(
        operand1, operand2, ArithmeticOperation.subtraction, result);
  }

  NewExerciseArithmeticState _generateMultiplicationExercise(int hiddenOperand) {
    var operand1 = Operand(random.nextInt(11), isVisible: hiddenOperand != 0);
    var operand2 = Operand(random.nextInt(6), isVisible: hiddenOperand != 1);
    var result = Operand(operand1 * operand2, isVisible: hiddenOperand != 2);
    return NewExerciseArithmeticState(
        operand1, operand2, ArithmeticOperation.multiplication, result);
  }

  NewExerciseArithmeticState _generateDivisionExercise(int hiddenOperand) {
    var first = random.nextInt(6) + 1;
    var second = random.nextInt(6) + 1;
    var operand1 = Operand(max(first, second), isVisible: hiddenOperand != 0);
    var operand2 = Operand(min(first, second), isVisible: hiddenOperand != 1);
    var result = Operand(operand1 ~/ operand2, isVisible: hiddenOperand != 2);
    return NewExerciseArithmeticState(
        operand1, operand2, ArithmeticOperation.division, result);
  }
}
