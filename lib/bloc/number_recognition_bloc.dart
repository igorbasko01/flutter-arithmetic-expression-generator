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
  }

  void _onGenerateNewExerciseNumberRecognitionEvent(
      GenerateNewExerciseNumberRecognitionEvent event,
      Emitter<NumberRecognitionState> emit) {
    var objectType = NumberRecognitionObjectType
        .values[random.nextInt(NumberRecognitionObjectType.values.length)];
    var numberOfObjects = random.nextInt(event.maxNumber) + 1;
    var rightAnswerPlace = random.nextInt(maxAnswers);
    var otherAnswers = [numberOfObjects-1, numberOfObjects+1];
    var answers = List<int>.filled(maxAnswers, 0);
    answers[rightAnswerPlace] = numberOfObjects;
    for (var i = 0; i < maxAnswers; i++) {
      if (i != rightAnswerPlace) {
        answers[i] = otherAnswers.removeAt(0);
      }
    }

    emit(ExerciseNumberRecognitionState(
        objectType, numberOfObjects, answers));
  }
}
