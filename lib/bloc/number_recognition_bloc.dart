import 'dart:async';

import 'package:arithmetic_expressions_generator/bloc/number_recognition_event.dart';
import 'package:arithmetic_expressions_generator/bloc/number_recognition_state.dart';
import 'package:arithmetic_expressions_generator/utils/random_number_generator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberRecognitionBloc
    extends Bloc<NumberRecognitionEvent, NumberRecognitionState> {
  final RandomNumberGenerator random;
  final int maxAnswers = 3;

  NumberRecognitionBloc({RandomNumberGenerator? randomNumberGenerator})
      : random = randomNumberGenerator ?? DefaultRandomNumberGenerator(),
        super(InitialNumberRecognitionState()) {
    on<GenerateNewExerciseNumberRecognitionEvent>(
        _onGenerateNewExerciseNumberRecognitionEvent);
    on<CheckAnswerNumberRecognitionEvent>(_onCheckAnswerNumberRecognitionEvent);
  }

  void _onGenerateNewExerciseNumberRecognitionEvent(
      GenerateNewExerciseNumberRecognitionEvent event,
      Emitter<NumberRecognitionState> emit) {
    var objectType = NumberRecognitionObjectType
        .values[random.nextInt(NumberRecognitionObjectType.values.length)];
    var numberOfObjects = random.nextInt(event.maxNumber) + 1;
    var answers = _getAnswers(numberOfObjects);

    emit(ExerciseNumberRecognitionState(objectType, numberOfObjects, answers));
  }

  List<int> _getAnswers(int numberOfObjects) {
    var rightAnswerPlace = random.nextInt(maxAnswers);
    var otherAnswers = _getIncorrectAnswers(numberOfObjects);
    var answers = List<int>.filled(maxAnswers, 0);
    answers[rightAnswerPlace] = numberOfObjects;
    for (var i = 0; i < maxAnswers; i++) {
      if (i != rightAnswerPlace) {
        answers[i] = otherAnswers.removeAt(0);
      }
    }
    return answers;
  }

  List<int> _getIncorrectAnswers(int correctAnswer) {
    var defaultStrategy = [correctAnswer - 1, correctAnswer + 1];
    var largestStrategy = [correctAnswer - 1, correctAnswer - 2];
    var smallestStrategy = [correctAnswer + 1, correctAnswer + 2];
    var strategies = [defaultStrategy, largestStrategy, smallestStrategy];
    if (correctAnswer < 3) {
      // Don't allow negative or zero as an answer.
      return defaultStrategy;
    }
    var strategy = strategies[random.nextInt(strategies.length)];
    return strategy;
  }

  void _onCheckAnswerNumberRecognitionEvent(CheckAnswerNumberRecognitionEvent event, Emitter<NumberRecognitionState> emit) {
    emit(AnswerNumberRecognitionState(event.answer == event.numberOfObjects, event.numberOfObjects));
  }
}
