import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_talk/screens/screens.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


import '../main.dart';
import '../mentor_view/mentor_pages.dart';
import '../student_view/pages.dart';
import '../theme.dart';


class SignUpWidget extends StatefulWidget {

  final Function() onClickedSignIn;
  const SignUpWidget({Key? key, required this.onClickedSignIn}) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _transcriptController = TextEditingController();
  final _standardizedController = TextEditingController();
  final _extracurricularsController = TextEditingController();
  final _collegeController = TextEditingController();
  final _careerController = TextEditingController();
  final _majorController = TextEditingController();
  final _yearController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _nameController = TextEditingController();

  //Credit for Dropdown menu : https://blog.logrocket.com/creating-dropdown-list-flutter/
  List<DropdownMenuItem<String>> get rolesDropdown{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Parent"),value: "Parent"),
      const DropdownMenuItem(child: Text("Mentor"),value: "Mentor"),
    ];
    return menuItems;
  }
  String selectedItem = "Parent";


  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _transcriptController.dispose();
    _standardizedController.dispose();
    _extracurricularsController.dispose();
    _collegeController.dispose();
    _careerController.dispose();
    _majorController.dispose();
    _yearController.dispose();
    _descriptionController.dispose();
    _nameController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "GradTalk",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: SafeArea(
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                          ? 'Enter a valid email'
                          : null,
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
                      ),
                      validator: (value) => value != null && value.length < 6
                        ? 'Minimum 6 characters'
                          : null,
                    ),

                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),

                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.accent),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        hintText: "Enter your name",
                      ),

                    ),

                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: DropdownButtonFormField<String>(
                      value: selectedItem,
                      onChanged: (String? newValue){
                        setState((){
                          selectedItem = newValue!;
                        });
                      },
                      items: rolesDropdown,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),

                    child: TextFormField(
                      maxLines: 10,
                      controller: _transcriptController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.accent),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        hintText: "FOR PARENTS ONLY. Enter your child's grades here",
                      ),

                    ),

                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),

                    child: TextFormField(
                      maxLines: 5,
                      controller: _standardizedController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.accent),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        hintText: "Standardized test scores",
                      ),

                    ),

                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),

                    child: TextFormField(
                      maxLines: 10,
                      controller: _collegeController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.accent),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        hintText: "Intended college/current college",
                      ),
                    ),

                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),

                    child: TextFormField(
                      maxLines: 10,
                      controller: _extracurricularsController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.accent),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        hintText: "Please enter your child's/your extracurriculars here",
                      ),

                    ),

                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),

                    child: TextFormField(
                      controller: _majorController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.accent),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        hintText: "Major",
                      ),

                    ),

                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),

                    child: TextFormField(
                      controller: _careerController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.accent),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        hintText: "Career interest",
                      ),

                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),

                    child: TextFormField(
                      controller: _yearController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.accent),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        hintText: "Graduating year from college",
                      ),

                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),

                    child: TextFormField(
                      maxLines: 7,
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.accent),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        hintText: "Please give a short introduction",
                      ),
                    ),

                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: GestureDetector(
                      onTap: () => signUp(),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Center(
                          child: Text("Register", style: TextStyle(
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Center(
                        child: Text("Register a new account", style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          text: "Already have an account?    ",
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = widget.onClickedSignIn,
                              text: "Log in",
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue
                              ),
                            ),
                          ]
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Future signUp() async{
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
      );
      add(
          userCredential.user?.uid,
          selectedItem,
          _yearController.text.trim(),
          _majorController.text.trim(),
          _descriptionController.text.trim(),
          _nameController.text.trim(),
          _standardizedController.text.trim(),
          _transcriptController.text.trim(),
          _collegeController.text.trim(),
          _extracurricularsController.text.trim(),
          _careerController.text.trim(),
      );
      print(userCredential.user?.uid);
      print(_collegeController.text);
      print(_yearController.text);
      print(_emailController.text);
      print(_passwordController.text);
      print(_transcriptController.text);
      print(_standardizedController.text);
      print(_extracurricularsController.text);
      print(_careerController.text);
      print(_majorController.text);
      print(_yearController.text);
      print(_descriptionController.text);
      print(_nameController.text);

      _emailController.text = "";
      _passwordController.text = "";
      _transcriptController.text = "";
      _standardizedController.text = "";
      _extracurricularsController.text = "";
      _collegeController.text = "";
      _careerController.text = "";
      _majorController.text = "";
      _yearController.text = "";
      _descriptionController.text = "";
      _nameController.text = "";

      RouterPage();

    } on FirebaseAuthException catch (e){
      print(e.toString());
      return const ErrorScreen();

    }
  }

  void add(uid, role, year, major, description, name, scores, transcript, college, extracurriculars, career) async{
    final users = FirebaseFirestore.instance.collection('users').doc(uid);

    await users.set({
      'role': role,
      'year': year,
      'major': major,
      'description': description,
      'name': name,
      'scores': scores,
      'transcript': transcript,
      "college": college,
      "extracurriculars": extracurriculars,
      "career": career,
      "maxConnections": 1,
      "uid": uid,
      "currentConnections": 0,
      "groupId": 0,
    });
  }
}
