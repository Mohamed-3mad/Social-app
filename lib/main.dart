import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notes_app/auth/login.dart';
import 'package:notes_app/auth/signup.dart';
import 'package:notes_app/home/homepage.dart';
import 'package:notes_app/test.dart';
import 'package:notes_app/testtwo.dart';

import 'crud/addnotes.dart';

bool? islogin;

Future backgroudMessage(RemoteMessage message) async {
  print("=================== BackGroud Message ========================");
  print("${message.notification!.body}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(backgroudMessage);

  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    islogin = false;
  } else {
    islogin = true;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: islogin == false
          ? Login()
          : HomePage(
            ),
      // home: Test(),
      theme: ThemeData(
          // fontFamily: "NotoSerif",
          primaryColor: Colors.blue,
          textTheme: TextTheme(
            titleLarge: TextStyle(fontSize: 20, color: Colors.white),
            headlineSmall: TextStyle(fontSize: 30, color: Colors.blue),
            bodyMedium: TextStyle(fontSize: 20, color: Colors.black),
          )),
      routes: {
        "login": (context) => Login(),
        "signup": (context) => SignUp(),
        "homepage": (context) => HomePage(),
        "addnotes": (context) => AddNotes(),
        "testtwo": (context) => TestTwo()
      },
    );
  }
}
