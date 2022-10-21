import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flushbar/flushbar.dart';
import 'package:project1/Hospital/HospitalVisitDetails.dart';


class HospitalHomePageWidget extends StatefulWidget {
  const HospitalHomePageWidget({Key? key, required String name}) : super(key: key);

  @override
  State<HospitalHomePageWidget> createState() => _HospitalHomePageWidgetState();
}

class _HospitalHomePageWidgetState extends State<HospitalHomePageWidget> {
  TextEditingController aadharController = TextEditingController();

  var error;
  bool isLoading = true;
  String aadharNo = " ";

  Future<bool> sendSMS() async {
    try {
      String url = 'https://anuragchandra.com/aac_project/Database/ADD/Hospital_add_record.php';

      print(aadharNo);

      final http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'aadharNo': '$aadharNo',
        }),
      );

      setState(() {
        error = jsonDecode(response.body)['error'];
        isLoading = false;
      });

      String message = jsonDecode(response.body)['message'];
      print("error: " + error.toString() + " message: " + message);
      if (error) {
        Flushbar(
          title: "Sign In Error",
          message: message,
          duration: Duration(seconds: 10),
        )
          ..show(context);
        isLoading = false;
      } else {
//        _navigateToSubmitOTP();
      }
    }
    catch (e) {
      var errorMessage = e.toString();
      print(e);
      Flushbar(
        title: "Sign In Error",
        message: errorMessage,
        duration: Duration(seconds: 5),
      )
        ..show(context);
      isLoading = false;
      throw Exception('Could not send SMS');
    }

    return true;
  }

  Widget HospitalAadharNo() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: aadharController,
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Enter Patients Aadhar No',
          //hintText: 'Enter the Name',
        ),
        onChanged: (val2) {
          aadharNo = val2;
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
            title: Text('Hospital Registration')
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              HospitalAadharNo(),
              SizedBox(
                height: 0,
              ),

              new Container(
                padding: const EdgeInsets.only(left: 0.0, top: 30.0),
                child: new ElevatedButton(
                  child: const Text(
                      'Submit', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ), onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HospitalVisitDetails(aadhar: aadharNo)),
                  );
                },
                ),
              )
            ],
          ),
        )
    );
  }
}
