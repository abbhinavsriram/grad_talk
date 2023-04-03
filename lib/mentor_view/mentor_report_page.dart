import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/database_services.dart';

import '../theme.dart';
import '../widgets/widgets.dart';
import 'mentor_widgets/mentor_widgets.dart';


class MentorReportPage extends StatefulWidget {

  const MentorReportPage({Key? key}) : super(key: key);

  @override
  State<MentorReportPage> createState() => _MentorReportPageState();

}
final formKey = GlobalKey<FormState>();
final _reportController = TextEditingController();


class _MentorReportPageState extends State<MentorReportPage> {

  /*Credit for Dropdown menu : 
  Fernando, Ishan. “Creating a Dropdown List in Flutter.” LogRocket Blog, Log Rocket, 27 Aug. 2021, 
    https://blog.logrocket.com/creating-dropdown-list-flutter/. 
  */
  bool _loading = false;
  @override
  void dispose(){
    _reportController.dispose();  
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
            "Report",
            style: TextStyle(
              fontSize: 20,
            ),
        ),
      ),
      body: _loading
          ? const Center(
          child: CircularProgressIndicator(
            color: GradTalkColors.primary,
          )
      ) : SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 25),
                  const Text("Sign in to GradTalk",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),

                    child: TextFormField(
                      maxLines: 20,
                      controller: _reportController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: GradTalkColors.primary),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        hintText: "Please give a short introduction",
                      ),
                      validator: (value) => value != null && value.length < 50
                        ? 'Minimum 50 characters'
                          : null,
                    ),

                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: GestureDetector(
                      onTap: () => newReport(),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: GradTalkColors.primary,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Center(
                          child: Text("Report", style: TextStyle(
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

  Future newReport() async{
    //Validates report and uploads it
    if (formKey.currentState!.validate()) {
        setState(() {
          _loading = true;
        });
    }

    await DatabaseService().addReport(_reportController.text.trim(), FirebaseAuth.instance.currentUser!.uid).then((value) async {
        return Utils.showSnackBar("Your report has been sent");
    });
  }


}