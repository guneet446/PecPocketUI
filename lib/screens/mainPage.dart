import 'dart:convert';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:fend/Databases/AvatarDB.dart';
import 'package:fend/Databases/UserDB.dart';
import 'package:fend/Databases/remindersDB.dart';
import 'package:fend/EntryPoint.dart';
import 'package:fend/classes/CustomReminderDetails.dart';
import 'package:fend/classes/NotiClass.dart';
import 'package:fend/classes/Profile.dart';
import 'package:fend/classes/Reminder.dart';
import 'package:fend/models/Notifications.dart';
import 'package:fend/models/student_json.dart';
import 'package:fend/screens/CustomReminders/CustomReminderAddNew.dart';
import 'package:fend/screens/CustomReminders/CustomReminderView.dart';
import 'package:fend/screens/HamburgerMenuOptions/AvatarChoice.dart';
import 'package:fend/screens/ViewProfile.dart';
import 'package:fend/screens/uploadNotification.dart';
import 'package:fend/screens/HamburgerMenu.dart';
import 'package:fend/widgets/attendanceCard.dart';
import 'package:fend/widgets/bottomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:fend/globals.dart' as global;
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class MainPage extends StatefulWidget {
  createState() {
    return MainPageState();
  }
}

String selectedAvatar = 'assets/neutral_guy.png';
int auth;
int reminderLength = customReminders.length;
List<String> mainPageReminders = ['', '', ''];
List<String> mainPageReminderStartTimes = ['', '', ''];
List<String> mainPageReminderEndTimes = ['', '', ''];
List<String> mainPageReminderDescriptions = ['', '', ''];

