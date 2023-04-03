import 'package:grad_talk/login_screens/screens.dart';
import 'package:flutter/material.dart';
//Allows user to toggle between login and sign up screens
class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);


  @override
  State<AuthPage> createState() => _AuthPageState();
}
//Displays the correct login screen
class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LoginWidget(onClickedSignUp: toggle)
      : SignUpWidget(onClickedSignIn: toggle);
  void toggle() => setState(() => isLogin = !isLogin);


}
