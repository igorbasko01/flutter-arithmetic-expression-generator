import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      body: Center(
        child: Column(
          children: [
            const Text('Number Recognition Exercise Here'),
            const Divider(color: Colors.grey, thickness: 1),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('1'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('2'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('3'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}