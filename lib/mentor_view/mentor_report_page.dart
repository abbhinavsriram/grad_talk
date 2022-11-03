import 'package:flutter/material.dart';
import 'package:grad_talk/mentor_view/mentor_widgets/mentor_widgets.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: Text("GraduTalk"),
        ),
        body: Center(child: Text("Report"))
    );
  }
}