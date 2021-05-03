import 'dart:convert';
import 'package:alert_dialog/alert_dialog.dart';
import 'package:fend/Databases/SubjectsDB.dart';
import 'package:fend/classes/subjects.dart';
import 'package:fend/globals.dart' as global;

import 'package:fend/models/student_json.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;

import 'SignUpClubs.dart';

class SignUp2 extends StatefulWidget {
  SignUp2State createState() => SignUp2State();
}

class SignUp2State extends State<SignUp2> {
  String searchForSubject;
  List<String> subsList = [];
  List<String> selectedSubsList = [];
  List<String> codesList = [];
  List<String> selectedCodesList = [];

  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Add Subjects',
            style: TextStyle(
              color: Color(0xffCADBE4),
              fontSize: 32,
            ),
          ),
          backgroundColor: Color(0xff588297),
          actions: [
            IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(
                          'Long press the subject name to delete',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Ok',
                              style: TextStyle(
                                color: Color(0xff588297),
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
          child: Form(
            child: ListView(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(),
                    ),
                    hintText: 'Enter Subject Name',
                  ),
                  onChanged: (String value) {
                    setState(() {
                      searchForSubject = value;
                      subject();
                    });
                  },
                ),
                //dropDownList(),
                subjectsList(context),
                Container(
                  height: 25,
                ),
                Center(
                  child: Text(
                    'SELECTED SUBJECTS',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xff235790),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                selectedSubjectsList(context),
                confirmSubjectsButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  subject() async {
    var response = await get(
        Uri.parse('${global.url}/subject/search?query=$searchForSubject'));
    var rb = response.body;

    var list = json.decode(rb) as List;

    List<Subjects> mySubjects = list.map((i) => Subjects.fromJson(i)).toList();

    setState(() {
      subsList.clear();
      codesList.clear();
      for (int i = 0; i < mySubjects.length; i++) {
        subsList.add(mySubjects[i].subject);
        codesList.add(mySubjects[i].subCode);
      }
    });
  }

  subjectsList(context) {
    return Container(
      height: 200,
      child: new ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedSubsList.add(subsList[index]);
                selectedCodesList.add(codesList[index]);
              });
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xffCADBE4),
                ),
                height: 50,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        subsList[index],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff588297),
                        ),
                      ),
                      Text(
                        codesList[index],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff588297),
                        ),
                      ),
                    ]),
              ),
            ),
          );
        },
        itemCount: subsList.length,
      ),
    );
  }

  selectedSubjectsList(context) {
    return Container(
      height: 200,
      child: new ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () {
              setState(() {
                int flag = 0;
                for (int i = 0; i < selectedSubsList.length; i++) {
                  if (subsList[index] == selectedSubsList[i]) {
                    flag = 1;
                    break;
                  }
                }
                if (flag == 0) {
                  selectedSubsList.add(subsList[index]);
                  selectedCodesList.add(codesList[index]);
                } else
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('${subsList[index]} already added')));
              });
            },
            child: Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.circle,
                          color: Color(0xff588297),
                        ),
                      ),
                      TextSpan(
                        text: '  ' +
                            selectedSubsList[index] +
                            ' ' +
                            selectedCodesList[index],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )),
          );
        },
        itemCount: selectedSubsList.length,
      ),
    );
  }

  confirmSubjectsButton() {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
          onPressed: () async {
            var subjectHelper = SubjectDatabase.instance;
            for (int i = 0; i < selectedSubsList.length; i++) {
              Subject subject = Subject(id: i, subject: selectedSubsList[i]);
              subjectHelper.addSubject(subject);
            }
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => SignUp3()));
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return Color(0xffE28F22); // Use the component's default.
              },
            ),
          ),
          child: Text('Confirm Subjects')),
    );
  }
}
