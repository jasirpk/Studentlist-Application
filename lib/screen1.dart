import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project2/editscreen5.dart';
import 'package:project2/gridscreen.dart';
import 'package:project2/screen2.dart';
import 'package:project2/screen3.dart';
import 'package:project2/screen4.dart';
import 'package:project2/service/studentservice.dart';

class screen1 extends StatefulWidget {
  const screen1({super.key});
  @override
  State<screen1> createState() => screen1State();
}

class screen1State extends State<screen1> {
  TextEditingController searchController = TextEditingController();
  List<Student> studentList = [];
  final StudentService studentService = StudentService();

  List<Student> allStudents = [];
  void getAllStudentDetails() async {
    var students = await studentService.readAllStudents();

    List<Student> tempStudentList = [];

    students.forEach((studentData) {
      var studentModal = Student();
      studentModal.id = studentData['id'];
      studentModal.name = studentData['name'];
      studentModal.rollnumber = studentData['rollnumber'];
      studentModal.age = studentData['age'];
      studentModal.phonenumber = studentData['phonenumber'];
      studentModal.Imagepath = studentData['Imagepath'];
      tempStudentList.add(studentModal);
    });

    setState(() {
      studentList = List.from(tempStudentList);
      allStudents = List.from(tempStudentList);
    });
  }

  @override
  void initState() {
    getAllStudentDetails();
    super.initState();
  }

  showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.blue,
        content: Text(message),
      ),
    );
  }

  deleteFormDialog(BuildContext context, studentId) {
    return showDialog(
      context: context,
      builder: (param) {
        return AlertDialog(
          title: Text('Are You Sure to Delete?'),
          actions: [
            TextButton(
              onPressed: () async {
                var result = await studentService.deleteUser(studentId);
                if (result != null) {
                  Navigator.of(context).pop();
                  getAllStudentDetails();
                  showSuccessSnackBar('Student Detail Delete Successfully');
                }
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void runfilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      setState(() {
        studentList = List.from(allStudents);
      });
    } else {
      List<Student> results = allStudents
          .where((student) =>
              student.name
                  ?.toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ??
              false)
          .toList();
      setState(
        () {
          studentList = results;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return screen2();
                },
              ),
            ).then(
              (data) {
                if (data != null) {
                  getAllStudentDetails();
                  showSuccessSnackBar('Student Deatail are Recorded');
                }
              },
            );
          },
          child: Icon(Icons.add),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 83, 64, 112),
            centerTitle: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            title: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.home),
                    ),
                    Text(
                      " SQFLITE ",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  width: 200,
                  child: TextField(
                    onChanged: (value) => runfilter(value),
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 159, 13, 13)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListView.builder(
              itemCount: studentList.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'LIST VIEW IN GRID...',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) {
                                  return MyApp();
                                },
                              ),
                            );
                          },
                          icon: Icon(Icons.grid_view),
                        ),
                      ],
                    ),
                  );
                }
                return Card(
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
                    leading: CircleAvatar(
                      backgroundImage: studentList[index].Imagepath != null &&
                              File(studentList[index].Imagepath!).existsSync()
                          ? FileImage(File(studentList[index].Imagepath!))
                              as ImageProvider<Object>?
                          : NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTU2fQ_VCPdrSaseCDEo_dTbhRo7_Kuoz5zQ&usqp=CAU')
                              as ImageProvider<Object>,
                    ),
                    title: Text(studentList[index].name ?? ''),
                    subtitle: Text(studentList[index].phonenumber ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => screen5(
                                  student: studentList[index],
                                ),
                              ),
                            ).then(
                              (data) {
                                if (data != null) {
                                  getAllStudentDetails();
                                  showSuccessSnackBar(
                                      'Student Deatail Updated Successfully');
                                }
                              },
                            );
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.teal,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteFormDialog(context, studentList[index].id);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        )
                      ],
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
