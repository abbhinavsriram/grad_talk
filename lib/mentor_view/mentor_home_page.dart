import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/mentor_view/mentor_widgets/mentor_widgets.dart';

import '../database_services.dart';

dynamic profile;
String? name = "James";
String? role = "";
int? connections = 0;
String? email;

class Mentor extends StatefulWidget {
  const Mentor({Key? key}) : super(key: key);

  @override
  State<Mentor> createState() => _MentorState();
}

class _MentorState extends State<Mentor> {

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Center(child: Text("GraduTalk")),
      ),
      body: Center(child: Text("Mentor Home"))
    );
  }
}


