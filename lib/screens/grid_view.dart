import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project2/model/student_model.dart';
import 'package:project2/screens/students_details.dart';
import 'package:project2/service/studentservice.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Student> studentList = [];
  final StudentService studentService = StudentService();

  getAllStudentService() async {
    var students = await studentService.readAllStudents();
    List<Student> tempStudentList = [];

    students.forEach((studentData) {
      setState(() {
        var studentModal = Student();
        studentModal.id = studentData['id'];
        studentModal.name = studentData['name'];
        studentModal.rollnumber = studentData['rollnumber'];
        studentModal.age = studentData['age'];
        studentModal.phonenumber = studentData['phonenumber'];
        studentModal.Imagepath = studentData['Imagepath'];
        tempStudentList.add(studentModal);
      });
    });

    setState(() {
      studentList = tempStudentList;
    });
  }

  @override
  void initState() {
    getAllStudentService();
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
        body: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(1),
                spreadRadius: 20,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: studentList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => screen4(
                              student: studentList[index],
                            ),
                          ),
                        );
                      },
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: CircleAvatar(
                          radius: 20, // Adjust the size of the CircleAvatar
                          backgroundImage: studentList[index].Imagepath !=
                                      null &&
                                  File(studentList[index].Imagepath!)
                                      .existsSync()
                              ? FileImage(File(studentList[index].Imagepath!))
                                  as ImageProvider<Object>?
                              : NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTU2fQ_VCPdrSaseCDEo_dTbhRo7_Kuoz5zQ&usqp=CAU')
                                  as ImageProvider<Object>,
                        ),
                      ),
                      title: Text(
                        studentList[index].name ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      subtitle: Text(
                        studentList[index].phonenumber ?? '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
