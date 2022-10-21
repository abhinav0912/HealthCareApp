import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project1/Patient/PatientProfile.dart';
import 'package:http/http.dart' as http;
import 'package:flushbar/flushbar.dart';

class patientOtpPageWidget extends StatefulWidget {
  final String aadhar;

  patientOtpPageWidget({Key? key, required this.aadhar}) : super(key: key);

  @override
  State<patientOtpPageWidget> createState() => _patientOtpPageWidgetState();
}

class _patientOtpPageWidgetState extends State<patientOtpPageWidget> {
  TextEditingController otpController = TextEditingController();

  var error;
  bool isLoading = true;
  String otp = " ";

  Future<bool> sendSMS() async {

    print("Otp = "+otp);
    try {

      String url = 'https://anuragchandra.com/aac_project/Database/ADD/patient_verify_otp.php';

      print(otp);

      final http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'aadharNo': widget.aadhar,
          //'name':widget.name,
          'otp': '$otp',
        }),
      );

      setState(() {
        error = jsonDecode(response.body)['error'];
        isLoading = false;
      });

      String message = jsonDecode(response.body)['message'];
      print ("error: " + error.toString() + " message: " + message);
      if (error) {
        Flushbar(
          title: "Sign In Error",
          message: message,
          duration: Duration(seconds: 10),
        )..show(context);
        isLoading = false;
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
              builder: (context) => PatientProfileWidget(aadhar: widget.aadhar)),
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
      isLoading = false;
      throw Exception('Could not send SMS');
    }
    return true;
  }

  Widget Patientotp(){
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: otpController,
        keyboardType: TextInputType.name,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Enter the otp',
          //hintText: 'Enter the otp',
        ),
        onChanged: (val1) {
          otp = val1;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 30));
    return Scaffold(
        appBar: AppBar(
            title: Text('Patient OTP')
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Patientotp(),

              SizedBox(
                height: 0,
              ),

              new Container(
                padding: const EdgeInsets.only(left: 0.0, top: 30.0),
                child: new ElevatedButton(
                  child: const Text('Verify OTP', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                    shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                  ), onPressed: () {
                  sendSMS();

                  print(otp);

                },),
              )
            ],
          ),
        )
    );

  }
}