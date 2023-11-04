import 'dart:math';

abstract class RandomNumberGenerator {
  int nextInt(int max);
}

class DefaultRandomNumberGenerator implements RandomNumberGenerator {
  @override
  int nextInt(int max) {
    return Random().nextInt(max);
  }
}