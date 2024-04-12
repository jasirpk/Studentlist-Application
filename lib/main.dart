import 'package:flutter/material.dart';
import 'package:project2/screens/students_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 93, 4, 237)),
      ),
      debugShowCheckedModeBanner: false,
      home: screen1(),
    );
  }
}
