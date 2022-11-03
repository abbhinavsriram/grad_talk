import 'package:flutter/material.dart';
import 'package:grad_talk/student_view/student_widgets/student_widgets.dart';

class MentorProfilePage extends StatelessWidget {
  const MentorProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: StudentNavBar(),
        appBar: AppBar(
          title: Text("GraduTalk"),
        ),
        body: Center(child: Text("Mentor profile"))
    );
  }
}

