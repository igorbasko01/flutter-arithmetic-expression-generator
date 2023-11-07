import 'package:arithmetic_expressions_generator/bloc/number_recognition_bloc.dart';
import 'package:arithmetic_expressions_generator/bloc/number_recognition_event.dart';
import 'package:arithmetic_expressions_generator/bloc/number_recognition_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  blocTest('Returns new Number Recognition Exercise',
  build: () => NumberRecognitionBloc(),
  act: (bloc) => bloc.add(GenerateNewExerciseNumberRecognitionEvent()),
  expect: () => [
    predicate<ExerciseNumberRecognitionState>((state) {
      return state.objectType == NumberRecognitionObjectType.circle &&
      state.numberOfObjects == 3 &&
      state.possibleAnswers.difference({1, 2, 3}).isEmpty;  // checks that the sets contain the same elements.
    })
  ]);
}