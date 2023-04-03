import 'package:flutter/material.dart';
import 'package:grad_talk/theme.dart';
/*
Credit for snackbar:
  Flutter. “Display a Snackbar.” Flutter, 
    https://docs.flutter.dev/cookbook/design/snackbars. 

*/
class Utils {
  //Displays messages to the user at the bottom of the screen
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String? text){
    if (text == null) return;

    final snackBar = SnackBar(content: Text(text), backgroundColor: GradTalkColors.primary);
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

}