import 'package:flutter/material.dart';
import 'package:grad_talk/notification_services.dart';
import 'package:grad_talk/student_view/student_widgets/studentNavBar.dart';
import 'package:grad_talk/student_view/student_widgets/student_widgets.dart';

import '../theme.dart';



class Student extends StatefulWidget {
  const Student({super.key});

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  //allows for notifications to be displayed
  @override
  void initState() {
    super.initState();
    NotificationServices().permissionRequest();
    NotificationServices().initialize();
    
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //Displays home screen to user
      drawer: StudentNavBar(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("GradTalk"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(child: Text(""
            "Welcome to GradTalk! This is a social networking application that connects you with a mentor of your choice for advice on college! Please use the menu on the top left corner to navigate through the app. Thank you!.",
        style: TextStyle(
          fontSize: 22,
          color: Colors.white
        ),
        textAlign: TextAlign.center,
        )
        ),
      )
    );
  }
}