class MainPageState extends State<MainPage> with TickerProviderStateMixin {
  AnimationController animationController;
  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    updateReminder();
    getAuth();
    updateProfile();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  var key = GlobalKey<ScaffoldState>();
  String deletePassword;
  List notifications = [
    'Enter a new notification?',
    'Notification1',
    'Notification2',
    'Notification3'
  ];
  List<NotiClass> notificationsList = [];
  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 8,
          backgroundColor: Colors.teal,
          child: Icon(
            Icons.cancel,
            color: Colors.white,
            size: 55,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return CustomReminderAddNew();
                });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        key: key,
        body: DraggableBottomSheet(
          backgroundWidget: Scaffold(
            body: Container(
              color: Colors.teal,
              child: Image(
                image: AssetImage('assets/custom_reminders.png'),
                height: 250,
              ),
            ),
          ),
          previewChild: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 6,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16)),
                ),
                SizedBox(
                  height: 16,
                ),
                customReminders.length == 0
                    ? Container(
                        padding: EdgeInsets.only(top: 150),
                        child: Text(
                          'Such Empty, Much Wow',
                          style: GoogleFonts.exo2(fontSize: 20),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: customReminders.length > 3
                                ? 3
                                : customReminders.length,
                            itemBuilder: (context, index) {
                              reminderLength = customReminders.length;
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Color(colorChoices[index]),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        height: 100,
                                        width: 4,
                                      ),
                                      SizedBox(
                                        height: 100,
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                mainPageReminderStartTimes[
                                                    index],
                                                style: GoogleFonts.exo2(),
                                              ),
                                              SizedBox(width: 5),
                                              Container(
                                                height: 1,
                                                width: 290,
                                                color: Colors.grey,
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            mainPageReminders[index],
                                            style: GoogleFonts.exo2(
                                                textStyle: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Container(
                                            width: 325,
                                            child: Text(
                                              mainPageReminderDescriptions[
                                                  index],
                                              style: GoogleFonts.exo2(),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text(
                                                mainPageReminderEndTimes[index],
                                                style: GoogleFonts.exo2(),
                                              ),
                                              SizedBox(width: 5),
                                              Container(
                                                height: 1,
                                                width: 250,
                                                color: Colors.grey,
                                              ),
                                              IconButton(
                                                icon:
                                                    Icon(Icons.cancel_outlined),
                                                onPressed: () async {
                                                  var reminderHelper =
                                                      ReminderDatabase.instance;
                                                  reminderHelper.deleteReminder(
                                                      mainPageReminderDescriptions[
                                                          index]);
                                                  mainPageReminders
                                                      .removeAt(index);
                                                  mainPageReminderDescriptions
                                                      .removeAt(index);
                                                  mainPageReminderStartTimes
                                                      .removeAt(index);
                                                  mainPageReminderEndTimes
                                                      .removeAt(index);
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EntryPoint()));
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25,
                                  )
                                ],
                              );
                            }),
                      ),
              ],
            ),
          ),
          expandedChild: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 6,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16)),
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: reminderLength,
                      itemBuilder: (context, index) {
                        reminderLength = customReminders.length;
                        return Column(
                          children: [
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color(colorChoices[index]),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  height: 100,
                                  width: 4,
                                ),
                                SizedBox(
                                  height: 100,
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          mainPageReminderStartTimes[index],
                                          style: GoogleFonts.exo2(),
                                        ),
                                        SizedBox(width: 5),
                                        Container(
                                          height: 1,
                                          width: 290,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      mainPageReminders[index],
                                      style: GoogleFonts.exo2(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Container(
                                      width: 325,
                                      child: Text(
                                        mainPageReminderDescriptions[index],
                                        style: GoogleFonts.exo2(),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          mainPageReminderEndTimes[index],
                                          style: GoogleFonts.exo2(),
                                        ),
                                        SizedBox(width: 5),
                                        Container(
                                          height: 1,
                                          width: 290,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
          minExtent: 400,
          maxExtent: MediaQuery.of(context).size.height * 1,
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: AnimatedIcon(
              color: Colors.black,
              icon: AnimatedIcons.menu_close,
              progress: animationController,
            ),
            onPressed: () => handleOnPressed(),
          ),
          actions: [
            GestureDetector(
                child: Container(
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(selectedAvatar),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ViewProfile()));
                }),
            IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CustomReminderAddNew();
                      });
                }),
            IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.black,
                ),
                onPressed: () async {
                  var response =
                      await get(Uri.parse('${global.url}/noti/${global.sid}'));

                  setState(() {
                    if (response.body.length > 18) {
                      NotificationList jsonNotification =
                          NotificationList.fromJson(json.decode(response.body));

                      notifications.clear();

                      for (int i = 0;
                          i < jsonNotification.notification.length;
                          i++) {
                        notifications
                            .add(jsonNotification.notification[i].topic);
                        notifications
                            .add(jsonNotification.notification[i].description);
                        notifications
                            .add(jsonNotification.notification[i].date);
                        notifications
                            .add(jsonNotification.notification[i].time);
                        NotiClass newNoti = NotiClass(
                            title: jsonNotification.notification[i].topic,
                            description:
                                jsonNotification.notification[i].description,
                            date: jsonNotification.notification[i].date,
                            time: jsonNotification.notification[i].time);
                        notificationsList.add(newNoti);
                      }
                    } else {
                      notifications.clear();
                      notifications.add('No new notification');
                    }
                  });
                  return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        print(auth);
                        if (auth == 1) {
                          return AlertDialog(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Notifications',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff235790),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.info_outline,
                                    color: Color(0xff235790),
                                  ),
                                  onPressed: () {
                                    return showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(
                                              'Long press the club name to delete',
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
                            content: Container(
                              height: double.maxFinite,
                              width: double.maxFinite,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onLongPress: () async {
                                      print(notificationsList[index].title +
                                          notificationsList[index].description);
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Text(notificationsList[index].title),
                                          Text(notificationsList[index]
                                              .description),
                                          Text(notificationsList[index].date),
                                          Text(notificationsList[index].time),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: notificationsList.length,
                              ),
                            ),
                          );
                        } else {
                          return AlertDialog(
                            title: Text(
                              'Notifications',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xff235790),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Container(
                              height: double.maxFinite,
                              width: double.maxFinite,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onLongPress: () {
                                      String reminderDescription =
                                          notificationsList[index].title +
                                              ' ' +
                                              notificationsList[index]
                                                  .description;
                                      List<String> dateList =
                                          notificationsList[index]
                                              .date
                                              .split('-');
                                      List<String> timeList =
                                          notificationsList[index]
                                              .time
                                              .split(':');
                                      DateTime notificationDateTime =
                                          new DateTime(
                                        int.parse(dateList[2]),
                                        int.parse(dateList[1]),
                                        int.parse(dateList[0]),
                                        int.parse(timeList[0]),
                                        int.parse(timeList[1]),
                                      );

                                      customReminders.add(CustomReminderDetails(
                                          0,
                                          reminderDescription,
                                          notificationDateTime,
                                          true));

                                      var reminderHelper =
                                          ReminderDatabase.instance;
                                      Reminder reminder = Reminder(
                                        id: 0,
                                        description: reminderDescription,
                                        year: int.parse(dateList[2]),
                                        month: int.parse(dateList[1]),
                                        day: int.parse(dateList[0]),
                                        hour: int.parse(timeList[0]),
                                        minute: int.parse(timeList[1]),
                                        getNotified: true,
                                      );

                                      reminderHelper.create(reminder);
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Text(notificationsList[index].title),
                                          Text(notificationsList[index]
                                              .description),
                                          Text(notificationsList[index].date),
                                          Text(notificationsList[index].time),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: notificationsList.length,
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UploadNotification()));
                                  },
                                  child: Icon(Icons.add)),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MainPage()));
                                  },
                                  child: Text(
                                    'Okay',
                                    style: TextStyle(fontSize: 17.5),
                                  ))
                            ],
                          );
                        }
                      });
                }),
          ],
        ),
        drawer: Settings(),
        bottomNavigationBar: bottomAppBar(),
      ),
    );
  }

  void updateReminder() async {
    var reminderHelper = ReminderDatabase.instance;
    var databaseReminder = await reminderHelper.getAllReminders();
    print('reminder count ${databaseReminder.length}');
    customReminders.clear();
    mainPageReminders.clear();
    mainPageReminderDescriptions.clear();
    mainPageReminderStartTimes.clear();
    mainPageReminderEndTimes.clear();
    for (int i = 0; i < databaseReminder.length; i++) {
      DateTime dateTime = new DateTime(
          databaseReminder[i].year,
          databaseReminder[i].month,
          databaseReminder[i].day,
          databaseReminder[i].hour,
          databaseReminder[i].minute);
      customReminders.add(CustomReminderDetails(
          0,
          databaseReminder[i].description,
          dateTime,
          databaseReminder[i].getNotified));

      mainPageReminders.add('Reminder ${i + 1}');
      mainPageReminderDescriptions.add(databaseReminder[i].description);
      mainPageReminderStartTimes.add('${databaseReminder[i].hour}' +
          ':' +
          '${databaseReminder[i].minute}');
      mainPageReminderEndTimes.add('${databaseReminder[i].hour}' +
          ':' +
          '${databaseReminder[i].minute}');
    }
    reminderLength = customReminders.length;
  }

  Future<int> getAuth() async {
    var userHelper = UserDatabase.instance;
    var databaseUsers = await userHelper.getAllUsers();
    int userAuth = databaseUsers[0].auth;
    auth = userAuth;
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

  void updateProfile() async {
    var userHelper = UserDatabase.instance;
    var databaseUser = await userHelper.getAllUsers();
    var sid = databaseUser[0].sid;
    var response = await get(Uri.parse('${global.url}/viewprofile/$sid'));
    Profile profile = Profile.fromJson(json.decode(response.body));
    setState(() {
      profileName = profile.name;
      profileSid = profile.sid.toString();
      profileClubs = profile.clubs.length == 0
          ? ' Not in any clubs '
          : profile.clubs.toString();
      profileBranch = profile.branch.toString();
      profileYear = profile.year.toString();
      profileSemester = profile.semester.toString();
      profileInsta =
          profile.insta == null ? 'No instagram handle' : profile.insta;
      profileAvatar =
          profile.avatar == null ? 'assets/neutral_girl.png' : profile.avatar;
    });
  }
}
