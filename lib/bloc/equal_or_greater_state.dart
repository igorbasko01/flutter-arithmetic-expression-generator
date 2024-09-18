sealed class EqualOrGreaterState {}

class InitialEqualOrGreaterState extends EqualOrGreaterState {}

class ExerciseEqualOrGreaterState extends EqualOrGreaterState {
  final int left;
  final int right;
  final EqualOrGreater correctAnswer;

  ExerciseEqualOrGreaterState(this.left, this.right)
      : correctAnswer = left > right
            ? EqualOrGreater.leftGreater
            : left < right
                ? EqualOrGreater.rightGreater
                : EqualOrGreater.equal;
}

enum EqualOrGreater {
  leftGreater,
  rightGreater,
  equal,
}
