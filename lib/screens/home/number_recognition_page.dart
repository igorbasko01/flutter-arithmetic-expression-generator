import 'package:arithmetic_expressions_generator/bloc/number_recognition_bloc.dart';
import 'package:arithmetic_expressions_generator/bloc/number_recognition_event.dart';
import 'package:arithmetic_expressions_generator/bloc/number_recognition_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberRecognitionPage extends StatefulWidget {
  const NumberRecognitionPage({Key? key}) : super(key: key);

  @override
  State<NumberRecognitionPage> createState() => _NumberRecognitionPageState();
}

class _NumberRecognitionPageState extends State<NumberRecognitionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Number Recognition')),
      body: BlocProvider<NumberRecognitionBloc>(
        create: (context) => NumberRecognitionBloc(),
        child: BlocBuilder<NumberRecognitionBloc, NumberRecognitionState>(
            builder: (blocContext, state) {
          if (state is InitialNumberRecognitionState) {
            blocContext
                .read<NumberRecognitionBloc>()
                .add(GenerateNewExerciseNumberRecognitionEvent(maxNumber: 10));
            return _initialView(
                'Welcome to the Number Recognition!', blocContext);
          } else if (state is ExerciseNumberRecognitionState) {
            return _drawExercise(state, blocContext);
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

  Widget _drawExercise(
      ExerciseNumberRecognitionState state, BuildContext blocContext) {
    return Column(children: [
      if (state.objectType == NumberRecognitionObjectType.circle)
        _drawObjects(state.numberOfObjects, _drawCircle)
      else
        _drawObjects(state.numberOfObjects, _drawSquare),
      const Divider(color: Colors.grey, thickness: 1),
      Row(
          children: state.possibleAnswers
              .map((e) =>
                  ElevatedButton(onPressed: () {}, child: Text(e.toString())))
              .toList()),
    ]);
  }

  Widget _drawObjects(int numberOfObjects, Function drawObject) {
    return Row(
        children: List.generate(numberOfObjects * 2 - 1, (index) {
      if (index % 2 == 0) {
        return drawObject();
      } else {
        return const SizedBox(width: 10);
      }
    }));
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
}
