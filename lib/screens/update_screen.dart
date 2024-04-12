import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project2/model/student_model.dart';
import 'package:project2/service/studentservice.dart';

class screen5 extends StatefulWidget {
  final Student student;
  const screen5({super.key, required this.student});

  @override
  State<screen5> createState() => AddUserState();
}

class AddUserState extends State<screen5> {
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
  var studentservice = StudentService();
  @override
  void initState() {
    setState(() {
      userNamecontroller.text = widget.student.name ?? '';
      userRollNumbercontroller.text = widget.student.rollnumber ?? '';
      userAgecontroller.text = widget.student.age ?? '';
      userContactcontroller.text = widget.student.phonenumber ?? '';
      userImagecontroller.text = widget.student.Imagepath ?? '';
    });
    super.initState();
  }

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
                Icon(Icons.edit_document),
                SizedBox(
                  width: 20,
                ),
                Text('REMARKABLE RESULTS'),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Edit Student Detail',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: Column(
                      children: [
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
                              : Text(''),
                        ),
                        IconButton(
                          onPressed: () {
                            pickImgeFromGallery();
                          },
                          icon: Icon(Icons.camera_alt_outlined),
                        ),
                      ],
                    ),
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
                      errorText: validatePhoneNumber
                          ? 'Phone Number Not Found !'
                          : null,
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
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.teal),
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
                            },
                          );
                          if (validateName == false &&
                              validateRollNumber == false &&
                              validateAge == false &&
                              validatePhoneNumber == false &&
                              Imagepath != null) {
                            var student = Student();
                            student.id = widget.student.id;
                            student.name = userNamecontroller.text;
                            student.rollnumber = userRollNumbercontroller.text;
                            student.age = userAgecontroller.text;
                            student.phonenumber = userContactcontroller.text;
                            student.Imagepath = Imagepath;
                            var result =
                                await studentservice.UpdateStudent(student);
                            Navigator.pop(context, result);
                          }
                        },
                        child: Text(
                          'Updated Detials',
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
