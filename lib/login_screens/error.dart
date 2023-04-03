import 'package:flutter/material.dart';
//Displays error to the user in case something goes wrong
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Something went wrong")),
    );
  }
}
