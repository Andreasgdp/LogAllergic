import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AllergyLogScreen extends StatelessWidget {
  const AllergyLogScreen({Key? key}) : super(key: key);

  // This widget is the root of your application. 
  // This widget will contain a counter with buttons to increment or decrement the counter.
  // This widget will contain a selector with 3 options [Easy, Medium, Hard]
  // This widget will contain another selector with 3 options [Easy, Medium, Hard]
  @override
  Widget build(BuildContext context) {
    var _counter;
    var _incrementCounter;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Allergy'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "You have pushed the button this many times:",
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
