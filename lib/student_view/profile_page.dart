import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/database_services.dart';
import 'package:grad_talk/student_view/student_widgets/student_widgets.dart';
import 'package:grad_talk/screens/screens.dart';
import 'package:grad_talk/widgets/widgets.dart';
import 'package:grad_talk/student_view/pages.dart';
import 'package:grad_talk/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


//Make changes to profile screen
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: DatabaseService().getUserData(
            FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => const Student()
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
              drawer: StudentNavBar(),
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
/*
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                                "Name: ${snapshot.data
                                    ?.docs[0]['name']} \n Email: ${snapshot.data
                                    ?.docs[0]['email']} \n Role: ${snapshot.data
                                    ?.docs[0]['role']} \n User id: ${FirebaseAuth
                                    .instance.currentUser!.uid} \n Major: ${snapshot.data
                                    ?.docs[0]['major']} \n Desired career: ${snapshot.data
                                    ?.docs[0]['career']} \n Description: ${snapshot.data
                                    ?.docs[0]['description']} \n Scores: ${snapshot.data
                                    ?.docs[0]['scores']} \n Extracurriculars: ${snapshot.data
                                    ?.docs[0]['extracurriculars']} \n Graduating year: ${snapshot.data
                                    ?.docs[0]['year']} \n",
                                style: const TextStyle(
                                  fontSize: 20,
                                )
                            ),
                          ),
final formKey = GlobalKey<FormState>();
final _emailController = TextEditingController();
final _passwordController = TextEditingController();
final _transcriptController = TextEditingController();
final _standardizedController = TextEditingController();
final _extracurricularsController = TextEditingController();
final _collegeController = TextEditingController();
final _careerController = TextEditingController();
final _majorController = TextEditingController();
final _yearController = TextEditingController();
final _descriptionController = TextEditingController();
final _nameController = TextEditingController();

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _transcriptController.dispose();
    _standardizedController.dispose();
    _extracurricularsController.dispose();
    _collegeController.dispose();
    _careerController.dispose();
    _majorController.dispose();
    _yearController.dispose();
    _descriptionController.dispose();
    _nameController.dispose();

    super.dispose();
  }
//Make changes to profile screen
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: DatabaseService().getUserData(FirebaseAuth.instance.currentUser!.uid),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => const Student()
          ));
          return Utils.showSnackBar("Cannot access profile right now");
        } else if(snapshot.hasData){
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
            drawer: StudentNavBar(),
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                            "Name: ${snapshot.data?.docs[0]['name']} \n Email: ${snapshot.data?.docs[0]['email']} \n Role: ${snapshot.data?.docs[0]['role']} \n User id: ${FirebaseAuth.instance.currentUser!.uid}",
                            style: const TextStyle(
                              fontSize: 16,
                            )
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),

                          child: TextFormField(
                            maxLines: 10,
                            controller: _transcriptController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: AppColors.accent),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              hintText: snapshot.data?.docs[0]['transcript'],

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
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: AppColors.accent),
                                  borderRadius: BorderRadius.circular(12)

                              ),
                              hintText: snapshot.data?.docs[0]['scores'],

                            ),
                          ),

                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),

                          child: TextFormField(
                            maxLines: 10,
                            controller: _collegeController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: AppColors.accent),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              hintText: snapshot.data?.docs[0]['college'],

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
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: AppColors.accent),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              hintText: snapshot.data?.docs[0]['extracurriculars'],

                            ),

                          ),

                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),

                          child: TextFormField(
                            controller: _majorController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: AppColors.accent),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              hintText: snapshot.data?.docs[0]['major'],

                            ),

                          ),

                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),

                          child: TextFormField(
                            controller: _careerController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: AppColors.accent),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              hintText: snapshot.data?.docs[0]['career'],

                            ),
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),

                          child: TextFormField(
                            controller: _yearController,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: AppColors.accent),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              hintText: snapshot.data?.docs[0]['year'],

                            ),
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),

                          child: TextFormField(
                            maxLines: 7,
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: AppColors.accent),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              hintText: snapshot.data?.docs[0]['year'],

                            ),

                          ),

                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: GestureDetector(
                            onTap: () => saveProfileChanges(
                              snapshot.data?.docs[0]['name'],
                              snapshot.data?.docs[0]['email'],
                              snapshot.data?.docs[0]['groupID'],
                              snapshot.data?.docs[0]['currentlyConnected'],
                              snapshot.data?.docs[0]['role'],
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(20),
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
                      ],
                    ),
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


  Future saveProfileChanges(String name, String email, String groupID, bool currentlyConnected, String role) async {
    if (formKey.currentState!.validate()) {
      await DatabaseService().saveUserData(
          name,
          email,
          _collegeController.text.trim(),
          _careerController.text.trim(),
          _descriptionController.text.trim(),
          _extracurricularsController.text.trim(),
          _majorController.text.trim(),
          role,
          _standardizedController.text.trim(),
          _transcriptController.text.trim(),
          FirebaseAuth.instance.currentUser!.uid,
          _yearController.text.trim(),
          currentlyConnected,
          groupID)
      .then((value) async {
        Navigator.of(context).pop(MaterialPageRoute(
            builder: (context) => const Student()
        ));
      });
    }
  }

}
*/