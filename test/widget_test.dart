import 'package:arithmetic_expressions_generator/bloc/arithmetic_bloc.dart';
import 'package:arithmetic_expressions_generator/bloc/arithmetic_event.dart';
import 'package:arithmetic_expressions_generator/bloc/arithmetic_state.dart';
import 'package:arithmetic_expressions_generator/models/arithmetic_operation.dart';
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

  testWidgets('Main home page smoke test', (WidgetTester tester) async {
    when(() => mockArithmeticBloc?.state)
        .thenReturn(InitialArithmeticState());
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<ArithmeticBloc>.value(
        value: mockArithmeticBloc!,
        child: const ArithmeticExerciseGeneratorPage(),
      ),
    ));

    expect(find.text('Welcome to the Arithmetic Exercise Generator!'),
        findsOneWidget);
    expect(find.byType(DropdownButton<ArithmeticOperation>), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Generate Exercise'),
        findsOneWidget);
  });
}
