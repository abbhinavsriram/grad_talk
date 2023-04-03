import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/widgets/widgets.dart';
import '../theme.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  //Sends email to user if they have forgotten their password
  GlobalKey<FormState> _forgotKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  bool _loading = false;

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      elevation: 0,
      title: Text("Reset password"),
    ),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _forgotKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please type your email address, an email will be sent to reset your password',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24
              )
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              cursorColor: GradTalkColors.cardDark,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: 'Email'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                email != null && !EmailValidator.validate(email)
                  ? 'Enter a valid email'
                  : null,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
                backgroundColor: GradTalkColors.primary,
              ),
              icon: Icon(Icons.email_outlined),
              label: Text(
                'Reset Password',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: resetPassword,
            )
          ]
        ),
      )
    )
  );

  Future resetPassword() async {
      setState(() {
        _loading = true;
      });


    try {
      //sends email, stops loading screen
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Utils.showSnackBar('Reset email sent');
      setState(() {
        _loading = false;
      });
    } on FirebaseAuthException catch (e) {
      print(e);
      //returns error
      return Utils.showSnackBar(e.message);
    }
  }

}


