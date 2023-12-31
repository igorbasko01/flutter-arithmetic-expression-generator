import 'package:arithmetic_expressions_generator/bloc/arithmetic_bloc.dart';
import 'package:arithmetic_expressions_generator/bloc/number_recognition_bloc.dart';
import 'package:arithmetic_expressions_generator/screens/home/arithemetic_exercise_generator_page.dart';
import 'package:arithmetic_expressions_generator/screens/home/number_recognition_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ArithmeticBloc>(
          create: (context) => ArithmeticBloc(),
        ),
        BlocProvider<NumberRecognitionBloc>(
          create: (context) => NumberRecognitionBloc(),
        ),
      ],
      child: const MainMenuPageView(),
    );
  }
}

class MainMenuPageView extends StatelessWidget {
  const MainMenuPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Main Menu')),
        body: Center(
            child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return BlocProvider.value(
                        value: BlocProvider.of<ArithmeticBloc>(context),
                        child: const ArithmeticExerciseGeneratorPage());
                  }));
                },
                child: const Text('Arithmetic Exercise Generator')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return BlocProvider.value(
                        value: BlocProvider.of<NumberRecognitionBloc>(context),
                        child: const NumberRecognitionPage());
                  }));
                },
                child: const Text('Number Recognition'))
          ],
        )));
  }
}
