import 'package:flutter/material.dart';
import 'package:project1/Patient/PatientRegistration.dart';
import 'package:project1/Patient/PatientLogin.dart';
//import 'package:project1/Patient/PatientHomePage.dart';

class PatientMainWidget extends StatefulWidget {
  const PatientMainWidget({Key? key}) : super(key: key);

  @override
  State<PatientMainWidget> createState() => _PatientMainWidgetState();
}
class _PatientMainWidgetState extends State<PatientMainWidget> {
  Widget buttonBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          child: Text('Register', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            onPrimary: Colors.white,
            shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PatientRegistrationWidget()),
            );
          },
        ),
        ElevatedButton(
          child: Text('Login', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            onPrimary: Colors.white,
            shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PatientLoginWidget()),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Main'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: buttonBar(context),
    ));
  }
}