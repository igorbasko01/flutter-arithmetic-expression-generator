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
}