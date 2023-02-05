import 'package:database_app/database/student_database.dart';
import 'package:database_app/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  StudentDatabase studentDatabase= StudentDatabase();
  Get.put(studentDatabase.studentDao);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}