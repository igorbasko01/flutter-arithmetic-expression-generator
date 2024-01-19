import 'package:arithmetic_expressions_generator/screens/home/main_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Main Menu Page contains the Arithmetic Expressions button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MainMenuPage()));
    expect(
        find.byKey(const Key('arithmeticExpressionsButton')), findsOneWidget);
  });

  testWidgets('Main Menu Page contains the Number Recognition button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MainMenuPage()));
    expect(find.byKey(const Key('numberRecognitionButton')), findsOneWidget);
  });

  testWidgets('Main Menu Page contains Arithmetic Expressions Game button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MainMenuPage()));
    expect(find.byKey(const Key('arithmeticExpressionsGameButton')), findsOneWidget);
  });
}
