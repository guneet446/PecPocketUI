import 'dart:convert';
import 'package:alert_dialog/alert_dialog.dart';
import 'package:fend/Databases/SubjectsDB.dart';
import 'package:fend/classes/subjects.dart';
import 'package:fend/globals.dart' as global;
import 'package:fend/models/student_json.dart';
import 'package:fend/screens/HamburgerMenu.dart';
import 'package:fend/screens/HamburgerMenuOptions/AddClubs.dart';
import 'package:fend/screens/StudyMaterial/StudyMaterial0.dart';
import 'package:fend/screens/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'dart:math';

class AddSubjects extends StatefulWidget {
  @override
  _AddSubjectsState createState() => _AddSubjectsState();
}

List<String> selectedSubsList = [];
List<String> selectedCodesList = [];

class _AddSubjectsState extends State<AddSubjects> {
  String searchForSubject;

  List<String> subsList = [];

  List<String> codesList = [];

  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.info_outline,
                color: Colors.black,
              ),
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
              children: [
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
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
                ),
                SizedBox(height: 10),
                //dropDownList(),
                subjectsList(context),
                Container(
                  height: 20,
                ),

                Text(
                  'Your Subjects',
                  style: GoogleFonts.exo2(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20),
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

    if (searchForSubject.length == 0) {
      setState(() {
        subsList.clear();
        codesList.clear();
      });
    } else {
      setState(() {
        subsList.clear();
        codesList.clear();
        for (int i = 0; i < mySubjects.length; i++) {
          subsList.add(mySubjects[i].subject);
          codesList.add(mySubjects[i].subCode);
        }
      });
    }
  }

  subjectsList(context) {
    return Container(
      height: 280,
      child: new ListView.builder(
        scrollDirection: Axis.vertical,
        //shrinkWrap: true,
        itemBuilder: (context, index) {
          if (searchForSubject == '') {
            subsList.clear();
            codesList.clear();
          }
          return GestureDetector(
            onTap: () {
              setState(() {
                int flag = 0;
                for (int i = 0; i < selectedSubsList.length; i++) {
                  if (subsList[index] == selectedSubsList[i]) {
                    flag = 1;
                    break;
                  }
                }
                if (flag == 0) {
                  selectedSubsList.insert(0, subsList[index]);
                  selectedCodesList.insert(0, codesList[index]);
                } else
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('${subsList[index]} already added')));
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 350,
                  height: 60,
                  padding: EdgeInsets.only(left: 20, top: 10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(1, 1)),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Text(
                        subsList[index],
                        style: GoogleFonts.exo2(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 2),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        },
        itemCount: subsList.length,
      ),
    );
  }

  selectedSubjectsList(context) {
    return Container(
      height: 130,
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Row(
            children: [
              GestureDetector(
                onLongPress: () {
                  setState(() {
                    selectedSubsList.removeAt(index);
                    selectedCodesList.removeAt(index);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Color(colorChoices[index]),
                  ),
                  width: 115,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          selectedSubsList[index],
                          style: GoogleFonts.exo2(
                              color: Colors.white,
                              fontSize: selectedSubsList[index].length > 30
                                  ? 12
                                  : 15),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10)
            ],
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
            var databaseSubjects = await subjectHelper.getAllSubjects();
            int initialSubjectsLength = databaseSubjects.length;
            for (int i = 0;
                i < selectedSubsList.length - initialSubjectsLength;
                i++) {
              Subject subject = Subject(id: i, subject: selectedSubsList[i]);
              subjectHelper.addSubject(subject);
            }

            Navigator.pop(context);
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

  int getRandomElement(List<int> colorChoices) {
    final random = new Random();
    var i = random.nextInt(colorChoices.length);
    return colorChoices[i];
  }
}
