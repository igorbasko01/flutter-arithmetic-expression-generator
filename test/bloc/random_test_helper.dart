import 'package:arithmetic_expressions_generator/utils/random_number_generator.dart';
import 'package:mocktail/mocktail.dart';

class MockRandom extends Mock implements RandomNumberGenerator {}

void mockRandomNumberGenerator(MockRandom mockRandom, List<int> answers) {
  var callCount = 0;
  when(() => mockRandom.nextInt(any()))
      .thenAnswer((_) => answers[callCount++]);
}