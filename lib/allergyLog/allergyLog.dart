import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:log_allergy/services/firestore.dart';
import 'package:log_allergy/shared/shared.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

import '../services/models.dart';

class AllergyLogScreen extends StatelessWidget {
  const AllergyLogScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  // This widget will contain a counter with buttons to increment or decrement the counter.
  // This widget will contain a selector with 3 options [Easy, Medium, Hard]
  // This widget will contain another selector with 3 options [Easy, Medium, Hard]
  @override
  Widget build(BuildContext context) {
    int _counter = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Allergy'),
      ),
      // Counter widget with buttons to increment or decrement the counter.
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const FlutterLogo(
              size: 50,
            ),
            const Text(
              'Amount of Smudges',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            NumberInputPrefabbed.roundedButtons(
              controller: TextEditingController(),
              incDecBgColor: const Color.fromARGB(255, 101, 21, 148),
              buttonArrangement: ButtonArrangement.incRightDecLeft,
              onIncrement: (num newlyIncrementedValue) {
                var log = Log(
                  amount: newlyIncrementedValue,
                  severity: '',
                );
                FirestoreService().updateLog(log);
              },
              onDecrement: (num newlyDecrementedValue) {
                var log = Log(
                  amount: newlyDecrementedValue,
                  severity: '',
                );
                FirestoreService().updateLog(log);
              },
            ),
            const Text(
              'Itching Severity',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            MyStatefulDropdown(onSelectParam: (String param) {
              var log = Log(
                amount: 0,
                severity: param,
              );
              FirestoreService().updateLog(log);
            }),
            // btn to save the data
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class MyStatefulDropdown extends StatefulWidget {
  MyStatefulDropdown({Key? key, this.onSelectParam}) : super(key: key);

  final Function(String)? onSelectParam;
  @override
  State<MyStatefulDropdown> createState() => _MyStatefulDropdownState();
}

class _MyStatefulDropdownState extends State<MyStatefulDropdown> {
  String dropdownValue = 'None';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      alignment: Alignment.center,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
        widget.onSelectParam!(newValue!);
      },
      items: <String>['None', 'Little', 'Medium', 'Very']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
