import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/database_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../screens/error.dart';
import '../theme.dart';



class MentorProfilePage extends StatefulWidget {
  const MentorProfilePage({Key? key}) : super(key: key);

  @override
  State<MentorProfilePage> createState() => _MentorProfilePageState();
}


class _MentorProfilePageState extends State<MentorProfilePage> {

  final formKey = GlobalKey<FormState>();
  final _transcriptController = TextEditingController();
  final _standardizedController = TextEditingController();
  final _extracurricularsController = TextEditingController();
  final _collegeController = TextEditingController();
  final _careerController = TextEditingController();
  final _majorController = TextEditingController();
  final _yearController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _connectionsController = TextEditingController();
  dynamic profile = [];
  String? name = "";
  int? connections = 0;
  String? role = "";
  String? email;


  void printSomething(){
    print(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "GradTalk",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: const Text("text here"),


    );


  }
}


/*        body: FutureBuilder(
          future: readUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorScreen();
            }
            else if (snapshot.hasData) {
              final user = snapshot.data;
              return user == null
                  ? Center(child: Text("No user"))
                  : buildUser(user);
            } else {
              return Center(child: CircularProgressIndicator())
            }
          },
        )
      );
    }


    Widget buildUser(Users user) => SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 25),
                      const Text("Your Profile",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),

                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          "Name: $name"
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                            "Email: $email"
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                            "Role: $role"
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                            "Current number of students: $connections"
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),

                        child: TextFormField(
                          maxLines: 10,
                          controller: _transcriptController,
                          decoration: InputDecoration(
                            labelText: "Transcript",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.accent),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            hintText: profile[9],
                          ),

                        ),

                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),

                        child: TextFormField(
                          maxLines: 5,
                          controller: _standardizedController,
                          decoration: InputDecoration(
                            labelText: "Test scores",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.accent),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            hintText: profile[8],
                          ),

                        ),

                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),

                        child: TextFormField(
                          maxLines: 1,
                          controller: _collegeController,
                          decoration: InputDecoration(
                            labelText: "College",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.accent),
                                borderRadius: BorderRadius.circular(12)
                            ),
                          ),
                        ),

                        ),
                        const SizedBox(height: 10),
                        Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),

                        child: TextFormField(
                        maxLines: 10,
                        controller: _extracurricularsController,
                        decoration: InputDecoration(
                            labelText: "Extracurriculars",
                            enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.accent),
                            borderRadius: BorderRadius.circular(12)
                          ),
                          hintText: profile[6],
                        ),

                        ),

                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),

                        child: TextFormField(
                          controller: _majorController,
                          decoration: InputDecoration(
                            labelText: "Major",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.accent),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            hintText: profile[7],
                          ),

                        ),

                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),

                        child: TextFormField(
                          controller: _careerController,
                          decoration: InputDecoration(
                            labelText: "Career",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.accent),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            hintText: profile[2],
                          ),

                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),

                        child: TextFormField(
                          controller: _yearController,
                          decoration: InputDecoration(
                            labelText: "Graduating year from college",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.accent),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            hintText: profile[11],
                          ),

                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),

                        child: TextFormField(
                          maxLines: 7,
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            labelText: "Introduction",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.accent),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            hintText: profile[5],
                          ),
                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),

                        child: TextFormField(
                          maxLines: 7,
                          controller: _connectionsController,
                          decoration: InputDecoration(
                            labelText: "Maximum number of connections (type 0 if you are currently unavailable)",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.accent),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            hintText: profile[4],
                          ),
                        ),

                      ),


                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: GestureDetector(
                          onTap: () => changeInfo(),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: AppColors.accent,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: const Center(
                              child: Text("Save changes", style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: GestureDetector(
                          onTap: () => empty(),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: AppColors.accent,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: const Center(
                              child: Text("Cancel", style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );


  changeInfo() {
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;
    try{
      profile[2] = _careerController.text.trim();
      profile[3] = _collegeController.text.trim();
      profile[4] = _connectionsController.text.trim();
      profile[5] = _descriptionController.text.trim();
      profile[6] = _extracurricularsController.text.trim();
      profile[7] = _majorController.text.trim();
      profile[8] = _standardizedController.text.trim();
      profile[9] = _transcriptController.text.trim();
      DatabaseService().updateUserData(FirebaseAuth.instance.currentUser?.uid, profile);

      print(_collegeController.text);
      print(_yearController.text);
      print(_transcriptController.text);
      print(_standardizedController.text);
      print(_extracurricularsController.text);
      print(_careerController.text);
      print(_majorController.text);
      print(_yearController.text);
      print(_descriptionController.text);

      empty();


    } on FirebaseAuthException catch (e){
      print(e.toString());
      return const ErrorScreen();

    }
  }

  empty() {
    _transcriptController.text = "";
    _standardizedController.text = "";
    _extracurricularsController.text = "";
    _collegeController.text = "";
    _careerController.text = "";
    _majorController.text = "";
    _yearController.text = "";
    _descriptionController.text = "";

  }

  Stream<List<Users>> readUsers() => FirebaseFirestore.instance.collection('users')
      .snapshots().map((snapshot) => snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList());

  Future<Users?> readUser() async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
    final snapshot = await docUser.get();
    if(snapshot.exists){
      return Users.fromJson(snapshot.data()!);
    }
  }





}

*/
