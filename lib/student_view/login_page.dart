import 'package:flutter/material.dart';
import 'package:grad_talk/student_view/student_widgets/student_widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("GraduTalk"),
        ),
        body: Center(child: Text("Login"))
    );
  }
}