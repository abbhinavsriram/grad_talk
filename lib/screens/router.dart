import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/database_services.dart';
import 'package:grad_talk/screens/error.dart';
import 'package:grad_talk/student_view/home_page.dart';

import '../mentor_view/mentor_home_page.dart';

class RouterPage extends StatefulWidget {
  const RouterPage({Key? key}) : super(key: key);

  @override
  State<RouterPage> createState() => _RouterPageState();
}

class _RouterPageState extends State<RouterPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    String role = getRole();
    print("getRole was called");
    if(role == "Mentor"){
      //don't instantiate these screens every time, create once when main is run
      return Mentor();
    }
    else if(role == "Parent"){
      return Student();
    }
    return ErrorScreen();
  }



  String getRole() {
    final docRef = db.collection("users").doc(uid);
    docRef.get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        print(data['role']);
        return data['role'];
      },
    );
    return "Error";

  }

}

