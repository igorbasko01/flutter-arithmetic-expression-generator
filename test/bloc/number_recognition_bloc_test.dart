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
        mockRandomNumberGenerator(mockRandom, [1, 2, 0]);
        return NumberRecognitionBloc(randomNumberGenerator: mockRandom);
      },
      act: (bloc) => bloc.add(GenerateNewExerciseNumberRecognitionEvent()),
      expect: () => [
            isA<ExerciseNumberRecognitionState>().having(
                (state) => state.objectType,
                'object type',
                NumberRecognitionObjectType.circle),
          ]);

  blocTest('Returns new Number Recognition Exercise of squares',
      build: () {
        final mockRandom = MockRandom();
        mockRandomNumberGenerator(mockRandom, [0, 2, 0]);
        return NumberRecognitionBloc(randomNumberGenerator: mockRandom);
      },
      act: (bloc) => bloc.add(GenerateNewExerciseNumberRecognitionEvent()),
      expect: () => [
            isA<ExerciseNumberRecognitionState>().having(
                (state) => state.objectType,
                'object type',
                NumberRecognitionObjectType.square),
          ]);

  blocTest('Generates a random number of objects',
      build: () {
        final mockRandom = MockRandom();
        mockRandomNumberGenerator(mockRandom, [0, 1, 0]);
        return NumberRecognitionBloc(randomNumberGenerator: mockRandom);
      },
      act: (bloc) => bloc.add(GenerateNewExerciseNumberRecognitionEvent()),
      expect: () => [
            isA<ExerciseNumberRecognitionState>().having(
                (state) => state.numberOfObjects, 'number of objects', 2),
          ]);

  blocTest('Returns the correct answer in first answer',
      build: () {
        final mockRandom = MockRandom();
        mockRandomNumberGenerator(mockRandom, [0, 1, 0]);
        return NumberRecognitionBloc(randomNumberGenerator: mockRandom);
      },
      act: (bloc) => bloc.add(GenerateNewExerciseNumberRecognitionEvent()),
      expect: () => [
            isA<ExerciseNumberRecognitionState>()
                .having((state) => state.possibleAnswers[0], 'first answer', 2),
          ]);

  blocTest('Returns the correct answer in second answer',
    build: () {
      final mockRandom = MockRandom();
      mockRandomNumberGenerator(mockRandom, [0, 1, 1]);
      return NumberRecognitionBloc(randomNumberGenerator: mockRandom);
    },
    act: (bloc) => bloc.add(GenerateNewExerciseNumberRecognitionEvent()),
    expect: () => [
      isA<ExerciseNumberRecognitionState>()
        .having((state) => state.possibleAnswers[1], 'second answer', 2),
    ]);

  blocTest('Returns the correct answer in third answer',
    build: () {
      final mockRandom = MockRandom();
      mockRandomNumberGenerator(mockRandom, [0, 1, 2]);
      return NumberRecognitionBloc(randomNumberGenerator: mockRandom);
    },
    act: (bloc) => bloc.add(GenerateNewExerciseNumberRecognitionEvent()),
    expect: () => [
      isA<ExerciseNumberRecognitionState>()
        .having((state) => state.possibleAnswers[2], 'third answer', 2),
    ]);
}
