import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/login_services.dart';
import 'package:grad_talk/mentor_view/mentor_home_page.dart';
import 'package:grad_talk/student_view/home_page.dart';
import 'package:grad_talk/theme.dart';
import'package:firebase_auth/firebase_auth.dart';
import 'package:grad_talk/login_screens/screens.dart';
import '../database_services.dart';
import 'package:grad_talk/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LoginWidget({Key? key, required this.onClickedSignUp}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}
  /*
    Credit for UI elements:
    Developers, Stream. “Build a Flutter Chat App: 01 - Design/UI.” YouTube, YouTube, 20 Aug. 2021, 
      https://www.youtube.com/watch?v=vgqBc7jni8c. 

    Credit for firebase connection:
    Flutter, Backslash. “Chat App in Flutter and Firebase | Tutorial for Beginners to Advance | Android &amp; IOS (Latest).” YouTube, YouTube, 26 July 2022, 
      https://www.youtube.com/watch?v=Qwk5oIAkgnY. 

  */
class _LoginWidgetState extends State<LoginWidget> {

  GlobalKey<FormState> _signInKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _loading = false;
  LoginServices loginService = LoginServices();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
            "GradTalk",
            style: TextStyle(
              fontSize: 20,
          ),
        ),
      ),
      body: _loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: GradTalkColors.primary,
                )
      )
      : SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _signInKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 25),
                  const Text("Sign in to GradTalk",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),

                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: GradTalkColors.primary),
                              borderRadius: BorderRadius.circular(12)
                          ),
                          hintText: "Email"
                      ),
                      validator: (value) {
                        if (value!.isEmpty == true) {
                          return "Email cannot be empty";
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return ("Please enter a valid email");
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _emailController.text = value!;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),

                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),

                    child: TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: GradTalkColors.primary),
                              borderRadius: BorderRadius.circular(12)
                          ),
                          hintText: "Password",
                          focusColor: GradTalkColors.secondary
                      ),
                      validator: (value) {
                        RegExp regex = new RegExp(r'^.{6,}$');
                        if (value!.isEmpty) {
                          return "Password cannot be empty";
                        }
                        if (!regex.hasMatch(value)) {
                          return ("please enter valid password min. 6 character");
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _passwordController.text = value!;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),

                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: GestureDetector(
                      onTap: () => signIn(),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: GradTalkColors.primary,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Center(
                          child: Text("Sign in", style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(height: 15),
                  GestureDetector(
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: GradTalkColors.lightFont,
                          fontSize: 20,
                        ),
                      ),
                      onTap: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage(),
                          ))
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                        text: "Don't have an account?    ",
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onClickedSignUp,
                            text: 'Sign Up',
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: GradTalkColors.primary,
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ]
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signIn() async {
    //Checks if entered info is valid and then sends user to page depending on role
    if (_signInKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      await loginService
          .login(_emailController.text.trim(), _passwordController.text.trim())
          .then((value) async {
        if (value == true) {

          QuerySnapshot snapshot =
          await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
              .getUserData(FirebaseAuth.instance.currentUser!.uid);
          // saving the values to our shared preferences
          String userRole = snapshot.docs[0]['role'];
          if(userRole == "Mentor"){
            if(!mounted) return;
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => const Mentor()
            ));
          } else if (userRole == "Parent") {
            if(!mounted) return;
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => const Student()
            ));
          } else {
            if(!mounted) return;
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => const ErrorScreen()
            ));
            Utils.showSnackBar("Not a valid role");
          }
        } else {
          Utils.showSnackBar("Wrong email/password");
          setState(() {
            _loading = false;
          });
        }
      });
    }
  }
}