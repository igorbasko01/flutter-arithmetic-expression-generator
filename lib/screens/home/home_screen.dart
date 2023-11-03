import 'package:arithmetic_expressions_generator/bloc/arithmetic_bloc.dart';
import 'package:arithmetic_expressions_generator/bloc/arithmetic_event.dart';
import 'package:arithmetic_expressions_generator/bloc/arithmetic_state.dart';
import 'package:arithmetic_expressions_generator/models/arithmetic_operation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: BlocBuilder<ArithmeticBloc, ArithmeticState>(
        builder: (blocContext, state) {
          if (state is InitialArithmeticState) {
            return _view('Welcome to the Arithmetic Exercise Generator!');
          } else if (state is NewExerciseArithmeticState) {
            return _view(state.asArithmeticString());
          } else {
            return Container();
          }
        },
      )
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

  Widget _view(String text) {
    return Column(
        children: [
          Text(text),
          _operationDropDown(),
          ElevatedButton(
              onPressed: () {
                context.read<ArithmeticBloc>().add(
                    GenerateNewExerciseArithmeticEvent(selectedOperation));
              }, child: const Text('Generate Exercise')),
        ]
    );
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
