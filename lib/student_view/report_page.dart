import 'package:flutter/material.dart';
import 'package:grad_talk/student_view/student_widgets/student_widgets.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: StudentNavBar(),
        appBar: AppBar(
          title: Text("GraduTalk"),
        ),
        body:  const Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(child: Text(""
              "Please email gradtalk@gmail.com if you have any concerns or would like to report an incident. Please also provide your userID in your email",
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