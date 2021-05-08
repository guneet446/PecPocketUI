import 'package:fend/Databases/remindersDB.dart';
import 'package:fend/EntryPoint.dart';
import 'package:fend/classes/CustomReminderDetails.dart';
import 'package:fend/classes/Reminder.dart';
import 'package:fend/screens/CustomReminders/CustomReminderView.dart';
import 'package:fend/screens/mainPage.dart';
import 'package:flutter/material.dart';

class CustomReminderAddNew extends StatefulWidget {
  @override
  _CustomReminderAddNewState createState() => _CustomReminderAddNewState();
}

class _CustomReminderAddNewState extends State<CustomReminderAddNew> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final myController = TextEditingController();
  DateTime selectedDate;
  TimeOfDay selectedTime;
  DateTime selectedDateTime;
  String userDescription = "";
  bool getNotif = true;
  int uid = 0;
  int toAdd = 0;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //date time input under progress
    /*return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0B7A75),
        elevation: 0,
      ),
      body: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
            color: Color(0xff0B7A75),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Set Reminder",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
                TextFormField(
                  controller: titleController,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: 'TITLE',
                    labelStyle: TextStyle(
                      color: Color(0x95ffffff),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  validator: (val) {
                    return val.isEmpty ? 'Enter the title of the task' : null;
                  },
                ),
                TextFormField(
                  controller: descriptionController,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: 'DESCRIPTION',
                    labelStyle: TextStyle(
                      color: Color(0x95ffffff),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  validator: (val) {
                    return val.isEmpty ? 'Enter the description of the task' : null;
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DATE',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  selectedDate.day.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 300,
            child: SwitchListTile(
              title: Text("Get Notified"),
              activeColor: Color(0xff0B7A75),
              value: getNotif,
              onChanged: (newValue) {
                setState(() {
                  getNotif = newValue;
                });
              },
            ),
          ),
        ],
      ),
    ); */
    return AlertDialog(
      title: Text("Set Reminder"),
      content: TextFormField(
        controller: myController,
        decoration: InputDecoration(labelText: 'Description of the reminder'),
        validator: (val) {
          return val.isEmpty ? 'Enter the description' : null;
        },
      ),
      actions: <Widget>[
        SizedBox(
          width: 300,
          child: SwitchListTile(
            title: Text("Get Notified"),
            value: getNotif,
            onChanged: (newValue) {
              setState(() {
                getNotif = newValue;
              });
            },
          ),
        ),
        TextButton(
          child: Text(
            'Next',
            style: TextStyle(color: Color(0xff235790)),
          ),
          onPressed: () async {
            userDescription = myController.text;
            selectedDate = await _selectDate(context);
            setState(() {
              toAdd = 1;
              print('toAdd $toAdd');
            });
            selectedTime = await _selectTime(context);
            setState(() {
              toAdd = 2;
              print('toAdd $toAdd');
            });

            var reminderHelper = ReminderDatabase.instance;

            if (toAdd == 2) {
              Reminder reminder = Reminder(
                  id: 0,
                  description: userDescription,
                  year: selectedDate.year,
                  month: selectedDate.month,
                  day: selectedDate.day,
                  hour: selectedTime.hour,
                  minute: selectedTime.minute,
                  getNotified: getNotif);

              selectedDateTime = new DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                  selectedTime.hour,
                  selectedTime.minute);
              customReminders.add(CustomReminderDetails(
                  uid, userDescription, selectedDateTime, getNotif));
              setState(() {
                reminderHelper.create(reminder);
              });
            }

            //if (selectedDate != null && selectedTime != null) {}

            //if (getNotif) {
            //await notifications.showNotification(); //can be used for testing
            //await notifications.scheduleNotification(
            //   uid, selectedDateTime, userDescription);
            // ++uid;
            // }

            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => EntryPoint()));
          },
        ),
      ],
    );
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendar,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xff588297),
            accentColor: Color(0xffE28F22),
            colorScheme: ColorScheme.light(
              primary: Color(0xff235790),
            ),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
    );
    return pickedDate;
  }

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        helpText: "Time of Reminder",
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (BuildContext context, Widget child) {
          /*return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );*/
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(0xff588297),
              accentColor: Color(0xffE28F22),
              colorScheme: ColorScheme.light(
                primary: Color(0xff235790),
              ),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child,
          );
        });
    return pickedTime;
  }

  onNotificationClick(String payload) {
    print('Payload $payload');
  }
}
