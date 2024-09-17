import 'dart:async';

import 'package:arithmetic_expressions_generator/bloc/equal_or_greater_event.dart';
import 'package:arithmetic_expressions_generator/bloc/equal_or_greater_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EqualOrGreaterBloc
    extends Bloc<EqualOrGreaterEvent, EqualOrGreaterState> {
  EqualOrGreaterBloc() : super(InitialEqualOrGreaterState()) {
    on<GenerateNewExerciseEqualOrGreaterEvent>(
        _onGenerateNewExerciseEqualOrGreaterEvent);
  }

  FutureOr<void> _onGenerateNewExerciseEqualOrGreaterEvent(
      GenerateNewExerciseEqualOrGreaterEvent event,
      Emitter<EqualOrGreaterState> emit) {
    emit(ExerciseEqualOrGreaterState());
  }
}
