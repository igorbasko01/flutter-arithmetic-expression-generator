import 'dart:async';
import 'dart:math';

import 'package:arithmetic_expressions_generator/bloc/arithmetic_event.dart';
import 'package:arithmetic_expressions_generator/bloc/arithmetic_state.dart';
import 'package:arithmetic_expressions_generator/models/arithmetic_operation.dart';
import 'package:arithmetic_expressions_generator/models/exercise.dart';
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
    on<CheckAnswerArithmeticEvent>(_onCheckAnswerArithmeticEvent);
  }

  void _onGenerateNewExerciseArithmeticEvent(
      GenerateNewExerciseArithmeticEvent event, Emitter<ArithmeticState> emit) {
    if (event.operation == ArithmeticOperation.addition) {
      emit(NewExerciseArithmeticState(_generateExercises(
          event.numberOfExercises,
          event.hideResultOnly,
          _generateAdditionExercise(event.maxOperandValue))));
    } else if (event.operation == ArithmeticOperation.subtraction) {
      emit(NewExerciseArithmeticState(_generateExercises(
          event.numberOfExercises,
          event.hideResultOnly,
          _generateSubtractionExercise(event.maxOperandValue))));
    } else if (event.operation == ArithmeticOperation.multiplication) {
      emit(NewExerciseArithmeticState(_generateExercises(
          event.numberOfExercises,
          event.hideResultOnly,
          _generateMultiplicationExercise())));
    } else if (event.operation == ArithmeticOperation.division) {
      emit(NewExerciseArithmeticState(_generateExercises(
          event.numberOfExercises,
          event.hideResultOnly,
          _generateDivisionExercise())));
    }
  }

  int _selectHiddenOperand(bool hideResultOnly) {
    if (hideResultOnly) {
      return 2;
    } else {
      return random.nextInt(3);
    }
  }

  List<Exercise> _generateExercises(int numberOfExercises, bool hideResultOnly,
      Exercise Function(int) operation) {
    var exercises = <Exercise>[];
    for (var i = 0; i < numberOfExercises; i++) {
      exercises.add(operation(_selectHiddenOperand(hideResultOnly)));
    }
    return exercises;
  }

  /// This is a higher order function that returns a function
  /// that generates an addition exercise.
  /// To allow generation of multiple functions that generate exercises
  /// with different hidden operands.
  Exercise Function(int) _generateAdditionExercise(int maxOperandValue) {
    return (int hiddenOperand) {
      var operand1 = Operand(random.nextInt(maxOperandValue + 1),
          isVisible: hiddenOperand != 0);
      var operand2 = Operand(random.nextInt(maxOperandValue + 1),
          isVisible: hiddenOperand != 1);
      var result = Operand(operand1 + operand2, isVisible: hiddenOperand != 2);
      return Exercise(operand1, operand2, ArithmeticOperation.addition, result);
    };
  }

  /// This is a higher order function that returns a function
  /// that generates a subtraction exercise.
  /// To allow generation of multiple functions that generate exercises
  /// with different hidden operands.
  Exercise Function(int) _generateSubtractionExercise(int maxOperandValue) {
    return (int hiddenOperand) {
      var first = random.nextInt(maxOperandValue + 1);
      var second = random.nextInt(maxOperandValue + 1);
      var operand1 = Operand(max(first, second), isVisible: hiddenOperand != 0);
      var operand2 = Operand(min(first, second), isVisible: hiddenOperand != 1);
      var result = Operand(operand1 - operand2, isVisible: hiddenOperand != 2);
      return Exercise(
          operand1, operand2, ArithmeticOperation.subtraction, result);
    };
  }

  /// This is a higher order function that returns a function
  /// that generates a multiplication exercise.
  /// To allow generation of multiple functions that generate exercises
  /// with different hidden operands.
  Exercise Function(int) _generateMultiplicationExercise() {
    return (int hiddenOperand) {
      var operand1 = Operand(random.nextInt(11), isVisible: hiddenOperand != 0);
      var operand2 = Operand(random.nextInt(6), isVisible: hiddenOperand != 1);
      var result = Operand(operand1 * operand2, isVisible: hiddenOperand != 2);
      return Exercise(
          operand1, operand2, ArithmeticOperation.multiplication, result);
    };
  }

  /// This is a higher order function that returns a function
  /// that generates a division exercise.
  /// To allow generation of multiple functions that generate exercises
  /// with different hidden operands.
  Exercise Function(int) _generateDivisionExercise() {
    return (int hiddenOperand) {
      var first = random.nextInt(6) + 1;
      var second = random.nextInt(6) + 1;
      var operand1 = Operand(max(first, second), isVisible: hiddenOperand != 0);
      var operand2 = Operand(min(first, second), isVisible: hiddenOperand != 1);
      var result = Operand(operand1 ~/ operand2, isVisible: hiddenOperand != 2);
      return Exercise(operand1, operand2, ArithmeticOperation.division, result);
    };
  }

  void _onCheckAnswerArithmeticEvent(
      CheckAnswerArithmeticEvent event, Emitter<ArithmeticState> emit) {
    var exerciseWithVisibleResult = Exercise(
        event.exercise.operand1,
        event.exercise.operand2,
        event.exercise.operator,
        Operand(event.exercise.result.value, isVisible: true));
    if (event.exercise.result.value == event.answer) {
      emit(AnswerCheckArithmeticState(true, exerciseWithVisibleResult));
    } else {
      emit(AnswerCheckArithmeticState(false, exerciseWithVisibleResult));
    }
  }
}
