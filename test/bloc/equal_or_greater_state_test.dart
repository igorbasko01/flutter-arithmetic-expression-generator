import 'package:arithmetic_expressions_generator/bloc/equal_or_greater_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('exercise holds correct answer left is greater', () {
    final state = ExerciseEqualOrGreaterState(2, 1);
    expect(state.correctAnswer, EqualOrGreater.leftGreater);
  });

  test('exercise holds correct answer right is greater', () {
    final state = ExerciseEqualOrGreaterState(1, 2);
    expect(state.correctAnswer, EqualOrGreater.rightGreater);
  });

  test('exercise holds correct answer equal', () {
    final state = ExerciseEqualOrGreaterState(1, 1);
    expect(state.correctAnswer, EqualOrGreater.equal);
  });

  test('exercise cant have a negative value for left', () {
    // TODO: implement test
    // expect(() => ExerciseEqualOrGreaterState(-1, 1), throwsAssertionError);
  });

  test('exercise cant have a negative value for right', () {
    // TODO: implement test
    // expect(() => ExerciseEqualOrGreaterState(1, -1), throwsAssertionError);
  });
}