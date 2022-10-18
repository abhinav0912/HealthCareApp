import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project1/Patient/PatientHomePage.dart';
import 'package:http/http.dart' as http;
import 'package:flushbar/flushbar.dart';
import 'package:project1/Patient/PatientOtpPage.dart';

class PatientRegistrationWidget extends StatefulWidget {
  const PatientRegistrationWidget({Key? key}) : super(key: key);

  @override
  State<PatientRegistrationWidget> createState() => _PatientRegistrationWidgetState();
}

class _PatientRegistrationWidgetState extends State<PatientRegistrationWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController eNameController = TextEditingController();
  TextEditingController ePhoneController = TextEditingController();

  var error;
  bool isLoading = true;
  String name = " ";
  String aadharNo = " ";
  String phoneNo = " ";
  String emailId = " ";
  String gender = " ";
  String address = " ";
  String dob = " ";
  String eName = " ";
  String ePhoneNo = " ";


  Future<bool> sendSMS() async {

    try {

      String url = 'https://anuragchandra.com/aac_project/Database/ADD/patient_add_record.php';

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
          'dob': '$dob',
          'address': '$address',
          'aadharNo': '$aadharNo',
          'gender': '$gender',
          'emergencyName': '$eName',
          'emergencyNo': '$ePhoneNo',
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


  Widget patientName(){
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: nameController,
        keyboardType: TextInputType.name,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Patient Name',
          //hintText: 'Enter the Name',
        ),
        onChanged: (val1) {
          name = val1;
        },
      ),
    );
  }

  Widget patientAadharNo(){
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: aadharController,
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Aadhar No',
          //hintText: 'Enter the Name',
        ),
        onChanged: (val2) {
          aadharNo = val2;
        },
      ),
    );
  }

  Widget patientPhoneNo(){
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


  Widget patientEmailId(){
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: emailIdController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Email Id',
          //hintText: 'Enter the Name',
        ),
        onChanged: (val3) {
          emailId = val3;
        },
      ),
    );
  }

  Widget patientGender(){
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: genderController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Gender',
          //hintText: 'Enter the Name',
        ),
        onChanged: (val4) {
          gender = val4;
        },
      ),
    );
  }

  Widget patientAddress(){
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

  Widget patientdob(){
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: dobController,
        keyboardType: TextInputType.datetime,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'DOB',
          hintText: 'YYYY-MM-DD',
        ),
        onChanged: (val6) {
          dob = val6;
        },
      ),
    );
  }

  Widget patientEname(){
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: eNameController,
        keyboardType: TextInputType.name,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Emergency Name',
          //hintText: 'Enter the Name',
        ),
        onChanged: (val7) {
          eName = val7;
        },
      ),
    );
  }

  Widget patientEPhoneNo(){
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: ePhoneController,
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Emergency Phone No',
          //hintText: 'Enter the Name',
        ),
        onChanged: (val8) {
          ePhoneNo = val8;
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
          title: Text('Patient Registration')
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            patientName(),
            patientAadharNo(),
            patientPhoneNo(),
            patientEmailId(),
            patientAddress(),
            patientdob(),
            patientGender(),
            patientEname(),
            patientEPhoneNo(),

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  otpPageWidget(aadhar:aadharNo)),
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
