import 'package:flutter/material.dart';
import 'package:tower_of_hanoi/tower_of_hanoi.dart';

void main() => runApp(Application());

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tower of Hanoi',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 37, 37, 38),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: TowerOfHanoi(),
        ),
      ),
    );
  }
}
