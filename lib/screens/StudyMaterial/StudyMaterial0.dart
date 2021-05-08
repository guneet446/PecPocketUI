import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:fend/Databases/SubjectsDB.dart';
import 'package:fend/Databases/UserDB.dart';
import 'package:fend/classes/subjects.dart';
import 'package:fend/models/student_json.dart';
import 'package:fend/screens/StudyMaterial/SubjectStudyMaterial.dart';
import 'package:fend/screens/StudyMaterial/SubjectStudyMaterial1.dart';
import 'package:fend/widgets/bottomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:alert_dialog/alert_dialog.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fend/globals.dart' as global;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

import '../HamburgerMenu.dart';

class StudyMaterial0 extends StatefulWidget {
  StudyMaterial0State createState() => StudyMaterial0State();
}

List<String> subjectsList = [];
List<int> colorChoices = [
  0XffFECE48,
  0xff813CA3,
  0xff9A275A,
  0xffD97F30,
  0xff484F70,
  0xff2F3737,
  0xff23356C,
  0xffBDB8B0,
  0xff9F7F7F,
  0xff91C2C4,
  0xff84A59D,
  0xffE47A77,
  0xff6C96C6
];

class StudyMaterial0State extends State<StudyMaterial0> {
  void initState() {
    super.initState();
    //updateSubjectsList();
  }

  File image;
  final picker = ImagePicker();
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      bottomNavigationBar: bottomAppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'Study Material',
              style: TextStyle(
                fontSize: 28,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.0),
            child: GridView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: subjectsList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 150,
              ),
              itemBuilder: (BuildContext context, int index) {
                int backgroundColor = colorChoices[(index + 1) % 13];
                return GestureDetector(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Material(
                          child: Image.asset(
                            'assets/folder.png',
                            scale: 0.8,
                            color: Color(backgroundColor),
                          ),
                          //elevation: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'CSN 102 \n' + subjectsList[index], //add correct subject code here
                              //textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () async {
                      var response = await get(Uri.parse(
                          '${global.url}/subject/search?query=${subjectsList[index]}'));
                      var rb = response.body;

                      var list = json.decode(rb) as List;

                      List<Subjects> mySubjects =
                          list.map((i) => Subjects.fromJson(i)).toList();

                      var userHelper = UserDatabase.instance;
                      var userData = await userHelper.getAllUsers();
                      setState(
                        () {
                          uploadSubject0 = mySubjects[0].subCode;
                          uploadSubject = mySubjects[0].subCode;
                          if (uploadsList0.length != 0) {
                            uploadsList0.clear();
                          }
                          if (uploadsList.length != 0) {
                            uploadsList.clear();
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubjectStudyMaterial1(
                                index: index,
                                subjectColor: backgroundColor,
                              ),
                            ),
                          );
                          /*if (userData[0].auth == 0) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SubjectStudyMaterial(
                                          index: index,
                                          subjectColor: backgroundColor,
                                        )));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SubjectStudyMaterial1(
                                          index: index,
                                          subjectColor: backgroundColor,
                                        ),
                                ),
                            );
                          }*/
                        },
                      );
                    });
              },
            ),
          ),
        ],
      ),
      drawer: Settings(),
    );
  }

  fileChoice() {
    return Container(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: photoUploadGallery,
              child: Text('Upload photo from gallery')),
          ElevatedButton(
              onPressed: photoUploadGallery, child: Text('Upload pdf')),
        ],
      ),
    );
  }

  photoUploadGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        String filename = image.path.split('/').last;

        var request = http.MultipartRequest(
          'POST',
          Uri.parse('${global.url}/upload/$uploadSubject'),
        );

        request.files.add(http.MultipartFile.fromBytes(
            'file', File(image.path).readAsBytesSync(),
            filename: filename));

        sendRequest(request);
      }
    });
  }

  listSubjects() async {
    var dbHelper = SubjectDatabase.instance;
    List<Subject> databaseSubjects = await dbHelper.getAllSubjects();
    for (int i = 0; i < databaseSubjects.length; i++) {}
  }

  void updateSubjectsList() async {
    var subjectsHelper = SubjectDatabase.instance;
    List<Subject> databaseSubjects = await subjectsHelper.getAllSubjects();
    for (int i = 0; i < databaseSubjects.length; i++) {
      subjectsList.add(databaseSubjects[i].subject);
    }
    //print(subjectsList.length);
  }

  void sendRequest(http.MultipartRequest request) async {
    var res = await request.send();
    setState(() {
      print(res);
    });
  }
}
