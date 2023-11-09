sealed class NumberRecognitionState {}

class InitialNumberRecognitionState extends NumberRecognitionState {}

class ExerciseNumberRecognitionState extends NumberRecognitionState {
  final NumberRecognitionObjectType objectType;
  final int numberOfObjects;
  final List<int> possibleAnswers;

  ExerciseNumberRecognitionState(
      this.objectType, this.numberOfObjects, this.possibleAnswers);
}

class AnswerNumberRecognitionState extends NumberRecognitionState {
  final bool isCorrect;
  final int correctAnswer;

  AnswerNumberRecognitionState(this.isCorrect, this.correctAnswer);
}

enum NumberRecognitionObjectType {
  square,
  circle,
}
