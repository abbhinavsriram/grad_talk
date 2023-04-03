import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/database_services.dart';
import 'package:grad_talk/mentor_view/mentor_widgets/mentor_widgets.dart';
import 'package:grad_talk/widgets/widgets.dart';
import 'package:grad_talk/theme.dart';
import 'package:grad_talk/mentor_view/mentor_pages.dart';

class StudentInfoPage extends StatefulWidget {
  const StudentInfoPage({Key? key}) : super(key: key);

  @override
  State<StudentInfoPage> createState() => _StudentInfoPageState();
}

class _StudentInfoPageState extends State<StudentInfoPage> {


  //Display student's profile to mentor
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: DatabaseService().getOtherID('Parent'),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Navigator.of(context).pop(MaterialPageRoute(
                builder: (context) => const Mentor()
            ));
            return Utils.showSnackBar("Please talk to a parent first!");
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

  //Heading format
  Widget fieldText(String field){
    return Text(
      field,
      style: const TextStyle(
        fontSize: 17,
        color: GradTalkColors.primary,
      ),
    );
  }
  //Body text format
  Widget valueText(String value){
    return Text(
      value,
      style: const TextStyle(
          fontSize: 16
      ),
    );
  }

}




