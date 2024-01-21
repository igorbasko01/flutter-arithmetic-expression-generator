import 'package:arithmetic_expressions_generator/models/arithmetic_operation.dart';
import 'package:flutter/material.dart';

class ArithmeticExerciseGamePage extends StatefulWidget {
  const ArithmeticExerciseGamePage({Key? key}) : super(key: key);

  @override
  State<ArithmeticExerciseGamePage> createState() =>
      _ArithmeticExerciseGamePageState();
}

class _ArithmeticExerciseGamePageState
    extends State<ArithmeticExerciseGamePage> {
  int _maxOperandValue = 30;
  ArithmeticOperation _selectedOperation = ArithmeticOperation.addition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arithmetic Exercise Game'),
      ),
      body: const Center(
        child: Text('Arithmetic Exercise Game'),
      ),
      bottomSheet: _settings(),
    );
  }

  Widget _settings() {
    return BottomSheet(
        onClosing: () {},
        builder: (BuildContext sheetContext) {
          return Container(
              color: Colors.white,
              height: 200.0,
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Max operand value: $_maxOperandValue'),
                    Slider(
                        value: _maxOperandValue.toDouble(),
                        min: 0,
                        max: 1000,
                        divisions: 200,
                        label: '$_maxOperandValue',
                        onChanged: (double value) {
                          setState(() {
                            _maxOperandValue = value.toInt();
                          });
                        }),
                    DropdownButton<ArithmeticOperation>(
                        value: _selectedOperation,
                        items: ArithmeticOperation.values
                            .map((ArithmeticOperation operation) {
                          return DropdownMenuItem<ArithmeticOperation>(
                              value: operation,
                              child: Text(operation.toString()));
                        }).toList(),
                        onChanged: (ArithmeticOperation? operation) {
                          setState(() {
                            _selectedOperation = operation!;
                          });
                        })
                  ]));
        });
  }
}
