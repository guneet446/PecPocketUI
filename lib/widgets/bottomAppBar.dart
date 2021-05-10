import 'dart:convert';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:fend/Databases/AttendanceDB.dart';
import 'package:fend/Databases/SubjectsDB.dart';
import 'package:fend/Databases/TimetableDB.dart';
import 'package:fend/models/student_json.dart';
import 'package:fend/screens/HamburgerMenuOptions/AvatarChoice.dart';
import 'package:fend/screens/StudyMaterial/StudyMaterial0.dart';
import 'package:http/http.dart';
import '../screens/TimeTable.dart';
import 'package:fend/classes/subjects.dart';
import 'package:fend/models/subjectAttendanceDetails.dart';
import 'package:fend/screens/PecSocial/PecSocial.dart';
import 'package:fend/screens/TimeTable.dart';
import 'package:fend/screens/attendance.dart';
import 'package:fend/screens/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:fend/globals.dart' as global;

// ignore: camel_case_types
class bottomAppBar extends StatefulWidget {
  @override
  bottomAppBarState createState() => bottomAppBarState();
}

// ignore: camel_case_types
class bottomAppBarState extends State<bottomAppBar> {
  final iconList = <IconData>[
    Icons.class__rounded,
    Icons.search,
    Icons.list_alt_rounded,
    Icons.timelapse_sharp,
  ];
  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      itemCount: iconList.length,
      tabBuilder: (int index, bool isActive) {
        final color = isActive ? Colors.teal : Colors.teal[200];
        return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                size: 30,
                color: color,
              ),
              const SizedBox(height: 4),
            ]);
      },
      backgroundColor: Color(0xffF0F2F5),
      activeIndex: bottomNavIndex,
      notchSmoothness: NotchSmoothness.defaultEdge,
      gapLocation: GapLocation.center,
      leftCornerRadius: 20,
      rightCornerRadius: 20,
      onTap: (index) async {
        setState(() {
          bottomNavIndex = index;
        });
        switch (bottomNavIndex) {
          case 0:
            goToStudyMaterialPage();
            break;
          case 1:
            goToPecSocial();
            break;
          case 2:
            goToAttendance();
            break;
          case 3:
            goToTimeTable();
            break;
        }
      },
    );
  }

  goToStudyMaterialPage() async {
    int size = await updateSubjectsList();
    setState(() {
      print(subjectsList.length);
      if (size == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => StudyMaterial0()));
      }
    });
  }

  studyMaterial() {
    return IconButton(
      icon: Icon(Icons.menu_book),
      color: Color(0xffCADBE4),
      iconSize: 30.0,
      onPressed: goToStudyMaterialPage,
    );
  }

  pecSocial() {
    return IconButton(
      icon: Icon(Icons.search),
      color: Color(0xffCADBE4),
      iconSize: 30.0,
      onPressed: goToPecSocial,
      padding: EdgeInsets.only(left: 50.0),
    );
  }

  goToPecSocial() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PecSocial()),
      );
    });
  }

  mainpage() {
    return IconButton(
      icon: Icon(Icons.home_outlined),
      color: Color(0xffCADBE4),
      iconSize: 30,
      padding: EdgeInsets.only(left: 50.0),
      onPressed: goToMainPage,
    );
  }

  goToMainPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainPage()));
  }

  attendance() {
    return IconButton(
      icon: Icon(Icons.check_box_outlined),
      color: Color(0xffCADBE4),
      iconSize: 30,
      padding: EdgeInsets.only(left: 50.0),
      onPressed: goToAttendance,
    );
  }

  goToAttendance() async {
    var subjectHelper = SubjectDatabase.instance;
    List<Subject> databaseSubjects = await subjectHelper.getAllSubjects();
    int size = subjectList.length;
    int sizeAttendance = subjects.length;
    print(subjects.length);
    var attendanceHelper = AttendanceDatabase.instance;
    var databaseAttendances = await attendanceHelper.getAllAttendance();
    setState(() {
      if (size == 1) {
        for (int i = 0; i < databaseSubjects.length; i++) {
          subjectList.add(databaseSubjects[i].subject);
        }
      } else {
        subjectList.removeRange(1, subjectList.length - 1);
        for (int i = 0; i < databaseSubjects.length; i++) {
          subjectList.add(databaseSubjects[i].subject);
        }
      }

      if (sizeAttendance == 0) {
        for (int i = 0; i < databaseAttendances.length; i++) {
          SubjectAttendanceDetails subjectAttendanceDetails =
              SubjectAttendanceDetails(
                  databaseAttendances[i].subject,
                  databaseAttendances[i].subtitle,
                  databaseAttendances[i].classesAttended,
                  databaseAttendances[i].totalClasses);

          subjects.add(subjectAttendanceDetails);
        }
      }

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Attendance()));
    });
    var allAttendances = await attendanceHelper.getAllAttendance();
    /* for (int i = 0; i < allAttendances.length; i++) {
                print(allAttendances[i].subject);
                print(allAttendances[i].subtitle);
                print(allAttendances[i].classesAttended);
                print(allAttendances[i].totalClasses);
              }*/
  }

  Future<int> updateSubjectsList() async {
    subjectsList.clear();
    var subjectsHelper = SubjectDatabase.instance;
    List<Subject> databaseSubjects = await subjectsHelper.getAllSubjects();
    for (int i = 0; i < databaseSubjects.length; i++) {
      subjectsList.add(databaseSubjects[i].subject);
      var response = await get(Uri.parse(
          '${global.url}/subject/search?query=${databaseSubjects[i].subject}'));
      Subjects subject = Subjects.fromJson(json.decode(response.body));
      studyMaterialCodesList.add(subject.subject[i]);
    }
    print(subjectsList.length);
    return subjectsList.length;
  }

  goToTimeTable() async {
    var timetableHelper = TimetableDatabase.instance;
    var databaseTimetables = await timetableHelper.getAllTimetables();
    var subjectHelper = SubjectDatabase.instance;
    var databaseSubjects = await subjectHelper.getAllSubjects();
    setState(() {
      meetings.clear();
      for (int i = 0; i < databaseTimetables.length; i++) {
        DateTime from_dt = DateTime(
            databaseTimetables[i].startYear,
            databaseTimetables[i].startMonth,
            databaseTimetables[i].startDay,
            databaseTimetables[i].startHour,
            databaseTimetables[i].startMinute);
        DateTime till_dt = DateTime(
            databaseTimetables[i].endYear,
            databaseTimetables[i].endMonth,
            databaseTimetables[i].endDay,
            databaseTimetables[i].endHour,
            databaseTimetables[i].endMinute);
        meetings.add(Meeting(
            databaseTimetables[i].title,
            from_dt,
            till_dt,
            Color(colorChoices[i]),
            false,
            'FREQ=DAILY;INTERVAL=${databaseTimetables[i].interval}'));
      }
    });
    if (timetableSubjectsList.length == 1) {
      setState(() {
        for (int i = 0; i < databaseSubjects.length; i++) {
          timetableSubjectsList.add(databaseSubjects[i].subject);
        }
      });
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TimeTable()));
  }
}
