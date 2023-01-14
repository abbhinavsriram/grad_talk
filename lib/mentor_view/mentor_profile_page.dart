import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/database_services.dart';
import 'package:grad_talk/screens/screens.dart';
import 'package:grad_talk/widgets/widgets.dart';
import 'package:grad_talk/theme.dart';
import 'package:grad_talk/mentor_view/mentor_pages.dart';
import 'mentor_widgets/mentorNavBar.dart';

class MentorProfilePage extends StatefulWidget {
  const MentorProfilePage({Key? key}) : super(key: key);

  @override
  State<MentorProfilePage> createState() => _MentorProfilePageState();
}

class _MentorProfilePageState extends State<MentorProfilePage> {


//Make changes to profile screen
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: DatabaseService().getUserData(
            FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => const Mentor()
            ));
            return Utils.showSnackBar("Cannot access profile right now");
          } else if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  "GradTalk",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              drawer: NavBar(),
              body: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: fieldText("Name"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: valueText(snapshot.data?.docs[0]['name']),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: fieldText("Email"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: valueText(snapshot.data?.docs[0]['email']),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: fieldText("Your user ID"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: valueText(FirebaseAuth.instance.currentUser!.uid),
                        ),



                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: fieldText("College"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: valueText(snapshot.data?.docs[0]['college']),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: fieldText("Major"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: valueText(snapshot.data?.docs[0]['major']),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: fieldText("Graduating year"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: valueText(snapshot.data?.docs[0]['year']),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: fieldText("Intended Career"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: valueText(snapshot.data?.docs[0]['career']),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: fieldText("Short introduction"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: valueText(snapshot.data?.docs[0]['description']),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: fieldText("Extracurriculars"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: valueText(snapshot.data?.docs[0]['extracurriculars']),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: fieldText("Test scores"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: valueText(snapshot.data?.docs[0]['scores']),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: fieldText("Transcript"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: valueText(snapshot.data?.docs[0]['transcript']),
                        ),
                        const SizedBox(height: 15)
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        }
    );
  }


  Widget fieldText(String field){
    return Text(
      field,
      style: const TextStyle(
        fontSize: 17,
        color: AppColors.accent,
      ),
    );
  }

  Widget valueText(String value){
    return Text(
      value,
      style: const TextStyle(
          fontSize: 16
      ),
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
