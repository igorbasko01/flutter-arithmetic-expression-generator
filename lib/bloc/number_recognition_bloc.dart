import 'package:arithmetic_expressions_generator/bloc/number_recognition_event.dart';
import 'package:arithmetic_expressions_generator/bloc/number_recognition_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberRecognitionBloc
    extends Bloc<NumberRecognitionEvent, NumberRecognitionState> {
  NumberRecognitionBloc() : super(InitialNumberRecognitionState()) {
    on<GenerateNewExerciseNumberRecognitionEvent>(
        _onGenerateNewExerciseNumberRecognitionEvent);
  }

  void _onGenerateNewExerciseNumberRecognitionEvent(
      GenerateNewExerciseNumberRecognitionEvent event,
      Emitter<NumberRecognitionState> emit) {
    emit(ExerciseNumberRecognitionState(
        NumberRecognitionObjectType.circle, 3, {1, 2, 3}));
  }
}
