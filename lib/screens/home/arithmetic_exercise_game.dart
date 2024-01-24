import 'package:arithmetic_expressions_generator/bloc/arithmetic_bloc.dart';
import 'package:arithmetic_expressions_generator/bloc/arithmetic_event.dart';
import 'package:arithmetic_expressions_generator/bloc/arithmetic_state.dart';
import 'package:arithmetic_expressions_generator/models/arithmetic_operation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  int _answer = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arithmetic Exercise Game'),
      ),
      body: BlocBuilder<ArithmeticBloc, ArithmeticState>(
        builder: (blocContext, state) {
          if (state is InitialArithmeticState) {
            return _newGameButton(blocContext);
          } else if (state is NewExerciseArithmeticState) {
            return _exerciseDisplay(blocContext, state);
          } else if (state is AnswerCheckArithmeticState) {
            return _answerDisplay(blocContext, state);
          } else {
            return const Center(child: Text('Something went wrong.'));
          }
        },
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

  Widget _newGameButton(BuildContext blocContext) {
    return Center(
        child: Column(children: [
      const Text('Welcome to the Arithmetic Exercise Game!'),
      ElevatedButton(
          key: const Key('newGameButton'),
          onPressed: () {
            blocContext.read<ArithmeticBloc>().add(
                GenerateNewExerciseArithmeticEvent(_selectedOperation,
                    maxOperandValue: _maxOperandValue));
          },
          child: const Text('New Game'))
    ]));
  }

  Widget _exerciseDisplay(
      BuildContext blocContext, NewExerciseArithmeticState state) {
    return Center(
        child: Column(children: [
      Text(state.exercises.first.asArithmeticString()),
      Row(children: [
        Expanded(
            child: TextField(
          decoration: const InputDecoration(labelText: 'Enter a number'),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (String value) {
            setState(() {
              _answer = int.tryParse(value) ?? 0;
            });
          },
        )),
        ElevatedButton(
            onPressed: () {
              blocContext.read<ArithmeticBloc>().add(
                  CheckAnswerArithmeticEvent(state.exercises.first, _answer));
            },
            child: const Text('Answer'))
      ])
    ]));
  }

  Widget _answerDisplay(
      BuildContext blocContext, AnswerCheckArithmeticState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(state.exercise.asArithmeticString()),
        _drawAnswerIcon(state.isCorrect),
        ElevatedButton(
            onPressed: () {
              blocContext.read<ArithmeticBloc>().add(
                  GenerateNewExerciseArithmeticEvent(_selectedOperation,
                      maxOperandValue: _maxOperandValue));
            },
            child: const Text('Next Exercise'))
      ],
    );
  }

  _drawAnswerIcon(bool isCorrect) {
    return isCorrect
        ? const Icon(
            Icons.check,
            color: Colors.green,
            key: Key('correctAnswerIcon'),
          )
        : const Icon(
            Icons.close,
            color: Colors.red,
            key: Key('incorrectAnswerIcon'),
          );
  }
}
