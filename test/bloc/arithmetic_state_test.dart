import 'package:arithmetic_expressions_generator/bloc/arithmetic_state.dart';
import 'package:arithmetic_expressions_generator/models/arithmetic_operation.dart';
import 'package:arithmetic_expressions_generator/models/exercise.dart';
import 'package:arithmetic_expressions_generator/models/operand.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ArithmeticState returns addition arithmetic string', () {
    final arithmeticState = NewExerciseArithmeticState([
      Exercise(Operand(1), Operand(2), ArithmeticOperation.addition, Operand(3))
    ]);
    expect(arithmeticState.exercises.first.asArithmeticString(), '1 + 2 = 3');
  });

  test('ArithmeticState hides first operand in addition', () {
    final arithmeticState = NewExerciseArithmeticState([
      Exercise(Operand(1, isVisible: false), Operand(2),
          ArithmeticOperation.addition, Operand(3))
    ]);
    expect(arithmeticState.exercises.first.asArithmeticString(), '_ + 2 = 3');
  });

  test('ArithmeticState hides second operand in addition', () {
    final arithmeticState = NewExerciseArithmeticState([
      Exercise(Operand(1), Operand(2, isVisible: false),
          ArithmeticOperation.addition, Operand(3))
    ]);
    expect(arithmeticState.exercises.first.asArithmeticString(), '1 + _ = 3');
  });

  test('ArithmeticState hides result operand in addition', () {
    final arithmeticState = NewExerciseArithmeticState([
      Exercise(Operand(1), Operand(2), ArithmeticOperation.addition,
          Operand(3, isVisible: false))
    ]);
    expect(arithmeticState.exercises.first.asArithmeticString(), '1 + 2 = _');
  });

  test('ArithmeticState returns subtraction arithmetic string', () {
    final arithmeticState = NewExerciseArithmeticState([
      Exercise(
          Operand(2), Operand(1), ArithmeticOperation.subtraction, Operand(1))
    ]);
    expect(arithmeticState.exercises.first.asArithmeticString(), '2 - 1 = 1');
  });

  test('ArithmeticState hides first operand in subtraction', () {
    final arithmeticState = NewExerciseArithmeticState([Exercise(
        Operand(2, isVisible: false),
        Operand(1),
        ArithmeticOperation.subtraction,
        Operand(1))]);
    expect(arithmeticState.exercises.first.asArithmeticString(), '_ - 1 = 1');
  });

  test('ArithmeticState hides second operand in subtraction', () {
    final arithmeticState = NewExerciseArithmeticState([Exercise(
        Operand(2),
        Operand(1, isVisible: false),
        ArithmeticOperation.subtraction,
        Operand(1))]);
    expect(arithmeticState.exercises.first.asArithmeticString(), '2 - _ = 1');
  });

  test('ArithmeticState hides result operand in subtraction', () {
    final arithmeticState = NewExerciseArithmeticState([Exercise(Operand(2), Operand(1),
        ArithmeticOperation.subtraction, Operand(1, isVisible: false))]);
    expect(arithmeticState.exercises.first.asArithmeticString(), '2 - 1 = _');
  });

  test('ArithmeticState returns multiplication arithmetic string', () {
    final arithmeticState = NewExerciseArithmeticState([Exercise(
        Operand(1), Operand(2), ArithmeticOperation.multiplication, Operand(2))]);
    expect(arithmeticState.exercises.first.asArithmeticString(), '1 x 2 = 2');
  });

  test('ArithmeticState hides first operand in multiplication', () {
    final arithmeticState = NewExerciseArithmeticState([Exercise(
        Operand(1, isVisible: false),
        Operand(2),
        ArithmeticOperation.multiplication,
        Operand(2))]);
    expect(arithmeticState.exercises.first.asArithmeticString(), '_ x 2 = 2');
  });

  test('ArithmeticState hides second operand in multiplication', () {
    final arithmeticState = NewExerciseArithmeticState([Exercise(
        Operand(1),
        Operand(2, isVisible: false),
        ArithmeticOperation.multiplication,
        Operand(2))]);
    expect(arithmeticState.exercises.first.asArithmeticString(), '1 x _ = 2');
  });

  test('ArithmeticState hides result operand in multiplication', () {
    final arithmeticState = NewExerciseArithmeticState([Exercise(Operand(1), Operand(2),
        ArithmeticOperation.multiplication, Operand(2, isVisible: false))]);
    expect(arithmeticState.exercises.first.asArithmeticString(), '1 x 2 = _');
  });

  test('ArithmeticState returns division arithmetic string', () {
    final arithmeticState = NewExerciseArithmeticState([Exercise(
        Operand(2), Operand(1), ArithmeticOperation.division, Operand(2))]);
    expect(arithmeticState.exercises.first.asArithmeticString(), '2 : 1 = 2');
  });

  test('ArithmeticState hides first operand in division', () {
    final arithmeticState = NewExerciseArithmeticState([Exercise(
        Operand(2, isVisible: false),
        Operand(1),
        ArithmeticOperation.division,
        Operand(2))]);
    expect(arithmeticState.exercises.first.asArithmeticString(), '_ : 1 = 2');
  });

  test('ArithmeticState hides second operand in division', () {
    final arithmeticState = NewExerciseArithmeticState([Exercise(Operand(2),
        Operand(1, isVisible: false), ArithmeticOperation.division, Operand(2))]);
    expect(arithmeticState.exercises.first.asArithmeticString(), '2 : _ = 2');
  });

  test('ArithmeticState hides result operand in division', () {
    final arithmeticState = NewExerciseArithmeticState([Exercise(Operand(2), Operand(1),
        ArithmeticOperation.division, Operand(2, isVisible: false))]);
    expect(arithmeticState.exercises.first.asArithmeticString(), '2 : 1 = _');
  });
}
