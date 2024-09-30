sealed class EqualOrGreaterState {}

class InitialEqualOrGreaterState extends EqualOrGreaterState {}

// TODO: Extract an exercise model out of this state, so it could be used in
// an answer event. I think it should contain the correctAnswer field as well.
class ExerciseEqualOrGreaterState extends EqualOrGreaterState {
  final int left;
  final int right;
  final EqualOrGreater correctAnswer;

  ExerciseEqualOrGreaterState(this.left, this.right)
      : assert(left >= 0),
        assert(right >= 0),
        correctAnswer = left == right
            ? EqualOrGreater.equal
            : left > right
                ? EqualOrGreater.leftGreater
                : EqualOrGreater.rightGreater;
}

enum EqualOrGreater {
  leftGreater,
  rightGreater,
  equal,
}
