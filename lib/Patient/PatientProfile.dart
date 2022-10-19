import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flushbar/flushbar.dart';
import 'dart:convert';

class PatientProfileWidget extends StatefulWidget {
  String aadhar;
  PatientProfileWidget({Key? key, required this.aadhar}) : super(key: key);

  @override
  State<PatientProfileWidget> createState() => _PatientProfileWidget();
}

/*
class _PatientProfileWidget extends State<PatientProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}
 */

class _PatientProfileWidget extends State<PatientProfileWidget> {

  TextEditingController displayNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  bool isLoading = false;
  String? imageUrl;
  bool showPassword = false;
  String aadharNo = "";
  String emailId = "";
  String name = "";
  String dob = "";
  var error;

  Future<bool> retrievePatientInfo() async {

    print("Aadhaar: " + widget.aadhar);

    try {

      String url = 'https://anuragchandra.com/aac_project/Database/GET/retrieve_patient_info.php';

      final http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'aadharNo': widget.aadhar,
        }),
      );

      setState(() {
        error = jsonDecode(response.body)['error'];
        name = jsonDecode(response.body)['name'];
        dob = jsonDecode(response.body)['dob'];
        emailId = jsonDecode(response.body)['email'];
        print("name = "+name);
      });

      String message = jsonDecode(response.body)['message'];
      print ("error: " + error.toString() + " message: " + message);
      if (error) {
        Flushbar(
          title: "Could not retrieve patient details",
          message: message,
          duration: Duration(seconds: 10),
        )..show(context);
      }
      else {
        displayNameController.text = name;
        ageController.text = dob;
        emailIdController.text = emailId;

        Flushbar(
          title: "Patient details retrieved",
          message: message,
          duration: Duration(seconds: 10),
        )..show(context);
        setState(() {
        });
      }
    }
    catch (e) {
      var errorMessage = e.toString();
      print(e);
      Flushbar(
        title: "Patient info not retrieved",
        message: errorMessage,
        duration: Duration(seconds: 5),
      )..show(context);
      throw Exception('Could not retrieve');
    }
    return true;
  }



  @override
  Widget build(BuildContext context)
  {
    retrievePatientInfo();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.green,
            ),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 4,
                        color: Theme.of(context).scaffoldBackgroundColor),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(0, 10))
                    ],
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                        fit: BoxFit.scaleDown,
                        image: NetworkImage(
                          "https://boysandmachines.com/media/images/Supercar-Ford-Mustang-GT-5.original.jpg",
                          scale: 0.25
                        ))),
              ),
              const SizedBox(
                height: 35,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  hintText: 'Input Name',
                ),
                controller: displayNameController,
                keyboardType: TextInputType.name,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Age",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  hintText: 'Input Age',
                ),
                controller: ageController,
                keyboardType: TextInputType.number,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: "EmailId",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  hintText: 'Email Id',
                ),
                controller: emailIdController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  TextButton(
                    onPressed: () {
                    },
                    child: const Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}