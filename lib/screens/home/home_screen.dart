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
  bool showMaxOperandValueSlider = true;
  bool hideResultOnly = false;
  int maxOperandValue = 30;
  int numberOfExercises = 3;

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
              return _view(state.exercises
                  .map((e) => e.asArithmeticString())
                  .join('\n'));
            } else {
              return Container();
            }
          },
        ));
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
    return Column(children: [
      Text(text),
      _operationDropDown(),
      _generateExerciseButton(),
      _hideResultOnlyCheckbox(),
      _numberOfExercisesSlider(),
      _maxOperandValueSlider(),
    ]);
  }

  DropdownButton<ArithmeticOperation> _operationDropDown() {
    return DropdownButton<ArithmeticOperation>(
        value: selectedOperation,
        items: ArithmeticOperation.values.map((ArithmeticOperation operation) {
          return DropdownMenuItem<ArithmeticOperation>(
              value: operation, child: Text(_getOperationText(operation)));
        }).toList(),
        onChanged: (ArithmeticOperation? operation) {
          setState(() {
            selectedOperation = operation!;
            if (selectedOperation == ArithmeticOperation.multiplication ||
                selectedOperation == ArithmeticOperation.division) {
              showMaxOperandValueSlider = false;
            } else {
              showMaxOperandValueSlider = true;
            }
          });
        });
  }

  ElevatedButton _generateExerciseButton() {
    return ElevatedButton(
        onPressed: () {
          context.read<ArithmeticBloc>().add(GenerateNewExerciseArithmeticEvent(
              selectedOperation,
              hideResultOnly: hideResultOnly,
              maxOperandValue: maxOperandValue,
              numberOfExercises: numberOfExercises));
        },
        child: const Text('Generate Exercise'));
  }

  CheckboxListTile _hideResultOnlyCheckbox() {
    return CheckboxListTile(
        title: const Text('Hide result only'),
        value: hideResultOnly,
        onChanged: (bool? value) {
          setState(() {
            hideResultOnly = value!;
          });
        });
  }

  Visibility _maxOperandValueSlider() {
    return Visibility(
        visible: showMaxOperandValueSlider,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Max operand value: $maxOperandValue'),
          Slider(
              value: maxOperandValue.toDouble(),
              min: 0,
              max: 1000,
              divisions: 200,
              label: '$maxOperandValue',
              onChanged: (double value) {
                setState(() {
                  maxOperandValue = value.toInt();
                });
              })
        ]));
  }

  Column _numberOfExercisesSlider() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Number of exercises: $numberOfExercises'),
      Slider(
          value: numberOfExercises.toDouble(),
          min: 1,
          max: 10,
          divisions: 9,
          label: '$numberOfExercises',
          onChanged: (double value) {
            setState(() {
              numberOfExercises = value.toInt();
            });
          })
    ]);
  }
}
