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
    CollectionReference student = db.collection('users');
    print("database called");
  //https://www.educative.io/answers/how-to-use-flutter-to-read-and-write-data-to-firebase
    return FutureBuilder<DocumentSnapshot>(
      //Fetching data from the documentId specified of the student
      future: student.doc(uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        print("first builder statement executed");
        //Error Handling conditions
            //Add error text parameters to error.dart
        if (snapshot.hasError) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ErrorScreen()));
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          print(Text("Document does not exist"));
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ErrorScreen()));
        }
        print("This data is fine but it is not being outputted");
        //Data is output to the user
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          if(data["role"] == "Mentor"){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Mentor()));
          }
          else if(data["role"] == "Parent"){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Student()));
          }

        }

        return const Text("loading");
      },
    );
  }


} 

