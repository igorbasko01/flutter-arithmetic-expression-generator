import 'package:arithmetic_expressions_generator/bloc/arithmetic_bloc.dart';
import 'package:arithmetic_expressions_generator/bloc/arithmetic_event.dart';
import 'package:arithmetic_expressions_generator/bloc/arithmetic_state.dart';
import 'package:arithmetic_expressions_generator/models/arithmetic_operation.dart';
import 'package:arithmetic_expressions_generator/models/exercise.dart';
import 'package:arithmetic_expressions_generator/models/operand.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'random_test_helper.dart';

int _numberOfHiddenOperands(Exercise exercise) {
  var visibleOperands = [
    exercise.operand1.isVisible,
    exercise.operand2.isVisible,
    exercise.result.isVisible
  ];
  return visibleOperands.where((element) => !element).length;
}

void main() {
  blocTest<ArithmeticBloc, ArithmeticState>(
      'Returns a new exercise state for addition event',
      build: () {
        final mockRandom = MockRandom();
        mockRandomNumberGenerator(mockRandom, [2, 1, 2]);
        return ArithmeticBloc(randomGenerator: mockRandom);
      },
      act: (bloc) {
        bloc.add(
            GenerateNewExerciseArithmeticEvent(ArithmeticOperation.addition));
      },
      expect: () => [
            predicate<NewExerciseArithmeticState>((state) {
              var exercise = state.exercises.first;
              return exercise.operand1 >= 0 &&
                  exercise.operand2 >= 0 &&
                  exercise.operator == ArithmeticOperation.addition &&
                  exercise.result.value == exercise.operand1 + exercise.operand2 &&
                  _numberOfHiddenOperands(exercise) == 1 &&
                  !exercise.result.isVisible;
            }),
          ]);

  blocTest('Returns new exercise for subtraction event',
      build: () => ArithmeticBloc(),
      act: (bloc) => bloc.add(
          GenerateNewExerciseArithmeticEvent(ArithmeticOperation.subtraction)),
      expect: () => [
            predicate<NewExerciseArithmeticState>((state) {
              var exercise = state.exercises.first;
              return exercise.operand1 >= 0 &&
                  exercise.operand2 >= 0 &&
                  exercise.operand2 <= exercise.operand1 &&
                  exercise.operator == ArithmeticOperation.subtraction &&
                  exercise.result.value == exercise.operand1 - exercise.operand2 &&
                  _numberOfHiddenOperands(exercise) == 1;
            })
          ]);

  blocTest('Subtraction puts the larger operand first',
      build: () {
        final mockRandom = MockRandom();
        mockRandomNumberGenerator(mockRandom, [2, 1, 2]);
        return ArithmeticBloc(randomGenerator: mockRandom);
      },
      act: (bloc) => bloc.add(
          GenerateNewExerciseArithmeticEvent(ArithmeticOperation.subtraction)),
      expect: () => [
            predicate<NewExerciseArithmeticState>((state) {
              var exercise = state.exercises.first;
              return exercise.operand1 >= 0 &&
                  exercise.operand2 >= 0 &&
                  exercise.operand1 >= exercise.operand2 &&
                  exercise.operator == ArithmeticOperation.subtraction &&
                  exercise.result.value == exercise.operand1 - exercise.operand2 &&
                  _numberOfHiddenOperands(exercise) == 1 &&
                  exercise.operand1.value == 2 &&
                  exercise.operand2.value == 1;
            })
          ]);

  blocTest('Returns new exercise for multiplication event',
      build: () => ArithmeticBloc(),
      act: (bloc) => bloc.add(GenerateNewExerciseArithmeticEvent(
          ArithmeticOperation.multiplication)),
      expect: () => [
            predicate<NewExerciseArithmeticState>((state) {
              var exercise = state.exercises.first;
              return exercise.operand1 >= 0 &&
                  exercise.operand2 >= 0 &&
                  exercise.operator == ArithmeticOperation.multiplication &&
                  exercise.result.value == exercise.operand1 * exercise.operand2 &&
                  _numberOfHiddenOperands(exercise) == 1;
            })
          ]);

  blocTest('Returns new exercise for division event',
      build: () => ArithmeticBloc(),
      act: (bloc) => bloc.add(
          GenerateNewExerciseArithmeticEvent(ArithmeticOperation.division)),
      expect: () => [
            predicate<NewExerciseArithmeticState>((state) {
              var exercise = state.exercises.first;
              return exercise.operand1 >= 0 &&
                  exercise.operand2 > 0 &&
                  exercise.operand2 <= exercise.operand1 &&
                  exercise.operator == ArithmeticOperation.division &&
                  exercise.result.value == exercise.operand1 ~/ exercise.operand2 &&
                  _numberOfHiddenOperands(exercise) == 1;
            })
          ]);

  blocTest('Division puts the larger operand first',
      build: () {
        final mockRandom = MockRandom();
        mockRandomNumberGenerator(mockRandom, [2, 1, 1]);
        return ArithmeticBloc(randomGenerator: mockRandom);
      },
      act: (bloc) => bloc.add(
          GenerateNewExerciseArithmeticEvent(ArithmeticOperation.division)),
      expect: () => [
            predicate<NewExerciseArithmeticState>((state) {
              var exercise = state.exercises.first;
              return exercise.operand1 >= 0 &&
                  exercise.operand2 > 0 &&
                  exercise.operand1 >= exercise.operand2 &&
                  exercise.operator == ArithmeticOperation.division &&
                  exercise.result.value == exercise.operand1 ~/ exercise.operand2 &&
                  _numberOfHiddenOperands(exercise) == 1 &&
                  exercise.operand1.value == 2 &&
                  exercise.operand2.value == 2;
            })
          ]);

  blocTest('Returns new exercise where the result is hidden',
      build: () {
        final mockRandom = MockRandom();
        mockRandomNumberGenerator(mockRandom, [0, 1, 2]);
        return ArithmeticBloc(randomGenerator: mockRandom);
      },
      act: (bloc) => bloc.add(GenerateNewExerciseArithmeticEvent(
          ArithmeticOperation.addition,
          hideResultOnly: true)),
      expect: () => [
            predicate<NewExerciseArithmeticState>((state) {
              return _numberOfHiddenOperands(state.exercises.first) == 1 &&
                  state.exercises.first.result.isVisible == false;
            })
          ]);

  blocTest(
      'Returns new addition exercise limited by the max operand value parameter',
      build: () => ArithmeticBloc(),
      act: (bloc) => bloc.add(GenerateNewExerciseArithmeticEvent(
          ArithmeticOperation.addition,
          maxOperandValue: 1)),
      expect: () => [
            predicate<NewExerciseArithmeticState>((state) {
              var exercise = state.exercises.first;
              return exercise.operand1.value <= 1 &&
                  exercise.operand2.value <= 1 &&
                  exercise.result.value <= 2;
            })
          ]);

  blocTest(
      'Returns new subtraction exercise limited by the max operand value parameter',
      build: () => ArithmeticBloc(),
      act: (bloc) => bloc.add(GenerateNewExerciseArithmeticEvent(
          ArithmeticOperation.subtraction,
          maxOperandValue: 1)),
      expect: () => [
            predicate<NewExerciseArithmeticState>((state) {
              var exercise = state.exercises.first;
              return exercise.operand1.value <= 1 &&
                  exercise.operand2.value <= 1 &&
                  exercise.result.value <= 1;
            })
          ]);

  blocTest(
      'Returns multiple exercise when passed number of exercises parameter',
      build: () => ArithmeticBloc(),
      act: (bloc) => bloc.add(GenerateNewExerciseArithmeticEvent(
          ArithmeticOperation.addition,
          numberOfExercises: 2)),
      expect: () => [
            predicate<NewExerciseArithmeticState>((state) {
              return state.exercises.length == 2;
            })
          ]);

  blocTest('Answer check event returns a result state with correct answer',
      build: () => ArithmeticBloc(),
      act: (bloc) => bloc.add(CheckAnswerArithmeticEvent(
          Exercise(Operand(1, isVisible: true), Operand(2, isVisible: true),
              ArithmeticOperation.addition, Operand(3, isVisible: false)),
          3)),
      expect: () => [
            predicate<AnswerCheckArithmeticState>((state) {
              var expectedExercise = Exercise(
                  Operand(1, isVisible: true),
                  Operand(2, isVisible: true),
                  ArithmeticOperation.addition,
                  Operand(3, isVisible: true));
              return state.isCorrect && state.exercise == expectedExercise;
            })
          ]);

  blocTest('Answer check event returns a result state with incorrect answer',
      build: () => ArithmeticBloc(),
      act: (bloc) => bloc.add(CheckAnswerArithmeticEvent(
          Exercise(Operand(1, isVisible: true), Operand(2, isVisible: true),
              ArithmeticOperation.addition, Operand(3, isVisible: false)),
          4)),
      expect: () => [
            predicate<AnswerCheckArithmeticState>((state) {
              var expectedExercise = Exercise(
                  Operand(1, isVisible: true),
                  Operand(2, isVisible: true),
                  ArithmeticOperation.addition,
                  Operand(3, isVisible: true));
              return !state.isCorrect && state.exercise == expectedExercise;
            })
          ]);

  blocTest('Answer check event returns a result state where all operands are visible',
      build: () => ArithmeticBloc(),
      act: (bloc) => bloc.add(CheckAnswerArithmeticEvent(
          Exercise(Operand(1, isVisible: true), Operand(2, isVisible: true),
              ArithmeticOperation.addition, Operand(3, isVisible: false)),
          3)),
      expect: () => [
            predicate<AnswerCheckArithmeticState>((state) {
              var expectedExercise = Exercise(
                  Operand(1, isVisible: true),
                  Operand(2, isVisible: true),
                  ArithmeticOperation.addition,
                  Operand(3, isVisible: true));
              return state.isCorrect && state.exercise == expectedExercise;
            })
          ]
  );

  blocTest('Answer check event returns a result state where all operands are visible when the first operand is hidden',
      build: () => ArithmeticBloc(),
      act: (bloc) => bloc.add(CheckAnswerArithmeticEvent(
          Exercise(Operand(1, isVisible: false), Operand(2, isVisible: true),
              ArithmeticOperation.addition, Operand(3, isVisible: true)),
          1)),
      expect: () => [
            predicate<AnswerCheckArithmeticState>((state) {
              var expectedExercise = Exercise(
                  Operand(1, isVisible: true),
                  Operand(2, isVisible: true),
                  ArithmeticOperation.addition,
                  Operand(3, isVisible: true));
              return state.isCorrect && state.exercise == expectedExercise;
            })
          ]
  );

  blocTest('Multiplication exercise with zero operand should accept any answer',
    build: () => ArithmeticBloc(),
    act: (bloc) => bloc.add(CheckAnswerArithmeticEvent(
        Exercise(Operand(0, isVisible: true), Operand(2, isVisible: false),
            ArithmeticOperation.multiplication, Operand(0, isVisible: true)),
        1)),
    expect: () => [
          predicate<AnswerCheckArithmeticState>((state) {
            var expectedExercise = Exercise(
                Operand(0, isVisible: true),
                Operand(2, isVisible: true),
                ArithmeticOperation.multiplication,
                Operand(0, isVisible: true));
            return state.isCorrect && state.exercise == expectedExercise;
          })
        ]
  );
}
