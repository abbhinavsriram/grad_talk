import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/database_services.dart';
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

  //Displays mentor's profile
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
                        const SizedBox(height: 35),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MentorViewReviewPage(
                                    average: snapshot.data?.docs[0]['average'], 
                                    numRatings: snapshot.data?.docs[0]['numRatings'], 
                                    mentorID: FirebaseAuth.instance.currentUser!.uid
                                  )
                              ));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: GradTalkColors.primary,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: const Center(
                                child: Text("View reviews", style: TextStyle(
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
          }
          return const Center(child: CircularProgressIndicator());
        }
    );
  }

  //heading style
  Widget fieldText(String field){
    return Text(
      field,
      style: const TextStyle(
        fontSize: 17,
        color: GradTalkColors.primary,
      ),
    );
  }


  //body text style
  Widget valueText(String value){
    return Text(
      value,
      style: const TextStyle(
          fontSize: 16
      ),
    );
  }
}

