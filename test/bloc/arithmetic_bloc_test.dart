import 'package:arithmetic_expressions_generator/bloc/arithmetic_bloc.dart';
import 'package:arithmetic_expressions_generator/bloc/arithmetic_event.dart';
import 'package:arithmetic_expressions_generator/bloc/arithmetic_state.dart';
import 'package:arithmetic_expressions_generator/models/arithmetic_operation.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  blocTest<ArithmeticBloc, ArithmeticState>(
      'Returns a new exercise state for addition event',
      build: () {
        return ArithmeticBloc();
      },
      act: (bloc) {
        bloc.add(
            GenerateNewExerciseArithmeticEvent(ArithmeticOperation.addition));
        bloc.add(
            GenerateNewExerciseArithmeticEvent(ArithmeticOperation.addition));
      },
      expect: () => [
            predicate<NewExerciseArithmeticState>((state) {
              return state.operand1 >= 0 &&
                  state.operand2 >= 0 &&
                  state.operator == ArithmeticOperation.addition;
            }),
            predicate<NewExerciseArithmeticState>((state) {
              return state.operand1 >= 0 &&
                  state.operand2 >= 0 &&
                  state.operator == ArithmeticOperation.addition;
            })
          ]);
}
