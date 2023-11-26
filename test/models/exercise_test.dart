import 'package:arithmetic_expressions_generator/models/arithmetic_operation.dart';
import 'package:arithmetic_expressions_generator/models/exercise.dart';
import 'package:arithmetic_expressions_generator/models/operand.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Exercise getHiddenOperand returns first operand when hidden', () {
    final exercise = Exercise(
        Operand(1, isVisible: false),
        Operand(2),
        ArithmeticOperation.addition,
        Operand(3));
    expect(exercise.getHiddenOperand(), Operand(1, isVisible: false));
  });

  test('Exercise getHiddenOperand returns second operand when hidden', () {
    final exercise = Exercise(
        Operand(1),
        Operand(2, isVisible: false),
        ArithmeticOperation.addition,
        Operand(3));
    expect(exercise.getHiddenOperand(), Operand(2, isVisible: false));
  });

  test('Exercise getHiddenOperand returns result operand when hidden', () {
    final exercise = Exercise(
        Operand(1),
        Operand(2),
        ArithmeticOperation.addition,
        Operand(3, isVisible: false));
    expect(exercise.getHiddenOperand(), Operand(3, isVisible: false));
  });

  test('Addition exercise evaluates to correct when left side equals result', () {
    final exercise = Exercise(
        Operand(1),
        Operand(2),
        ArithmeticOperation.addition,
        Operand(3));
    expect(exercise.isCorrect(), true);
  });

  test('Addition exercise evaluates to incorrect when left side does not equal result', () {
    final exercise = Exercise(
        Operand(1),
        Operand(2),
        ArithmeticOperation.addition,
        Operand(4));
    expect(exercise.isCorrect(), false);
  });

  test('Subtraction exercise evaluates to correct when left side equals result', () {
    final exercise = Exercise(
        Operand(3),
        Operand(2),
        ArithmeticOperation.subtraction,
        Operand(1));
    expect(exercise.isCorrect(), true);
  });

  test('Subtraction exercise evaluates to incorrect when left side does not equal result', () {
    final exercise = Exercise(
        Operand(3),
        Operand(2),
        ArithmeticOperation.subtraction,
        Operand(2));
    expect(exercise.isCorrect(), false);
  });

  test('Multiplication exercise evaluates to correct when left side equals result', () {
    final exercise = Exercise(
        Operand(3),
        Operand(2),
        ArithmeticOperation.multiplication,
        Operand(6));
    expect(exercise.isCorrect(), true);
  });

  test('Multiplication exercise evaluates to incorrect when left side does not equal result', () {
    final exercise = Exercise(
        Operand(3),
        Operand(2),
        ArithmeticOperation.multiplication,
        Operand(7));
    expect(exercise.isCorrect(), false);
  });

  test('Division exercise evaluates to correct when left side equals result', () {
    final exercise = Exercise(
        Operand(6),
        Operand(2),
        ArithmeticOperation.division,
        Operand(3));
    expect(exercise.isCorrect(), true);
  });

  test('Division exercise evaluates to incorrect when left side does not equal result', () {
    final exercise = Exercise(
        Operand(6),
        Operand(2),
        ArithmeticOperation.division,
        Operand(4));
    expect(exercise.isCorrect(), false);
  });
}