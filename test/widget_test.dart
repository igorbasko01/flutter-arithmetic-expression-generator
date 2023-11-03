import 'package:arithmetic_expressions_generator/models/arithmetic_operation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:arithmetic_expressions_generator/main.dart';

void main() {
  testWidgets('Main home page smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    expect(find.text('Welcome to the Arithmetic Exercise Generator!'),
        findsOneWidget);
    expect(find.byType(DropdownButton<ArithmeticOperation>), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Generate Exercise'),
        findsOneWidget);
  });
}
