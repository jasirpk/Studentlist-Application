import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project2/screen3.dart';
import 'package:project2/service/studentservice.dart';

class screen2 extends StatefulWidget {
  const screen2({Key? key}) : super(key: key);

  @override
  State<screen2> createState() => AddUserState();
}

class AddUserState extends State<screen2> {
  File? selectedImage;
  String? Imagepath;
  var userNamecontroller = TextEditingController();

  var userContactcontroller = TextEditingController();

  var userAgecontroller = TextEditingController();

  var userRollNumbercontroller = TextEditingController();
  var userImagecontroller = TextEditingController();

  bool validateName = false;
  bool validateRollNumber = false;
  bool validateAge = false;
  bool validatePhoneNumber = false;
  bool validateImage = false;
  var studentservice = StudentService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 83, 64, 112),
            centerTitle: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            elevation: 90,
            title: Row(
              children: [
                Icon(Icons.feed),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'REMARKABLE RESULTS',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Add Student Detail',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 180,
                  width: 140,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/picture.png'),
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: selectedImage != null
                      ? Image.file(
                          selectedImage!,
                          fit: BoxFit.cover,
                        )
                      : Text(
                          'Click  Pic  In  Camera',
                          style: TextStyle(color: Colors.blue),
                        ),
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        pickImgeFromGallery();
                      },
                      icon: Icon(
                        Icons.camera_alt_outlined,
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: userNamecontroller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Name',
                    errorText: validateName ? 'Name Not Found !' : null,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: userRollNumbercontroller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.pin),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Roll Number',
                    errorText:
                        validateRollNumber ? 'Roll Number Not Found !' : null,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: userAgecontroller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.calendar_month),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Age',
                    errorText: validateAge ? 'Age Not Found !' : null,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: userContactcontroller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.contacts),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Phone Number',
                    errorText:
                        validatePhoneNumber ? 'Phone Number Not Found !' : null,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        backgroundColor: MaterialStatePropertyAll(Colors.teal),
                      ),
                      onPressed: () async {
                        setState(
                          () {
                            userNamecontroller.text.isEmpty
                                ? validateName = true
                                : validateName = false;
                            userRollNumbercontroller.text.isEmpty
                                ? validateRollNumber = true
                                : validateRollNumber = false;
                            userAgecontroller.text.isEmpty
                                ? validateAge = true
                                : validateAge = false;
                            userContactcontroller.text.isEmpty
                                ? validatePhoneNumber = true
                                : validatePhoneNumber = false;
                            userImagecontroller.text.isEmpty
                                ? validateImage = true
                                : validateImage = false;
                          },
                        );
                        if (validateName == false &&
                            validateRollNumber == false &&
                            validateAge == false &&
                            validatePhoneNumber == false &&
                            Imagepath != null) {
                          var student = Student();
                          student.name = userNamecontroller.text;
                          student.rollnumber = userRollNumbercontroller.text;
                          student.age = userAgecontroller.text;
                          student.phonenumber = userContactcontroller.text;
                          student.Imagepath = Imagepath;
                          var result =
                              await studentservice.SaveStudent(student);
                          Navigator.pop(context, result);
                        }
                      },
                      child: Text(
                        'Save Detials',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        backgroundColor: MaterialStatePropertyAll(Colors.red),
                      ),
                      onPressed: () {
                        userNamecontroller.text = '';
                        userContactcontroller.text = '';
                        userAgecontroller.text = '';
                        userRollNumbercontroller.text = '';
                      },
                      child: Text(
                        'Clear',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickImgeFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) {
      return;
    }
    setState(
      () {
        selectedImage = File(returnImage.path);
        Imagepath = returnImage.path.toString();
      },
    );
  }
}
