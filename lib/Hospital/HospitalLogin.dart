import 'package:flutter/material.dart';
import 'package:project1/Hospital/HospitalRegistration.dart';
import 'package:project1/Hospital/HospitalOtpPage.dart';
import 'package:http/http.dart' as http;
import 'package:project1/Hospital/HospitalVisitDetails.dart';
import 'package:flushbar/flushbar.dart';
import 'dart:convert';

class HospitalLoginWidget extends StatefulWidget {
  const HospitalLoginWidget({Key? key}) : super(key: key);

  @override
  State<HospitalLoginWidget> createState() => _HospitalLoginWidgetState();
}

class _HospitalLoginWidgetState extends State<HospitalLoginWidget> {
  TextEditingController hospitalIdController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();

  String hospitalId = "";
  String emailId = "";
  var error;


  Future<bool> sendSMS() async {

    try {

      String url = 'https://anuragchandra.com/aac_project/Database/GET/get_Hospital_info.php';

      final http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'hospitalId': hospitalId,
          //'name':widget.name,
          'emailId': emailId,
        }),
      );

      setState(() {
        error = jsonDecode(response.body)['error'];
      });

      String message = jsonDecode(response.body)['message'];
      print ("error: " + error.toString() + " message: " + message);
      if (error) {
        Flushbar(
          title: "Sign In Error",
          message: message,
          duration: Duration(seconds: 10),
        )..show(context);
      } else {
//        _navigateToSubmitOTP();
        Flushbar(
          title: "OTP Success",
          message: message,
          duration: Duration(seconds: 10),
        )..show(context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => hospitalOtpPageWidget(hospitalId: hospitalId)),
        );
      }
    }
    catch (e) {
      var errorMessage = e.toString();
      print(e);
      Flushbar(
        title: "Sign In Error",
        message: errorMessage,
        duration: Duration(seconds: 5),
      )..show(context);
      throw Exception('Could not send SMS');
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospital Login'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Health Care App',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: hospitalIdController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'hospitalId Number',
                  ),
                  onChanged: (val1) {
                    hospitalId = val1;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  //obscureText: true,
                  controller: emailIdController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'EmailId',
                  ),
                  onChanged: (val2) {
                    emailId = val2;
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: const Text('Forgot Password',),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () {
                      sendSMS();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) =>  hospitalOtpPageWidget(hospitalId:hospitalId)),);
                    },
                  )
              ),
              Row(
                children: <Widget>[
                  const Text('Do not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HospitalRegistrationWidget()),
                      );
                      //signup screen
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          )),
    );
  }
}