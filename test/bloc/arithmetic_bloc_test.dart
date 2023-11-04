import 'package:arithmetic_expressions_generator/bloc/arithmetic_bloc.dart';
import 'package:arithmetic_expressions_generator/bloc/arithmetic_event.dart';
import 'package:arithmetic_expressions_generator/bloc/arithmetic_state.dart';
import 'package:arithmetic_expressions_generator/models/arithmetic_operation.dart';
import 'package:arithmetic_expressions_generator/utils/random_number_generator.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRandom extends Mock implements RandomNumberGenerator {}

void main() {
  int _numberOfHiddenOperands(NewExerciseArithmeticState state) {
    var visibleOperands = [
      state.operand1.isVisible,
      state.operand2.isVisible,
      state.result.isVisible
    ];
    return visibleOperands.where((element) => !element).length;
  }

  void _mockRandomNumberGenerator(MockRandom mockRandom, List<int> answers) {
    var callCount = 0;
    when(() => mockRandom.nextInt(any()))
        .thenAnswer((_) => answers[callCount++]);
  }

  blocTest<ArithmeticBloc, ArithmeticState>(
      'Returns a new exercise state for addition event',
      build: () {
        final mockRandom = MockRandom();
        _mockRandomNumberGenerator(mockRandom, [2, 1, 2]);
        return ArithmeticBloc(randomGenerator: mockRandom);
      },
      act: (bloc) {
        bloc.add(
            GenerateNewExerciseArithmeticEvent(ArithmeticOperation.addition));
      },
      expect: () => [
            predicate<NewExerciseArithmeticState>((state) {
              return state.operand1 >= 0 &&
                  state.operand2 >= 0 &&
                  state.operator == ArithmeticOperation.addition &&
                  state.result == state.operand1 + state.operand2 &&
                  _numberOfHiddenOperands(state) == 1 &&
                  !state.result.isVisible;
            }),
          ]);

  blocTest('Returns new exercise for subtraction event',
      build: () => ArithmeticBloc(),
      act: (bloc) => bloc.add(
          GenerateNewExerciseArithmeticEvent(ArithmeticOperation.subtraction)),
      expect: () => [
            predicate<NewExerciseArithmeticState>((state) {
              return state.operand1 >= 0 &&
                  state.operand2 >= 0 &&
                  state.operand2 <= state.operand1 &&
                  state.operator == ArithmeticOperation.subtraction &&
                  state.result == state.operand1 - state.operand2 &&
                  _numberOfHiddenOperands(state) == 1;
            })
          ]);

  blocTest('Subtraction puts the larger operand first',
      build: () {
        final mockRandom = MockRandom();
        _mockRandomNumberGenerator(mockRandom, [2, 1, 2]);
        return ArithmeticBloc(randomGenerator: mockRandom);
      },
      act: (bloc) => bloc.add(
          GenerateNewExerciseArithmeticEvent(ArithmeticOperation.subtraction)),
      expect: () => [
            predicate<NewExerciseArithmeticState>((state) {
              return state.operand1 >= 0 &&
                  state.operand2 >= 0 &&
                  state.operand1 >= state.operand2 &&
                  state.operator == ArithmeticOperation.subtraction &&
                  state.result == state.operand1 - state.operand2 &&
                  _numberOfHiddenOperands(state) == 1 &&
                  state.operand1.value == 2 &&
                  state.operand2.value == 1;
            })
          ]);

  blocTest('Returns new exercise for multiplication event',
      build: () => ArithmeticBloc(),
      act: (bloc) => bloc.add(GenerateNewExerciseArithmeticEvent(
          ArithmeticOperation.multiplication)),
      expect: () => [
            predicate<NewExerciseArithmeticState>((state) {
              return state.operand1 >= 0 &&
                  state.operand2 >= 0 &&
                  state.operator == ArithmeticOperation.multiplication &&
                  state.result == state.operand1 * state.operand2 &&
                  _numberOfHiddenOperands(state) == 1;
            })
          ]);

  blocTest('Returns new exercise for division event',
      build: () => ArithmeticBloc(),
      act: (bloc) => bloc.add(
          GenerateNewExerciseArithmeticEvent(ArithmeticOperation.division)),
      expect: () => [
            predicate<NewExerciseArithmeticState>((state) {
              return state.operand1 >= 0 &&
                  state.operand2 > 0 &&
                  state.operand2 <= state.operand1 &&
                  state.operator == ArithmeticOperation.division &&
                  state.result == state.operand1 ~/ state.operand2 &&
                  _numberOfHiddenOperands(state) == 1;
            })
          ]);

  blocTest('Division puts the larger operand first',
      build: () {
        final mockRandom = MockRandom();
        _mockRandomNumberGenerator(mockRandom, [2, 1, 2]);
        return ArithmeticBloc(randomGenerator: mockRandom);
      },
      act: (bloc) => bloc.add(
          GenerateNewExerciseArithmeticEvent(ArithmeticOperation.division)),
      expect: () => [
            predicate<NewExerciseArithmeticState>((state) {
              return state.operand1 >= 0 &&
                  state.operand2 > 0 &&
                  state.operand1 >= state.operand2 &&
                  state.operator == ArithmeticOperation.division &&
                  state.result == state.operand1 ~/ state.operand2 &&
                  _numberOfHiddenOperands(state) == 1 &&
                  state.operand1.value == 3 &&
                  state.operand2.value == 2;
            })
          ]);

  blocTest('Returns new exercise where the result is hidden',
    build: () {
      final mockRandom = MockRandom();
      _mockRandomNumberGenerator(mockRandom, [0, 1, 2]);
      return ArithmeticBloc(randomGenerator: mockRandom);
    },
    act: (bloc) => bloc.add(
      GenerateNewExerciseArithmeticEvent(ArithmeticOperation.addition, hideResultOnly: true)),
    expect: () => [
      predicate<NewExerciseArithmeticState>((state) {
        return _numberOfHiddenOperands(state) == 1 &&
            state.result.isVisible == false;
      })
    ]);
}
