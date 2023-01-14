import 'package:flutter/material.dart';

import '../theme.dart';
import 'mentor_widgets/mentorNavBar.dart';


class Mentor extends StatelessWidget {
  const Mentor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          centerTitle: true,
          title: Text("GradTalk"),
        ),
        body: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(child: Text(""
              "Welcome to GradTalk! This is a social networking application that connects you with a mentor of your choice for advice on college! Please use the menu on the top left corner to navigate through the app. Thank you!",
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


