import 'package:flutter/material.dart';
import 'package:grad_talk/notification_services.dart';
import 'mentor_widgets/mentor_widgets.dart';



class Mentor extends StatefulWidget {
  const Mentor({super.key});

  @override
  State<Mentor> createState() => _MentorState();
}

class _MentorState extends State<Mentor> {
  @override
  void initState() {
    //starts notifications
    super.initState();
    NotificationServices().permissionRequest();
    NotificationServices().initialize();

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        //side bar menu
        drawer: NavBar(),
        appBar: AppBar(
          centerTitle: true,
          title: Text("GradTalk"),
        ),
        body: const Padding(
          padding: EdgeInsets.all(20.0),
          //text in the middle of the screen
          child: Center(child: Text("Welcome to GradTalk! This is a social networking application that connects you with a mentor of your choice for advice on college! Please use the menu on the top left corner to navigate through the app. Thank you!",
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


