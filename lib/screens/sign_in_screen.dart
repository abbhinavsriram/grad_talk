import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/login_services.dart';
import 'package:grad_talk/mentor_view/mentor_home_page.dart';
import 'package:grad_talk/student_view/home_page.dart';
import 'package:grad_talk/student_view/login_page.dart';
import 'package:grad_talk/theme.dart';
import'package:firebase_auth/firebase_auth.dart';
import 'package:grad_talk/screens/screens.dart';
import '../database_services.dart';
import '../main.dart';
import 'package:grad_talk/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LoginWidget({Key? key, required this.onClickedSignUp}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
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
                  color: AppColors.accent,
                )
      )
      : SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
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
                              borderSide: BorderSide(color: AppColors.accent),
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
                              borderSide: BorderSide(color: AppColors.accent),
                              borderRadius: BorderRadius.circular(12)
                          ),
                          hintText: "Password",
                          focusColor: AppColors.secondary
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
                            color: AppColors.accent,
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
                          color: AppColors.textLight,
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
                                color: AppColors.accent,
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
    if (formKey.currentState!.validate()) {
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