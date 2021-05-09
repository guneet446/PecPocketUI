import 'package:alert_dialog/alert_dialog.dart';
import 'package:fend/Databases/AttendanceDB.dart';
import 'package:fend/screens/HamburgerMenu.dart';
import 'package:fend/widgets/bottomAppBar.dart';
import '../classes/Attendances.dart';
import 'package:fend/classes/CustomFolder.dart';
import 'package:fend/classes/Reminder.dart';
import 'package:fend/models/subjectAttendanceDetails.dart';
import 'package:fend/widgets/attendanceCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fend/globals.dart' as global;

import 'mainPage.dart';

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

List<SubjectAttendanceDetails> subjects = [];
List<String> subjectList = ['Subject'];
List<String> subtitleList = ['Type', 'Lecture', 'Tutorial', 'Lab'];
String subjectName = "Subject";
String subtitle = "Type";

class _AttendanceState extends State<Attendance> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 8,
        backgroundColor: Colors.teal,
        child: Icon(
          Icons.home_filled,
          color: Colors.white,
          size: 35,
        ),
        onPressed: () async {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainPage()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          TextButton(
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              _getSubject(context);
            },
          ),
        ],
      ),
      drawer: Settings(),
      bottomNavigationBar: bottomAppBar(),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          Container(
            //height: 40,
            padding: EdgeInsets.fromLTRB(25, 10, 25, 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Attendance',
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                ),
                Text(
                  'Overall Attendance.....',
                ),
              ],
            ),
          ),
          GridView.builder(
            primary: false,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: subjects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.95,
              //crossAxisSpacing: 30,
              //mainAxisSpacing: 30,
            ),
            itemBuilder: (context, index) {
              return AttendanceCard(
                subject: subjects[index],
                index: index,
              );
            },
          ),
        ],
      ),
    );
  }

  final myController = TextEditingController();

  _getSubject(BuildContext context) async {
    setState(() {});

    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text("Subject"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // for dropdown to open in correct direction go to dropdown.dart and set selectedItemOffset to -40
                  DropdownButton<String>(
                    value: subjectName,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 35,
                    elevation: 16,
                    //style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Color(0xffE28F22),
                    ),
                    isExpanded: true,
                    onChanged: (String newValue) {
                      setState(() {
                        print("Changed");
                        subjectName = newValue;
                      });
                      //_setSubject(newValue);
                    },
                    items: subjectList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),

                  DropdownButton<String>(
                    value: subtitle,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 35,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Color(0xffE28F22),
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        subtitle = newValue;
                      });
                    },
                    items: subtitleList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {});
                      Navigator.pop(context);
                      _setSubject();
                    },
                    child: Text('Submit',
                        style:
                            TextStyle(color: Color(0xff235790), fontSize: 16)),
                  ),
                ],
              ),
            );
          });
        });
  }

  void _setSubject() async {
    var attendanceHelper = AttendanceDatabase.instance;
    var allAttendances = await attendanceHelper.getAllAttendance();
    var latestAttendanceId = allAttendances.length - 1;

    setState(() {
      SubjectAttendanceDetails subjectAttendanceDetails =
          SubjectAttendanceDetails(subjectName, subtitle, 0, 0);
      subjects.add(subjectAttendanceDetails);
      print('HELLLLOOOO ${subjects[subjects.length - 1].percentage}');

      var map = {
        "id": latestAttendanceId,
        "subject": subjectName,
        "subtitle": subtitle,
        "classesAttended": 0,
        "totalClasses": 0,
      };
      Attendances attendances = Attendances.fromJson(map);
      attendanceHelper.addAttendance(attendances);
    });
  }
}
