import 'package:flutter/material.dart';
import 'package:project1/Hospital/HospitalRegistration.dart';

import 'HospitalLogin.dart';
//import 'package:project1/Hospital/HospitalLogin.dart';
//import 'package:project1/Hospital/PatientHomePage.dart';

class HospitalMainWidget extends StatefulWidget {
  const HospitalMainWidget({Key? key}) : super(key: key);

  @override
  State<HospitalMainWidget> createState() => _HospitalMainWidgetState();
}
class _HospitalMainWidgetState extends State<HospitalMainWidget> {
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
                  builder: (context) => const HospitalRegistrationWidget()),
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
                  builder: (context) => const HospitalLoginWidget()),
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
          title: Text('Hospital Main'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: buttonBar(context),
        ));
  }
}