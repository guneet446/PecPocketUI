import 'dart:convert';
import 'dart:math';
import 'package:alert_dialog/alert_dialog.dart';
import 'package:fend/Databases/ClubsDB.dart';
import 'package:fend/Databases/UserDB.dart';
import 'package:fend/EntryPoint.dart';
import 'package:fend/classes/Clubs.dart';
import 'package:fend/models/student_json.dart';
import 'package:fend/screens/StudyMaterial/StudyMaterial0.dart';
import 'package:fend/screens/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:fend/globals.dart' as global;
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' show Response, get, post;
import 'package:http/http.dart' as http;

class SignUpClubs extends StatefulWidget {
  String title;
  SignUpClubs({this.title});

  createState() {
    return SignUpClubsState();
  }
}

List<String> clubslist = [];
List<String> clubCodesList = [];
List<String> selectedclubsList = [];
List<String> selectedclubCodesList = [];

class SignUpClubsState extends State<SignUpClubs> {
  String searchForClub;

  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
          child: Form(
              child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(),
                  ),
                  hintText: 'Enter Club Name',
                ),
                onChanged: (String value) {
                  setState(() {
                    searchForClub = value;
                    club();
                  });
                },
              ),
              //dropDownList(),
              clubsList(context),
              Container(
                margin: EdgeInsets.only(top: 10.0),
              ),

              Text(
                'Your Clubs',
                style: GoogleFonts.exo2(
                  textStyle: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              selectedClubsList(context),
              confirmClubsButton(),
            ],
          )),
        ),
      ),
    );
  }

  club() async {
    var response =
        await get(Uri.parse('${global.url}/club/search?query=$searchForClub'));
    var rb = response.body;

    var list = json.decode(rb) as List;

    List<Clubs> myClubs = list.map((i) => Clubs.fromJson(i)).toList();

    if (searchForClub.length == 0) {
      setState(() {
        clubslist.clear();
        clubCodesList.clear();
      });
    } else {
      setState(() {
        clubslist.clear();
        clubCodesList.clear();
        for (int i = 0; i < myClubs.length; i++) {
          clubslist.add(myClubs[i].club);
          clubCodesList.add(myClubs[i].clubCode);
        }
      });
    }
  }

  clubsList(context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: new ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(height: 7.5),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedclubsList.insert(0, clubslist[index]);
                    selectedclubCodesList.insert(0, clubCodesList[index]);
                  });
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7.5)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 2,
                            color: Colors.grey,
                            offset: Offset(1, 1))
                      ],
                    ),
                    child: Center(
                      child: Text(clubslist[index],
                          style: GoogleFonts.exo2(
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        itemCount: clubslist.length,
      ),
    );
  }

  selectedClubsList(context) {
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
                    selectedclubsList.removeAt(index);
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
                      SizedBox(height: 50),
                      Center(
                        child: Text(
                          selectedclubsList[index],
                          style: GoogleFonts.exo2(
                              color: Colors.white,
                              fontSize: selectedclubsList[index].length > 30
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
        itemCount: selectedclubsList.length,
      ),
    );
  }

  confirmClubsButton() {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
          onPressed: () async {
            var clubHelper = ClubDatabase.instance;
            List<Club> databaseClubs = await clubHelper.getAllClubs();
            int initialClubLength = databaseClubs.length;
            for (int i = 0;
                i < selectedclubsList.length - initialClubLength;
                i++) {
              Club club = Club(
                  id: 0,
                  club: selectedclubsList[i],
                  clubCode: selectedclubCodesList[i]);
              clubHelper.addClub(club);
            }
            setState(() {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => EntryPoint()));
            });
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return Color(0xffE28F22); // Use the component's default.
              },
            ),
          ),
          child: Text('Confirm Clubs')),
    );
  }

  int getRandomElement(List<int> colorChoices) {
    final random = new Random();
    var i = random.nextInt(colorChoices.length);
    return colorChoices[i];
  }
}
