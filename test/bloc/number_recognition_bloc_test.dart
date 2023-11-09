import 'package:arithmetic_expressions_generator/bloc/number_recognition_bloc.dart';
import 'package:arithmetic_expressions_generator/bloc/number_recognition_event.dart';
import 'package:arithmetic_expressions_generator/bloc/number_recognition_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'random_test_helper.dart';

void main() {
  blocTest('Returns new Number Recognition Exercise of circles',
      build: () {
        final mockRandom = MockRandom();
        mockRandomNumberGenerator(mockRandom, [1]);
        return NumberRecognitionBloc(randomNumberGenerator: mockRandom);
      },
      act: (bloc) => bloc.add(GenerateNewExerciseNumberRecognitionEvent()),
      expect: () => [
            predicate<ExerciseNumberRecognitionState>((state) {
              return state.objectType == NumberRecognitionObjectType.circle &&
                  state.numberOfObjects == 3 &&
                  state.possibleAnswers.difference({
                    1,
                    2,
                    3
                  }).isEmpty; // checks that the sets contain the same elements.
            })
          ]);

  blocTest('Returns new Number Recognition Exercise of squares',
      build: () {
        final mockRandom = MockRandom();
        mockRandomNumberGenerator(mockRandom, [0]);
        return NumberRecognitionBloc(randomNumberGenerator: mockRandom);
      },
      act: (bloc) => bloc.add(GenerateNewExerciseNumberRecognitionEvent()),
      expect: () => [
            predicate<ExerciseNumberRecognitionState>((state) {
              return state.objectType == NumberRecognitionObjectType.square &&
                  state.numberOfObjects == 3 &&
                  state.possibleAnswers.difference({
                    1,
                    2,
                    3
                  }).isEmpty; // checks that the sets contain the same elements.
            })
          ]);
}
