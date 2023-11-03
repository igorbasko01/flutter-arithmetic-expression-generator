import 'package:arithmetic_expressions_generator/bloc/arithmetic_state.dart';
import 'package:arithmetic_expressions_generator/models/arithmetic_operation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ArithmeticState returns addition arithmetic string', () {
    final arithmeticState = NewExerciseArithmeticState(1, 2, ArithmeticOperation.addition);
    expect(arithmeticState.asArithmeticString(), '1 + 2 =');
  });

  test('ArithmeticState returns subtraction arithmetic string', () {
    final arithmeticState = NewExerciseArithmeticState(1, 2, ArithmeticOperation.subtraction);
    expect(arithmeticState.asArithmeticString(), '1 - 2 =');
  });

  test('ArithmeticState returns multiplication arithmetic string', () {
    final arithmeticState = NewExerciseArithmeticState(1, 2, ArithmeticOperation.multiplication);
    expect(arithmeticState.asArithmeticString(), '1 x 2 =');
  });

  test('ArithmeticState returns division arithmetic string', () {
    final arithmeticState = NewExerciseArithmeticState(1, 2, ArithmeticOperation.division);
    expect(arithmeticState.asArithmeticString(), '1 : 2 =');
  });
}