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
          _generateMultiplicationExercise(event.maxOperandValue))));
    } else if (event.operation == ArithmeticOperation.division) {
      emit(NewExerciseArithmeticState(_generateExercises(
          event.numberOfExercises,
          event.hideResultOnly,
          _generateDivisionExercise(event.maxOperandValue))));
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
  Exercise Function(int) _generateMultiplicationExercise(int maxOperandValue) {
    return (int hiddenOperand) {
      var operand1 = Operand(random.nextInt(maxOperandValue + 1), isVisible: hiddenOperand != 0);
      var operand2 = Operand(random.nextInt(maxOperandValue + 1), isVisible: hiddenOperand != 1);
      var result = Operand(operand1 * operand2, isVisible: hiddenOperand != 2);
      return Exercise(
          operand1, operand2, ArithmeticOperation.multiplication, result);
    };
  }

  /// This is a higher order function that returns a function
  /// that generates a division exercise.
  /// To allow generation of multiple functions that generate exercises
  /// with different hidden operands.
  Exercise Function(int) _generateDivisionExercise(int maxOperandValue) {
    return (int hiddenOperand) {
      var higher = random.nextInt(maxOperandValue) + 1;
      var possibleLowerValues = _possibleLowerValues(higher);
      var lower =
          possibleLowerValues[random.nextInt(possibleLowerValues.length)];
      var operand1 = Operand(higher, isVisible: hiddenOperand != 0);
      var operand2 = Operand(lower, isVisible: hiddenOperand != 1);
      var result = Operand(operand1 ~/ operand2, isVisible: hiddenOperand != 2);
      return Exercise(operand1, operand2, ArithmeticOperation.division, result);
    };
  }

  List<int> _possibleLowerValues(int higher) {
    var possibleLowerValues = <int>[];
    for (var i = 1; i <= higher; i++) {
      if (higher % i == 0) {
        possibleLowerValues.add(i);
      }
    }
    return possibleLowerValues;
  }

  void _onCheckAnswerArithmeticEvent(
      CheckAnswerArithmeticEvent event, Emitter<ArithmeticState> emit) {
    var exercise = event.exercise;
    var exerciseWithUserAnswer = Exercise(
        Operand(
            exercise.operand1.isVisible
                ? exercise.operand1.value
                : event.answer,
            isVisible: true),
        Operand(
            exercise.operand2.isVisible
                ? exercise.operand2.value
                : event.answer,
            isVisible: true),
        exercise.operator,
        Operand(
            exercise.result.isVisible ? exercise.result.value : event.answer,
            isVisible: true));
    emit(AnswerCheckArithmeticState(exerciseWithUserAnswer.isCorrect(),
        exercise.copyWithAllVisible()));
  }
}
