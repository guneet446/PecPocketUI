import 'dart:convert';
import 'dart:math';
import 'package:fend/globals.dart' as global;
import 'package:fend/models/student_json.dart';
import 'package:fend/screens/signUp/SignUpEmail.dart';
import 'package:fend/screens/signUp/SignUpSubjects.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'package:mailer2/mailer.dart';

import '../login_screen.dart';

var rng = new Random();
int otp = 100000 + rng.nextInt(999999 - 100000);

class SignUp1 extends StatefulWidget {
  createState() {
    return SignUp1State();
  }
}

class SignUp1State extends State<SignUp1> {
  String sid;

  Widget build(context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: [
          Image.asset('assets/bg2.png'),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
            child: Column(
              children: [
                sidField(),
                getStartedButton(),
                toLogin(),
              ],
            ),
          ),
          Image.asset('assets/bg1.png'),
        ],
      ),
    );
  }

  sidField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Enter your SID'),
      onChanged: (String value) {
        setState(() {
          sid = value;
        });
      },
    );
  }

  toLogin() {
    return Center(
      child: RichText(
        text: new TextSpan(
            text: 'Already have an account? ',
            style: TextStyle(
              color: Colors.grey,
            ),
            children: [
              new TextSpan(
                text: 'Login Now',
                style: TextStyle(color: Color(0xffE28F22)),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login())),
              )
            ]),
      ),
    );
  }

  getStartedButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 100, bottom: 30),
      child: ElevatedButton(
        onPressed: validateSID,
        child: Text(
          'Get Started!',
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return Color(0xffE28F22); // Use the component's default.
            },
          ),
        ),
      ),
    );
  }

  validateSID() async {
    var response = await get(Uri.parse('${global.url}/signup/$sid'));
    String body = response.body;

    if (body[12] == '2') {
      var options = new GmailSmtpOptions()
        ..username = 'pecpocket@gmail.com'
        ..password = 'PecPocket123';

      var emailTransport = new SmtpTransport(options);

      var envelope = new Envelope()
        ..from = 'kautsdhruv15@gmail.com'
        ..recipients.add('theofficial.kauts@gmail.com')
        ..subject = 'Welcome to PecPocket'
        ..html = '<h3>$otp<h3>\n<p></p>';

      await emailTransport.send(envelope);
      var response = await get(Uri.parse('${global.url}/super/$sid'));
      StudentData studentData =
          StudentData.fromJson(json.decode(response.body));

      setState(() {
        global.sid = sid;
        print(body);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignUpEmail()));
      });
    } else if (body[14] == '2') {
      setState(() {
        print(body);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('SID already signed up')));
      });
    } else {
      setState(() {
        print(body);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Not a valid PEC SID')));
      });
    }
  }
}

/*int random(int min, int max) {
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }*/
