import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:grad_talk/database_services.dart';

import 'package:grad_talk/student_view/student_widgets/studentNavBar.dart';

import '../student_view/pages.dart';
import '../theme.dart';
import '../widgets/widgets.dart';


class ReportPage extends StatefulWidget {

  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();

}



class _ReportPageState extends State<ReportPage> {

  GlobalKey<FormState> _reportStudentKey = GlobalKey<FormState>();
  TextEditingController _reportController = TextEditingController();
  bool _loading = false;
  @override
  void dispose(){
    _reportController.dispose();
    super.dispose();
  }


  @override
  //Allows user to report mentor
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: StudentNavBar(),
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
              key: _reportStudentKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 25),
                  const Text("Report your mentor",
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
                        hintText: "Please give a description of what happened",
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
                          child: Text("Confirm report", style: TextStyle(
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
    //Checks validity of report and uploads to database
    if (_reportStudentKey.currentState!.validate()) {
        setState(() {
          _loading = true;
        });
    }

    await DatabaseService().addReport(_reportController.text.trim(), FirebaseAuth.instance.currentUser!.uid).then((value) async {
      setState(() {
        _loading = false;
      });
      _reportController.clear();
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => const Student()
      ));
      Utils.showSnackBar("Report sent successfully");
    });
  }


}