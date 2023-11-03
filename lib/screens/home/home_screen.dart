import 'package:arithmetic_expressions_generator/models/arithmetic_operation.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ArithmeticOperation selectedOperation = ArithmeticOperation.addition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arithmetic Exercise Generator'),
      ),
      body: Column(
          children: [
            const Text('Welcome to the Arithmetic Exercise Generator!'),
            _operationDropDown(),
            ElevatedButton(
                onPressed: () {}, child: const Text('Generate Exercise')),
          ]
      ),
    );
  }

  String _getOperationText(ArithmeticOperation operation) {
    switch (operation) {
      case ArithmeticOperation.addition:
        return 'Addition';
      case ArithmeticOperation.subtraction:
        return 'Subtraction';
      case ArithmeticOperation.multiplication:
        return 'Multiplication';
      case ArithmeticOperation.division:
        return 'Division';
      default:
        return '';
    }
  }

  DropdownButton<ArithmeticOperation> _operationDropDown() {
    return DropdownButton<ArithmeticOperation>(
        value: selectedOperation,
        items: ArithmeticOperation.values.map((ArithmeticOperation operation) {
          return DropdownMenuItem<ArithmeticOperation>(
              value: operation,
              child: Text(_getOperationText(operation)));
        }).toList(),
        onChanged: (ArithmeticOperation? operation) {
          setState(() {
            selectedOperation = operation!;
          });
        }
    );
  }
}
