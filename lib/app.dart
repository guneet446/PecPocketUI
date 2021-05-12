import 'package:fend/EntryPoint.dart';
import 'package:fend/screens/attendance.dart';
import 'package:fend/screens/mainPage.dart';
import 'package:fend/screens/signUp/SignUpAvatarChoice.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Attendance(),
      ),
    );
  }
}
