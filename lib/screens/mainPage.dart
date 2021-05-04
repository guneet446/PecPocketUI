import 'dart:convert';
import 'package:alert_dialog/alert_dialog.dart';
import 'package:fend/Databases/AttendanceDB.dart';
import 'package:fend/Databases/ClubsDB.dart';
import 'package:fend/Databases/SubjectsDB.dart';
import 'package:fend/Databases/TimetableDB.dart';
import 'package:fend/Databases/UserDB.dart';
import 'package:fend/Databases/customFoldersDB.dart';
import 'package:fend/Databases/remindersDB.dart';
import 'package:fend/classes/CustomReminderDetails.dart';
import 'package:fend/classes/NotiClass.dart';
import 'package:fend/classes/Reminder.dart';

import 'package:fend/classes/subjects.dart';
import 'package:fend/classes/user.dart';
import 'package:fend/models/Notifications.dart';
import 'package:fend/models/student_json.dart';
import 'package:fend/screens/CustomFolder.dart';
import 'package:fend/screens/CustomReminders/CustomReminderAddNew.dart';
import 'package:fend/screens/CustomReminders/CustomReminderView.dart';

import 'package:fend/screens/login_screen.dart';
import 'package:fend/screens/signUp/SignUpPassword.dart';
import 'package:fend/screens/signUp/signUpSID.dart';
import 'package:fend/screens/uploadNotification.dart';

import 'package:fend/models/Notifications.dart';
import 'package:fend/screens/HamburgerMenu.dart';

import 'package:fend/widgets/bottomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:fend/globals.dart' as global;
import 'package:http/http.dart';

class MainPage extends StatefulWidget {
  createState() {
    return MainPageState();
  }
}

int auth;

class MainPageState extends State<MainPage> {
  void initState() {
    super.initState();
    updateReminder();
    getAuth();
  }

  String deletePassword;
  List notifications = [
    'Enter a new notification?',
    'Notification1',
    'Notification2',
    'Notification3'
  ];
  List<NotiClass> notificationsList = [];

  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: CustomReminderView(),
        appBar: AppBar(
          title: Text(
            "Home",
            style: TextStyle(
              color: Color(0xffCADBE4),
              fontSize: 32,
            ),
          ),
          backgroundColor: Color(0xff588297),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
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

  setupNotifications() {}

  goToCustomFolders() {
    setState(() {});
  }

  void updateReminder() async {
    var reminderHelper = ReminderDatabase.instance;
    var databaseReminder = await reminderHelper.getAllReminders();
    print('reminder count ${databaseReminder.length}');
    customReminders.clear();
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
    }
  }

  Future<int> getAuth() async {
    var userHelper = UserDatabase.instance;
    var databaseUsers = await userHelper.getAllUsers();
    int userAuth = databaseUsers[0].auth;
    auth = userAuth;
  }
}
