import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grad_talk/database_services.dart';
import 'package:grad_talk/mentor_view/mentor_pages.dart';
import 'package:grad_talk/screens/router.dart';
import 'package:grad_talk/screens/screens.dart';
import 'package:grad_talk/screens/sign_in_screen.dart';
import 'package:grad_talk/student_view/pages.dart';
import 'package:grad_talk/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_talk/models/models.dart';
import 'package:grad_talk/widgets/widgets.dart';

import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        debugShowCheckedModeBanner: false,
        darkTheme: AppTheme.dark(),
        themeMode: ThemeMode.dark,
        home: const AuthPage(),
    );
  }


}





/*
class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("GradTalk"),
    ),
    floatingActionButton: FloatingActionButton(
      child: Text("Sign in"),
      onPressed => void,
    ),
  );

  void initializeUser(context) async {
    FirebaseAuth.instance.authStateChanges().listen(
            (User? user) async {
          if (user == null) {
            print('user is signed out');

            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthPage()));
          } else {
            dynamic profile = DatabaseService().getUserData(
                FirebaseAuth.instance.currentUser!.uid);
            if (profile[1] == 'Mentor') {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Mentor()));
            }
            else if (profile[1] == 'Student') {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Student()));
            }
            print('user has signed in');
          }
        }
    );
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ErrorScreen()));
  }


}
*/