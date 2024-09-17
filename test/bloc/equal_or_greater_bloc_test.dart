import 'package:arithmetic_expressions_generator/bloc/equal_or_greater_bloc.dart';
import 'package:arithmetic_expressions_generator/bloc/equal_or_greater_event.dart';
import 'package:arithmetic_expressions_generator/bloc/equal_or_greater_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  blocTest('Returns new Equal or Greater exercise',
      build: () => EqualOrGreaterBloc(),
      act: (bloc) => bloc.add(GenerateNewExerciseEqualOrGreaterEvent()),
      expect: () => [isA<ExerciseEqualOrGreaterState>()]);
}
