import 'package:arithmetic_expressions_generator/bloc/arithmetic_bloc.dart';
import 'package:arithmetic_expressions_generator/bloc/arithmetic_event.dart';
import 'package:arithmetic_expressions_generator/bloc/arithmetic_state.dart';
import 'package:arithmetic_expressions_generator/models/arithmetic_operation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArithmeticExerciseGeneratorPage extends StatefulWidget {
  const ArithmeticExerciseGeneratorPage({super.key});

  @override
  State<ArithmeticExerciseGeneratorPage> createState() =>
      _ArithmeticExerciseGeneratorPageState();
}

class _ArithmeticExerciseGeneratorPageState
    extends State<ArithmeticExerciseGeneratorPage> {
  ArithmeticOperation selectedOperation = ArithmeticOperation.addition;
  bool showMaxOperandValueSlider = true;
  bool hideResultOnly = false;
  int maxOperandValue = 30;
  int numberOfExercises = 3;
  int answer = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Arithmetic Exercise Generator'),
        ),
        body: BlocProvider<ArithmeticBloc>(
            create: (context) => ArithmeticBloc(),
            child: BlocBuilder<ArithmeticBloc, ArithmeticState>(
              builder: (blocContext, state) {
                if (state is InitialArithmeticState) {
                  return _view('Welcome to the Arithmetic Exercise Generator!', blocContext, null);
                } else if (state is NewExerciseArithmeticState) {
                  return _view(state.exercises
                      .map((e) => e.asArithmeticString())
                      .join('\n'), blocContext, state);
                } else {
                  return Container();
                }
              },
            )));
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

  Widget _view(String text, BuildContext blocContext, NewExerciseArithmeticState? state) {
    return Column(children: [
      Text(text),
      _operationDropDown(),
      _generateExerciseButton(blocContext),
      state != null ? _generateAnswerButton(blocContext, state) : Container(),
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

  ElevatedButton _generateExerciseButton(BuildContext blocContext) {
    return ElevatedButton(
        onPressed: () {
          blocContext.read<ArithmeticBloc>().add(GenerateNewExerciseArithmeticEvent(
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

  Widget _generateAnswerButton(BuildContext blocContext, NewExerciseArithmeticState state) {
    var exercise = state.exercises.first;
    var isOnlyResultHidden = exercise.operand1.isVisible &&
        exercise.operand2.isVisible &&
        !exercise.result.isVisible;
    return Visibility(
      visible: state.exercises.length == 1 && isOnlyResultHidden,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Answer: $answer'),
            Slider(
                key: const Key('answerSlider'),
                value: answer.toDouble(),
                min: 0,
                max: 100,
                divisions: 100,
                label: '$answer',
                onChanged: (double value) {
                  setState(() {
                    answer = value.toInt();
                  });
                }),
            ElevatedButton(
                key: const Key('answerButton'),
                onPressed: () {
                  blocContext.read<ArithmeticBloc>().add(CheckAnswerArithmeticEvent(state.exercises.first, answer));
                },
                child: const Text('Generate Answer'))
          ],
        )
    );
  }
}
