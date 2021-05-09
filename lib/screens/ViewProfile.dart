import 'dart:convert';
import 'package:fend/classes/Profile.dart';
import 'package:fend/globals.dart' as global;
import 'package:fend/screens/HamburgerMenuOptions/AvatarChoice.dart';
import 'package:http/http.dart';
import 'package:fend/models/student_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewProfile extends StatefulWidget {
  @override
  _ViewProfileState createState() => _ViewProfileState();
}

String profileAvatar = 'assets/neutral_girl.png';
String profileName = '';
String profileSid = '';
String profileBranch = '';
String profileYear = '';
String profileSemester = '';
String profileClubs = '';
String profileInsta = '';

class _ViewProfileState extends State<ViewProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Container(
            width: 500,
            child: Column(
              children: [
                SizedBox(height: 40),
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        offset: const Offset(
                          0.0,
                          0.0,
                        ),
                        blurRadius: 15.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage(profileAvatar),
                    ),
                  ),
                ),
                Container(
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AvatarChoice())),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    profileName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  decoration: BoxDecoration(
                    color: Color(0xffF0F2F5),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SID',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        profileSid,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  decoration: BoxDecoration(
                    color: Color(0xffF0F2F5),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Branch',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        profileBranch,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  decoration: BoxDecoration(
                    color: Color(0xffF0F2F5),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Year and Semester',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        profileYear + ', ' + profileSemester,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  decoration: BoxDecoration(
                    color: Color(0xffF0F2F5),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Clubs',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        profileClubs.substring(1, profileClubs.length - 1),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  decoration: BoxDecoration(
                    color: Color(0xffF0F2F5),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Insta',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        profileInsta,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
