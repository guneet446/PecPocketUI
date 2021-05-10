import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'package:fend/models/student_json.dart';
import 'package:fend/screens/HamburgerMenu.dart';
import 'package:fend/screens/mainPage.dart';
import 'package:fend/widgets/attendanceCard.dart';
import 'package:fend/widgets/bottomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:fend/globals.dart' as global;

class PecSocial extends StatefulWidget {
  final Animation<double> transitionAnimation;
  const PecSocial({Key key, this.transitionAnimation}) : super(key: key);
  @override
  _PecSocialState createState() => _PecSocialState();
}

class _PecSocialState extends State<PecSocial>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  bool isPlaying = false;
  var key = GlobalKey<ScaffoldState>();
  List<String> avatars = [
    'assets/1.png',
    'assets/2.png',
    'assets/3.png',
    'assets/4.png',
    'assets/5.png',
    'assets/6.png',
    'assets/7.png',
    'assets/8.png',
    'assets/9.png',
    'assets/10.png',
    'assets/11.png',
    'assets/12.png',
    'assets/13.png',
    'assets/14.png',
    'assets/15.png',
    'assets/16.png',
    'assets/17.png',
    'assets/18.png',
    'assets/19.png',
    'assets/20.png',
    'assets/21.png',
    'assets/22.png',
    'assets/23.png',
    'assets/24.png',
    'assets/25.png',
    'assets/26.png',
    'assets/27.png',
    'assets/28.png',
    'assets/29.png',
    'assets/30.png',
    'assets/31.png',
    'assets/31.png',
    'assets/33.png',
    'assets/34.png',
    'assets/35.png',
    'assets/36.png',
    'assets/37.png',
    'assets/38.png',
    'assets/39.png',
    'assets/40.png',
    'assets/41.png',
    'assets/42.png',
    'assets/43.png',
    'assets/44.png',
    'assets/45.png',
    'assets/46.png',
    'assets/47.png',
    'assets/48.png',
    'assets/49.png',
    'assets/50.png',
    'assets/51.png',
    'assets/52.png',
    'assets/53.png',
    'assets/54.png',
    'assets/55.png',
    'assets/56.png',
    'assets/neutral_guy.png',
    'assets/neutral_girl.png'
  ];
  String searchFor;
  List<String> names = [];
  List<String> sids = [];
  //default index of a first screen

  Animation<double> animation;
  CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Color(0xffF0F2F5),
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  icon: AnimatedIcon(
                    color: Colors.black,
                    icon: AnimatedIcons.menu_close,
                    progress: animationController,
                  ),
                  onPressed: () => handleOnPressed(),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 25, bottom: 20),
              height: 85,
              width: 350,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Search here',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(7.5),
                    ),
                    borderSide: BorderSide(color: Colors.grey, width: 0.75),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.5),
                    borderSide:
                        const BorderSide(color: Colors.teal, width: 0.75),
                  ),
                ),
                onChanged: (String value) {
                  searchFor = value;
                  search();
                },
              ),
            ),
            Container(
              child: Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 20),
                  itemCount: names.length ~/ 2,
                  itemBuilder: (context, index) {
                    if (index != 0) index += 1;

                    return Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 20),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(top: 20),
                                        ),
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: AssetImage(avatars[index]),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          names[index],
                                          style: GoogleFonts.exo2(
                                            textStyle: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ), //The names go here
                                        Text(
                                          sids[index],
                                          style: GoogleFonts.exo2(
                                            textStyle: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                        ), //The SIDS go here
                                      ],
                                    ),
                                  ),
                                  height: 160,
                                  margin: EdgeInsets.all(6),
                                  width: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 7,
                                          offset: Offset(-1.0, 1.0))
                                    ],
                                    color: Color(
                                        getRandomListElement(colorChoices)),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 7.5),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(top: 20),
                                        ),
                                        Container(
                                          width: 90,
                                          height: 90,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  avatars[index + 10]),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          names[index + 1],
                                          style: GoogleFonts.exo2(
                                            textStyle: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ), //The names go here
                                        Text(
                                          sids[index + 1],
                                          style: GoogleFonts.exo2(
                                            textStyle: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                        ), //The SIDS go here
                                      ],
                                    ),
                                  ),
                                  height: 160,
                                  margin: EdgeInsets.all(6),
                                  width: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 7,
                                          offset: Offset(1.0, 1.0))
                                    ],
                                    color: Color(
                                        getRandomListElement(colorChoices)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 7.5),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomAppBar(),
      drawer: Settings(),
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
    );
  }

  void search() async {
    if (searchFor.length == 0) {
      setState(() {
        names.clear();
        sids.clear();
      });
    } else {
      names.clear();
      sids.clear();
      var response =
          await get(Uri.parse('${global.url}social?query=$searchFor'));

      var socialList = SocialList.fromJson(json.decode(response.body));

      setState(() {
        print(socialList.social[0].name);
        for (int i = 0; i < socialList.social.length; i++) {
          names.add(socialList.social[i].name);
          sids.add(socialList.social[i].sid.toString());
        }
      });
    }
  }

  int getRandomListElement(List<int> colors) {
    var random = new Random();
    var i = random.nextInt(colors.length);
    return colors[i];
  }

  handleOnPressed() async {
    if (!isPlaying) {
      await animationController.forward();
      key.currentState?.openDrawer();
      animationController.reverse();
    }
    setState(() {
      print(isPlaying);
    });
  }
}
