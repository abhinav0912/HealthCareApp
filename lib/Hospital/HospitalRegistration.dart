import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:project1/Hospital/PatientHomePage.dart';
import 'package:http/http.dart' as http;
import 'package:flushbar/flushbar.dart';

class HospitalRegistrationWidget extends StatefulWidget {
  const HospitalRegistrationWidget({Key? key}) : super(key: key);

  @override
  State<HospitalRegistrationWidget> createState() => _HospitalRegistrationWidgetState();
}

class _HospitalRegistrationWidgetState extends State<HospitalRegistrationWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController hospitalIdController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController diagnosticCenterController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  var error;
  bool isLoading = true;
  String name = " ";
  String hospitalId = " ";
  String phoneNo = " ";
  String emailId = " ";
  String diagnosticCenter = " ";
  String address = " ";

  Future<bool> sendSMS() async {

    try {

      String url = 'https://anuragchandra.com/aac_project/Database/ADD/hospital_add_record.php';

      print(name);

      final http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': '$name',
          'email': '$emailId',
          'phoneNo': '$phoneNo',
          'address': '$address',
          'hospitalId': '$hospitalId',
          'diagnosticCenter': '$diagnosticCenter',
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


  Widget HospitalName(){
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: nameController,
        keyboardType: TextInputType.name,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Hospital Name',
          //hintText: 'Enter the Name',
        ),
        onChanged: (val1) {
          name = val1;
        },
      ),
    );
  }

  Widget HospitalId(){
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: hospitalIdController,
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Hospital Id',
          //hintText: 'Enter the Name',
        ),
        onChanged: (val2) {
          hospitalId = val2;
        },
      ),
    );
  }

  Widget HospitalPhoneNo(){
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: phoneController,
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Phone No',
          //hintText: 'Enter the Name',
        ),
        onChanged: (val3) {
          phoneNo = val3;
        },
      ),
    );
  }


  Widget HospitalemailId(){
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: emailIdController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'EmailId',
          //hintText: 'Enter the Name',
        ),
        onChanged: (val3) {
          emailId = val3;
        },
      ),
    );
  }


  Widget HospitaldiagnosticCenter(){
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: diagnosticCenterController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'diagnosticCenter',
          //hintText: 'Enter the Name',
        ),
        onChanged: (val4) {
          diagnosticCenter = val4;
        },
      ),
    );
  }

  Widget HospitalAddress(){
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: addressController,
        keyboardType: TextInputType.streetAddress,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Address',
          //hintText: 'Enter the Name',
        ),
        onChanged: (val5) {
          address = val5;
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
              HospitalName(),
              HospitalId(),
              HospitalPhoneNo(),
              HospitalAddress(),
              HospitalemailId(),
              HospitaldiagnosticCenter(),

              SizedBox(
                height: 0,
              ),

              new Container(
                padding: const EdgeInsets.only(left: 0.0, top: 30.0),
                child: new ElevatedButton(
                  child: const Text('Submit', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                    shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                  ), onPressed: () {

                  sendSMS();
                  /*
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePageWidget()),
                );

                   */
                  print(name);
                  print(phoneNo);
                  print(hospitalId);
                  print(address);
                  print(emailId);
                  print(diagnosticCenter);
                },),
              )
            ],
          ),
        )
    );

  }
}
