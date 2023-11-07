sealed class NumberRecognitionEvent {}

class GenerateNewExerciseNumberRecognitionEvent extends NumberRecognitionEvent {
  final int maxNumber;

  GenerateNewExerciseNumberRecognitionEvent(
      {this.maxNumber = 10});
}

class CheckAnswerNumberRecognitionEvent extends NumberRecognitionEvent {
  final int numberOfObjects;
  final int answer;

  CheckAnswerNumberRecognitionEvent(this.numberOfObjects, this.answer);
}