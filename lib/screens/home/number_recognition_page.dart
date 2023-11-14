import 'package:arithmetic_expressions_generator/bloc/number_recognition_bloc.dart';
import 'package:arithmetic_expressions_generator/bloc/number_recognition_event.dart';
import 'package:arithmetic_expressions_generator/bloc/number_recognition_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberRecognitionPage extends StatefulWidget {
  const NumberRecognitionPage({Key? key}) : super(key: key);

  @override
  State<NumberRecognitionPage> createState() => _NumberRecognitionPageState();
}

class _NumberRecognitionPageState extends State<NumberRecognitionPage> {
  int _maxObjects = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Number Recognition')),
      bottomSheet: _settings(),
      body: BlocProvider<NumberRecognitionBloc>(
        create: (context) => NumberRecognitionBloc(),
        child: BlocBuilder<NumberRecognitionBloc, NumberRecognitionState>(
            builder: (blocContext, state) {
              if (state is InitialNumberRecognitionState) {
                blocContext
                    .read<NumberRecognitionBloc>()
                    .add(
                    GenerateNewExerciseNumberRecognitionEvent(maxNumber: _maxObjects));
                return _initialView(
                    'Welcome to the Number Recognition!', blocContext);
              } else if (state is ExerciseNumberRecognitionState) {
                return _drawExercise(state, blocContext);
              } else if (state is AnswerNumberRecognitionState) {
                return _drawAnswer(state, blocContext);
              } else {
                return Container();
              }
            }),
      ),
    );
  }

  Widget _initialView(String text, BuildContext blocContext) {
    return Column(children: [
      Text(text),
    ]);
  }

  Widget _settings() {
    return BottomSheet(onClosing: () {}, builder: (BuildContext sheetContext) {
      return Container(
        color: Colors.white,
        height: 150.0,
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Max number of objects: $_maxObjects'),
          Slider(
            value: _maxObjects.toDouble(),
            min: 1.0,
            max: 30.0,
            divisions: 30,
            label: _maxObjects.round().toString(),
            onChanged: (double value) {
              setState(() {
                _maxObjects = value.toInt();
              });
            },
          )
        ])
      );
    });
  }

  Widget _drawExercise(ExerciseNumberRecognitionState state,
      BuildContext blocContext) {
    return Column(children: [
      if (state.objectType == NumberRecognitionObjectType.circle)
        _drawObjects(state.numberOfObjects, _drawCircle)
      else
        _drawObjects(state.numberOfObjects, _drawSquare),
      const Divider(color: Colors.grey, thickness: 1),
      Row(
          children: state.possibleAnswers
              .map((e) =>
              ElevatedButton(
                  onPressed: () {
                    blocContext.read<NumberRecognitionBloc>().add(
                        CheckAnswerNumberRecognitionEvent(
                            state.numberOfObjects, e));
                  },
                  child: Text(e.toString())))
              .toList()),
    ]);
  }

  Widget _drawObjects(int numberOfObjects, Function drawObject) {
    return Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: List.generate(numberOfObjects, (index) => drawObject()));
  }

  Widget _drawCircle() {
    return Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ));
  }

  Widget _drawSquare() {
    return Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.rectangle,
        ));
  }

  Widget _drawAnswer(AnswerNumberRecognitionState state,
      BuildContext blocContext) {
    return Column(children: [
      Text(state.isCorrect ? 'Correct!' : 'Wrong!'),
      state.isCorrect ? _drawHappyFace() : _drawSadFace(),
      state.isCorrect
          ? Container()
          : _drawObjects(state.correctAnswer, _drawSquare),
      const Text('The correct answer is '),
      Text(state.correctAnswer.toString(),
          style: const TextStyle(fontSize: 30)),
      ElevatedButton(
          onPressed: () =>
              blocContext
                  .read<NumberRecognitionBloc>()
                  .add(
                  GenerateNewExerciseNumberRecognitionEvent(maxNumber: _maxObjects)),
          child: const Text('Next')),
    ]);
  }

  Widget _drawHappyFace() {
    return Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ));
  }

  Widget _drawSadFace() {
    return Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ));
  }
}
