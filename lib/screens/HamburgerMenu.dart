import 'dart:convert';

import 'package:fend/Databases/AttendanceDB.dart';
import 'package:fend/Databases/AvatarDB.dart';
import 'package:fend/Databases/ClubsDB.dart';
import 'package:fend/Databases/SubjectsDB.dart';
import 'package:fend/Databases/TimetableDB.dart';
import 'package:fend/Databases/UserDB.dart';
import 'package:fend/Databases/remindersDB.dart';
import 'package:fend/classes/Clubs.dart';
import 'package:fend/classes/subjects.dart';
import 'package:fend/classes/user.dart';
import 'package:fend/screens/signUp/SignUpPassword.dart';
import 'package:fend/screens/signUp/signUpSID.dart';
import 'package:flutter/material.dart';
import 'package:fend/globals.dart' as global;
import 'package:fend/models/student_json.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'CustomFolder.dart';
import 'HamburgerMenuOptions/AddClubs.dart';
import 'HamburgerMenuOptions/AddSubjects.dart';
import 'HamburgerMenuOptions/AvatarChoice.dart';

import 'login_screen.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String name = "";
  String clubsOption =
      'Add Clubs'; //Change to Edit clubs if clubs have been added already
  String subjectsOption = 'Add Subjects';
  String instagramHandle;
  String newPassword = '';
  @override
  void initState() {
    super.initState();
    getName();
    getClubStatus();
    getSubjectStatus();
    getAvatar();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 30,
      child: Container(
        color: Colors.red,
        child: ListView(
          children: [
            SizedBox(height: 100),
            ListTile(
              title: Text(
                subjectsOption,
                style: GoogleFonts.exo2(
                    textStyle: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              onTap: () async {
                var subjectHelper = SubjectDatabase.instance;
                List<Subject> subjects = await subjectHelper.getAllSubjects();
                selectedSubsList.clear();
                selectedCodesList.clear();
                for (int i = 0; i < subjects.length; i++) {
                  selectedSubsList.add(subjects[i].subject);
                  selectedCodesList.add('');
                }
                setState(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddSubjects()));
                });
              },
            ),
            ListTile(
              title: Text(
                'Add/Update Instagram Handle',
                style: GoogleFonts.exo2(
                    textStyle: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              onTap: () {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'Enter Instagram Handle',
                          style: TextStyle(
                            color: Color(0xff235790),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              onChanged: (String value) {
                                instagramHandle = value;
                              },
                            ),
                            TextButton(
                              onPressed: () async {
                                var userHelper = UserDatabase.instance;
                                var userData = await userHelper.getAllUsers();
                                var jsonMap = {
                                  'SID': userData[0].sid,
                                  'Insta': instagramHandle,
                                };
                                String jsonStr = jsonEncode(jsonMap);
                                var response = await http.put(
                                  Uri.parse(
                                      '${global.url}/insta/${userData[0].sid}'),
                                  body: jsonStr,
                                  headers: {"Content-Type": "application/json"},
                                );
                                setState(() {
                                  print(jsonMap);
                                  print(response.body);
                                  print(response);
                                  Navigator.pop(context);
                                });
                              },
                              child: Text(
                                'Confirm',
                                style: TextStyle(
                                  color: Color(0xffE28F22),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
            ListTile(
              title: Text(
                clubsOption, //Change to Edit clubs if clubs have been added already
                style: GoogleFonts.exo2(
                    textStyle: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              onTap: () async {
                var clubHelper = ClubDatabase.instance;
                List<Club> clubs = await clubHelper.getAllClubs();
                selectedclubsList.clear();
                for (int i = 0; i < clubs.length; i++) {
                  selectedclubsList.add(clubs[i].club);
                }
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddClubs(
                                title: clubsOption,
                              )));
                });
              },
            ),
            SizedBox(height: 200),
            ListTile(
              title: Text(
                'Change Password',
                style: GoogleFonts.exo2(
                    textStyle: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              onTap: () {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'Enter Current Password followed by the new password',
                          style: TextStyle(
                            color: Color(0xff235790),
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              obscureText: true,
                              onChanged: (String value) {
                                confirmPassword = value;
                              },
                            ),
                            TextField(
                              obscureText: true,
                              onChanged: (String value) {
                                newPassword = value;
                              },
                            ),
                            TextButton(
                                onPressed: () async {
                                  var userHelper = UserDatabase.instance;
                                  var userData = await userHelper.getAllUsers();
                                  setState(() {
                                    if (userData[0].password ==
                                        confirmPassword) {
                                      userHelper.deleteTable();
                                      User user = new User(
                                          id: 0,
                                          sid: userData[0].sid,
                                          password: newPassword,
                                          auth: userData[0].auth,
                                          login: 1);
                                      userHelper.addUser(user);
                                      Navigator.pop(context);
                                    }
                                  });
                                },
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Color(0xffE28F22),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))
                          ],
                        ),
                      );
                    });
              },
            ),
            ListTile(
              title: Text(
                'Logout',
                style: GoogleFonts.exo2(
                    textStyle: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              onTap: () async {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'Do you want to Logout?',
                          style: TextStyle(
                            color: Color(0xff235790),
                          ),
                        ),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'No',
                                style: TextStyle(
                                  color: Color(0xffE28F22),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                var userHelper = UserDatabase.instance;
                                var userData = await userHelper.getAllUsers();
                                setState(() {
                                  User user = new User(
                                      id: 0,
                                      sid: userData[0].sid,
                                      password: userData[0].password,
                                      auth: userData[0].auth,
                                      login: 0);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                });
                              },
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                  color: Color(0xffE28F22),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
            ListTile(
              title: Text(
                'Delete Account',
                style: GoogleFonts.exo2(
                    textStyle: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              onTap: () {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'Delete Account?',
                          style: TextStyle(
                            color: Color(0xff235790),
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Enter password',
                              ),
                              onChanged: (String value) {
                                confirmPassword = value;
                              },
                            ),
                            TextButton(
                              onPressed: () async {
                                var avatarHelper = AvatarDatabase.instance;
                                var userHelper = UserDatabase.instance;
                                var databaseUser =
                                    await userHelper.getAllUsers();
                                var attendanceHelper =
                                    AttendanceDatabase.instance;
                                var clubHelper = ClubDatabase.instance;
                                var reminderHelper = ReminderDatabase.instance;
                                var subjectHelper = SubjectDatabase.instance;
                                var timetableHelper =
                                    TimetableDatabase.instance;
                                var userData = await userHelper.getAllUsers();
                                var attendanceData =
                                    await attendanceHelper.getAllAttendance();
                                var clubData = await clubHelper.getAllClubs();
                                var reminderData =
                                    await reminderHelper.getAllReminders();
                                var subjectData =
                                    subjectHelper.getAllSubjects();

                                if (confirmPassword ==
                                    databaseUser[0].password) {
                                  final http.Response response =
                                      await http.delete(
                                    Uri.parse(
                                        '${global.url}/delete/${userData[0].sid}'),
                                    headers: <String, String>{
                                      'Content-Type':
                                          'application/json; charset=UTF-8',
                                    },
                                  );
                                  avatarHelper.deleteTable();
                                  attendanceHelper.deleteTable();
                                  clubHelper.deleteTable();
                                  reminderHelper.deleteTable();
                                  subjectHelper.deleteTable();
                                  timetableHelper.deleteTable();
                                  userHelper.deleteTable();

                                  setState(() {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp1()));
                                  });
                                } else {
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                }
                              },
                              child: Text(
                                'Confirm Password',
                                style: TextStyle(
                                  color: Color(0xffE28F22),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }

  getName() async {
    var userHelper = UserDatabase.instance;
    var databaseUser = await userHelper.getAllUsers();
    var response = await get(
        Uri.parse('${global.url}/viewprofile/${databaseUser[0].sid}'));
    var profileData = Social.fromJson(json.decode(response.body));
    setState(() {
      name = profileData.name;
    });
  }

  getClubStatus() async {
    var clubHelper = ClubDatabase.instance;
    List<Club> clubs = await clubHelper.getAllClubs();
    if (clubs.length != 0) {
      clubsOption = 'Edit Clubs';
    }
  }

  getSubjectStatus() async {
    var subjectHelper = SubjectDatabase.instance;
    List<Subject> subjects = await subjectHelper.getAllSubjects();
    if (subjects.length != 0) {
      subjectsOption = 'Edit Subjects';
    }
  }

  void getAvatar() async {
    var avatarHelper = AvatarDatabase.instance;
    var databaseAvatar = await avatarHelper.getAllavatar();
  }
}
