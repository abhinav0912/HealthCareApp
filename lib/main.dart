// @dart=2.9
import 'package:flutter/material.dart';
import 'package:project1/Patient/PatientMain.dart';
import 'package:project1/Hospital/HospitalMain.dart';
import 'package:project1/Patient/PatientLogin.dart';
import 'package:project1/Patient/PatientRegistration.dart';


Widget buttonBar(BuildContext context) {

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
    children:  [
      ElevatedButton(
        child: Text('Patient', style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
          onPrimary: Colors.white,
          shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PatientMainWidget()),
          );
        },
      ),
      ElevatedButton(
        child: Text('Health Care Provider', style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
          onPrimary: Colors.white,
          shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HospitalMainWidget()),
          );
        },
      ),
    ],
  );
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 100));
    return MaterialApp(
      title: 'Health Care App',
      theme: ThemeData(primarySwatch: Colors.red),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 100));
    return Scaffold(
      appBar: AppBar(title: Text('Health Care App')),
      body: Center(
          child: buttonBar(context)
      ),
    );
  }
}