import 'dart:convert';
import 'package:fend/classes/Profile.dart';
import 'package:fend/globals.dart' as global;
import 'package:fend/screens/HamburgerMenuOptions/AvatarChoice.dart';
import 'package:fend/screens/mainPage.dart';
import 'package:fend/screens/signUp/SignUpAvatarChoice.dart';
import 'package:http/http.dart';
import 'package:fend/models/student_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialViewProfile extends StatefulWidget {
  @override
  createState() => _SocialViewProfileState();
}

String socialAvatar = 'assets/neutral_girl.png';
String socialName = '';
String socialSid = '';
String socialBranch = '';
String socialYear = '';
String socialSemester = '';
String socialClubs = '';
String socialInsta = '';

class _SocialViewProfileState extends State<SocialViewProfile> {
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
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
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
                        blurRadius: 10,
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage(socialAvatar),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    socialName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: 400,
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 4, spreadRadius: 0)],
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
                        socialSid,
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
                  alignment: Alignment.centerLeft,
                  width: 400,
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 4, spreadRadius: 0)],
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
                        socialBranch,
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
                  width: 400,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 4, spreadRadius: 0)],
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
                        socialYear + ', ' + socialSemester,
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
                  width: 400,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 4, spreadRadius: 0)],
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
                        socialClubs.substring(1, socialClubs.length - 1),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    var url = "https://instagram.com/$socialInsta";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Couldnt launch $socialInsta';
                    }
                  },
                  child: Container(
                    width: 400,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                    margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow(blurRadius: 4, spreadRadius: 0)],
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
                          socialInsta,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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
