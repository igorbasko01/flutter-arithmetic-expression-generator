import 'package:arithmetic_expressions_generator/bloc/number_recognition_event.dart';
import 'package:arithmetic_expressions_generator/bloc/number_recognition_state.dart';
import 'package:arithmetic_expressions_generator/utils/random_number_generator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberRecognitionBloc
    extends Bloc<NumberRecognitionEvent, NumberRecognitionState> {
  final RandomNumberGenerator random;

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

    emit(ExerciseNumberRecognitionState(
        objectType, 3, {1, 2, 3}));
  }
}
