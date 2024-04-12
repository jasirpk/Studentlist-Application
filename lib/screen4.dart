import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project2/screen3.dart';

class screen4 extends StatefulWidget {
  final Student student;
  const screen4({super.key, required this.student});

  @override
  State<screen4> createState() => _screen4State();
}

class _screen4State extends State<screen4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0), // Customize the height as needed
        child: AppBar(
          elevation: 100,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
          title: Text('Esqflite program'),
          backgroundColor: Colors.teal,
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Text(
                "STUDENT'S PROFILE",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // color: Colors.blueGrey,
                    fontSize: 30),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 45),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 180,
                      width: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.file(
                        File(widget.student.Imagepath ?? ''),
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Name :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                          fontSize: 20),
                    ),
                    Text(
                      widget.student.name ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Roll Number :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                          fontSize: 20),
                    ),
                    Text(
                      widget.student.rollnumber ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Age :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                          fontSize: 20),
                    ),
                    Text(
                      widget.student.age ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Phone Number :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                          fontSize: 20),
                    ),
                    Text(
                      widget.student.phonenumber ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
