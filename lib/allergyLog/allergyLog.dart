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
    return FutureBuilder<Log>(
      future: FirestoreService().getCurrentLog(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          var log = snapshot.data!;

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
                    initialValue: log.amount,
                    incDecBgColor: const Color.fromARGB(255, 101, 21, 148),
                    buttonArrangement: ButtonArrangement.incRightDecLeft,
                    onIncrement: (num newlyIncrementedValue) {
                      log.amount = newlyIncrementedValue;
                      FirestoreService().updateLog(log);
                    },
                    onDecrement: (num newlyDecrementedValue) {
                      log.amount = newlyDecrementedValue;
                      FirestoreService().updateLog(log);
                    },
                    onChanged: (num newlyChangedValue) {
                      log.amount = newlyChangedValue;
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
                    log.severity = param;
                    FirestoreService().updateLog(log);
                  }),
                  // btn to save the data
                ],
              ),
            ),
            bottomNavigationBar: const BottomNavBar(),
          );
        } else {
          return const Text('No topics found in Firestore. Check database');
        }
      },
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
