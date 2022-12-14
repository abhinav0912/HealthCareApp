import 'package:flutter/material.dart';
import 'package:project1/Patient/PatientRegistration.dart';
import 'package:project1/Patient/PatientHomePage.dart';

class PatientHomePageWidget extends StatefulWidget {
  final String name;

  const PatientHomePageWidget({Key? key, required this.name}) : super(key: key);

  @override
  State<PatientHomePageWidget> createState() => _PatientHomePageWidgetState();
}

class _PatientHomePageWidgetState extends State<PatientHomePageWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Care App'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Welcome',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('VITALS'),
                    onPressed: () {
                    },
                  )
              ),
              Container(
                  height: 70,
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: ElevatedButton(
                    child: const Text('PRE-EXISTING CONDITIONS'),
                    onPressed: () {
                    },
                  )
              ),
              Container(
                  height: 80,
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: ElevatedButton(
                    child: const Text('CURRENT PROBLEM'),
                    onPressed: () {
                    },
                  )
              ),
              Container(
                  height: 80,
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: () {
                    },
                  )
              )
            ],
          )),
    );
  }
}