import 'package:flutter/material.dart';

class ArithmeticExerciseGamePage extends StatefulWidget {
  const ArithmeticExerciseGamePage({Key? key}) : super(key: key);

  @override
  State<ArithmeticExerciseGamePage> createState() =>
      _ArithmeticExerciseGamePageState();
}

class _ArithmeticExerciseGamePageState
    extends State<ArithmeticExerciseGamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Arithmetic Exercise Game'),
        ),
        body: const Center(
          child: Text('Arithmetic Exercise Game'),
        ));
  }
}
