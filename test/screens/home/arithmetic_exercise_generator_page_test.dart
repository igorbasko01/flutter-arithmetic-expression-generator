import 'package:arithmetic_expressions_generator/bloc/arithmetic_bloc.dart';
import 'package:arithmetic_expressions_generator/bloc/arithmetic_event.dart';
import 'package:arithmetic_expressions_generator/bloc/arithmetic_state.dart';
import 'package:arithmetic_expressions_generator/models/arithmetic_operation.dart';
import 'package:arithmetic_expressions_generator/models/exercise.dart';
import 'package:arithmetic_expressions_generator/models/operand.dart';
import 'package:arithmetic_expressions_generator/screens/home/arithemetic_exercise_generator_page.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockArithmeticBloc extends MockBloc<ArithmeticEvent, ArithmeticState>
    implements ArithmeticBloc {}

void main() {
  MockArithmeticBloc? mockArithmeticBloc;

  setUp(() {
    mockArithmeticBloc = MockArithmeticBloc();
  });

  tearDown(() {
    mockArithmeticBloc?.close();
  });

  testWidgets(
      'Answer slider appears when getting single exercise with hide result only',
      (widgetTester) async {
    when(() => mockArithmeticBloc?.state)
        .thenReturn(NewExerciseArithmeticState([
      Exercise(Operand(1, isVisible: true), Operand(2, isVisible: true),
          ArithmeticOperation.addition, Operand(3, isVisible: false))
    ]));
    await widgetTester.pumpWidget(MaterialApp(
      home: BlocProvider<ArithmeticBloc>.value(
        value: mockArithmeticBloc!,
        child: const ArithmeticExerciseGeneratorPage(),
      ),
    ));
    var slider = find.byKey(const Key('answerSlider'));
    var answerButton = find.byKey(const Key('answerButton'));
    expect(slider, findsOneWidget);
    expect(answerButton, findsOneWidget);
  });

  testWidgets('Fully visible exercise appears on correct answer', (widgetTester) async {
    when(() => mockArithmeticBloc?.state)
        .thenReturn(AnswerCheckArithmeticState(true, Exercise(
            Operand(1, isVisible: true), Operand(2, isVisible: true),
            ArithmeticOperation.addition, Operand(3, isVisible: true))
    ));
    await widgetTester.pumpWidget(MaterialApp(
      home: BlocProvider<ArithmeticBloc>.value(
        value: mockArithmeticBloc!,
        child: const ArithmeticExerciseGeneratorPage(),
      ),
    ));
    var expectedExerciseText = '1 + 2 = 3';
    var exerciseText = find.byKey(const Key('exerciseText'));
    expect(exerciseText, findsOneWidget);
    expect(find.text(expectedExerciseText), findsOneWidget);
  });

  testWidgets('Show answer is correct icon on answer', (widgetTester) async {
    when(() => mockArithmeticBloc?.state)
        .thenReturn(AnswerCheckArithmeticState(true, Exercise(
            Operand(1, isVisible: true), Operand(2, isVisible: true),
            ArithmeticOperation.addition, Operand(3, isVisible: true))
    ));
    await widgetTester.pumpWidget(MaterialApp(
      home: BlocProvider<ArithmeticBloc>.value(
        value: mockArithmeticBloc!,
        child: const ArithmeticExerciseGeneratorPage(),
      ),
    ));
    var answerIcon = find.byKey(const Key('correctAnswerIcon'));
    expect(answerIcon, findsOneWidget);
  });

  testWidgets('Show answer is wrong icon on answer', (widgetTester) async {
    when(() => mockArithmeticBloc?.state)
        .thenReturn(AnswerCheckArithmeticState(false, Exercise(
        Operand(1, isVisible: true), Operand(2, isVisible: true),
        ArithmeticOperation.addition, Operand(4, isVisible: true))
    ));
    await widgetTester.pumpWidget(MaterialApp(
      home: BlocProvider<ArithmeticBloc>.value(
        value: mockArithmeticBloc!,
        child: const ArithmeticExerciseGeneratorPage(),
      ),
    ));
    var answerIcon = find.byKey(const Key('incorrectAnswerIcon'));
    expect(answerIcon, findsOneWidget);
  });

  testWidgets('Show generate exercise on answer result screen', (widgetTester) async {
    when(() => mockArithmeticBloc?.state)
        .thenReturn(AnswerCheckArithmeticState(false, Exercise(
        Operand(1, isVisible: true), Operand(2, isVisible: true),
        ArithmeticOperation.addition, Operand(4, isVisible: true))
    ));
    await widgetTester.pumpWidget(MaterialApp(
      home: BlocProvider<ArithmeticBloc>.value(
        value: mockArithmeticBloc!,
        child: const ArithmeticExerciseGeneratorPage(),
      ),
    ));
    var generateExerciseButton = find.byKey(const Key('generateExerciseButton'));
    expect(generateExerciseButton, findsOneWidget);
  });
}
