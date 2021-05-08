import 'package:alert_dialog/alert_dialog.dart';
import 'package:fend/Databases/SubjectsDB.dart';
import 'package:fend/screens/HamburgerMenuOptions/AddSubjects.dart';
import 'package:fend/widgets/bottomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../HamburgerMenu.dart';

class EditSubjects extends StatefulWidget {
  String title;
  EditSubjects({this.title});

  @override
  _EditSubjectsState createState() => _EditSubjectsState();
}

List<String> currentSubjects = [];

class _EditSubjectsState extends State<EditSubjects> {
  void initState() {
    super.initState();
  }

  String subtitle = 'YOUR SUBJECTS';

  @override
  Widget build(BuildContext context) {
    if (currentSubjects.length == 0) {
      setState(() {
        subtitle = 'CHOOSE YOUR SUBJECTS';
      });
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            color: Colors.black,
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
      body: Center(
        child: Container(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 30),
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xff235790),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: new ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: currentSubjects.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: GestureDetector(
                          onLongPress: () {
                            var dbHelper = SubjectDatabase.instance;
                            dbHelper.deleteSubject(currentSubjects[index]);
                            setState(() {
                              currentSubjects.removeAt(index);
                            });
                          },
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: 350,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    currentSubjects[index],
                                    style: GoogleFonts.exo2(
                                        textStyle: TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddSubjects()));
                  });
                },
                child: Text('Add Subjects'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Color(0xffE28F22); // Use the component's default.
                    },
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  void updateCurrentSubjects() async {
    var subjectHelper = SubjectDatabase.instance;
    var databaseSubjects = await subjectHelper.getAllSubjects();
    setState(() {
      currentSubjects.clear();
      for (int i = 0; i < databaseSubjects.length; i++) {
        currentSubjects.add(databaseSubjects[i].subject);
      }
    });
  }
}
