import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/mentor_view/mentor_widgets/mentorNavBar.dart';
import 'package:grad_talk/mentor_view/mentor_pages.dart';
import 'package:grad_talk/widgets/widgets.dart';
import '../database_services.dart';
import '../theme.dart';

class RequestProfile extends StatelessWidget {
  //Displays profile of student who requested the mentor
  final Map<String, dynamic> data;

  const RequestProfile({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${data['name']}'s profile"),
        centerTitle: true,
      ),
      drawer: NavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: fieldText("Name"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: valueText(data['name']),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: fieldText("College"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: valueText(data['college']),
              ),

              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: fieldText("Major"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: valueText(data['major']),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: fieldText("Graduating year"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: valueText(data['year']),
              ),

              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: fieldText("Career"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: valueText(data['career']),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: fieldText("Description"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: valueText(data['description']),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: fieldText("Extracurriculars"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: valueText(data['extracurriculars']),
              ),

              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: fieldText("Standardized test scores"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: valueText(data['scores']),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: fieldText("Transcript"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: valueText(data['transcript']),
              ),
              const SizedBox(height: 50),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: () {
                    DatabaseService().createGroup(FirebaseAuth.instance.currentUser!.uid, data['uid']);
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const Mentor()
                    ));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: GradTalkColors.primary,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Center(
                      child: Text("Connect", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),
                      ),
                    ),
                  ),
                ),
              ),


              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(MaterialPageRoute(
                        builder: (context) => const ViewRequestPage()
                    ));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: GradTalkColors.primary,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Center(
                      child: Text("Back to requests page", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: () {
                    DatabaseService().rejectRequest(data['uid']);
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const ViewRequestPage()
                    ));
                    Utils.showSnackBar("You rejected this ${data['name']}'s request");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: GradTalkColors.primary,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Center(
                      child: Text("Reject", style: TextStyle(
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

    );
  }
  //heading format
  Widget fieldText(String field){
    return Text(
      field,
      style: const TextStyle(
        fontSize: 17,
        color: GradTalkColors.primary,
      ),
    );
  }
  //body text format
  Widget valueText(String value){
    return Text(
      value,
      style: const TextStyle(
          fontSize: 16
      ),
    );
  }
}