
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:grad_talk/login_services.dart';
import 'package:grad_talk/login_screens/screens.dart';
import '../mentor_view/mentor_pages.dart';
import '../models/models.dart';
import '../student_view/pages.dart';
import '../theme.dart';
import '../widgets/widgets.dart';


class SignUpWidget extends StatefulWidget {

  final Function() onClickedSignIn;
  const SignUpWidget({Key? key, required this.onClickedSignIn}) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();

}
GlobalKey<FormState> _registerKey = GlobalKey<FormState>();
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _transcriptController = TextEditingController();
TextEditingController _standardizedController = TextEditingController();
TextEditingController _extracurricularsController = TextEditingController();
TextEditingController _collegeController = TextEditingController();
TextEditingController _careerController = TextEditingController();
TextEditingController _majorController = TextEditingController();
TextEditingController _yearController = TextEditingController();
TextEditingController _descriptionController = TextEditingController();
TextEditingController _nameController = TextEditingController();

class _SignUpWidgetState extends State<SignUpWidget> {

  /*Credit for Dropdown menu:
  Flutter. “Dropdownbutton Class Null Safety.” DropdownButton Class - Material Library - Dart API, Google, 
    https://api.flutter.dev/flutter/material/DropdownButton-class.html.


    Credit for textbox element:
    Developers, Stream. “Build a Flutter Chat App: 01 - Design/UI.” YouTube, YouTube, 20 Aug. 2021, 
      https://www.youtube.com/watch?v=vgqBc7jni8c. 

    Credit for firebase connection:
    Flutter, Backslash. “Chat App in Flutter and Firebase | Tutorial for Beginners to Advance | Android &amp; IOS (Latest).” YouTube, YouTube, 26 July 2022, 
      https://www.youtube.com/watch?v=Qwk5oIAkgnY. 

  */
  List<String> roles = ["Parent", "Mentor"];
  List<String> confirm = ["yes", "no"];
  String selectedRole = "Parent";
  String selectedAge = "no";
  
  bool _loading = false;
  LoginServices loginService = LoginServices();
  @override
  //prevents memory leaks by destroying widgets
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
      ) : SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _registerKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 25),
                  const Text("Register on GradTalk",
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
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: GradTalkColors.primary),
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
                    ),

                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),

                    child: TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: GradTalkColors.primary),
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
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: GradTalkColors.primary),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        hintText: "Enter your name",
                      ),

                    ),

                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Select the role you want",
                    style: TextStyle(fontSize: 17)
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: DropdownButton<String>(
                      value: selectedRole,
                      items: roles.map((newSelection) => DropdownMenuItem<String>(
                          value: newSelection,
                          child: Text(newSelection, style: TextStyle(fontSize: 18))
                        )
                      ).toList(),
                      onChanged: (newSelection) => setState(() {
                        selectedRole = newSelection as String;
                      }),
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
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: GradTalkColors.primary),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        hintText: "Enter relevant transcript information here",
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
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: GradTalkColors.primary),
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
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: GradTalkColors.primary),
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
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: GradTalkColors.primary),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        hintText: "Please enter your extracurriculars here",
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
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: GradTalkColors.primary),
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
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: GradTalkColors.primary),
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
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: GradTalkColors.primary),
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
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: GradTalkColors.primary),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        hintText: "Please give a short introduction",
                      ),
                    ),

                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "I confirm that I am at least 15 years old",
                    style: TextStyle(fontSize: 17)
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: DropdownButton<String>(
                      value: selectedAge,
                      items: confirm.map((selection) => DropdownMenuItem<String>(
                          value: selection,
                          child: Text(selection, style: TextStyle(fontSize: 18))
                        )
                      ).toList(),
                      onChanged: (selection) => setState(() {
                        selectedAge = selection as String;
                      }),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: GestureDetector(
                      onTap: () => signUp(),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: GradTalkColors.primary,
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
                  const SizedBox(height: 20),
                  RichText(
                      text: TextSpan(
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                          text: "Already have an account?    ",
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = widget.onClickedSignIn,
                              text: "Log in",
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: GradTalkColors.primary,
                                fontWeight: FontWeight.bold
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


  Future signUp() async {
    //Creates new user in the database

    if (_registerKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });

      if(selectedAge == "no"){
        setState(() {
          _loading = false;
        });
        return Utils.showSnackBar("You must be at least 15 years old to use GradTalk");
      }
      if(selectedRole == "Parent"){
        StudentUser newStudent = StudentUser(
          name: _nameController.text.trim(), 
          email:  _emailController.text.trim(), 
          college: _collegeController.text.toLowerCase().trim(), 
          career: _careerController.text.trim(), 
          description: _descriptionController.text.trim(), 
          extracurriculars: _extracurricularsController.text.trim(), 
          major: _majorController.text.toLowerCase().trim(), 
          role: selectedRole,
          scores: _standardizedController.text.trim(), 
          transcript: _transcriptController.text.trim(), 
          id: "none", 
          year:  _yearController.text.trim(),
          currentlyConnected: false, 
          groupID: "none",
          token: "", 
          request: "none",
        );
        await loginService.registerStudent(_passwordController.text.trim(), newStudent).then((value) async {
            if (value == true) {
              clearTextFields();
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const Student()
              ));
            } else {
              setState(() {
                _loading = false;
              });
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => const ErrorScreen()
              ));
              Utils.showSnackBar("Cannot retrieve data");
              print(value);
            }
        });
      }  else {
        MentorUser newMentor = MentorUser(
          name: _nameController.text.trim(), 
          email:  _emailController.text.trim(), 
          college: _collegeController.text.toLowerCase().trim(), 
          career: _careerController.text.trim(), 
          description: _descriptionController.text.trim(), 
          extracurriculars: _extracurricularsController.text.trim(), 
          major: _majorController.text.toLowerCase().trim(), 
          role: selectedRole,
          scores: _standardizedController.text.trim(), 
          transcript: _transcriptController.text.trim(), 
          id: "none", 
          year:  _yearController.text.trim(),
          currentlyConnected: false, 
          groupID: "none",
          token: "",
          numRatings: 0,
          rating: 0,
          isMuted: false,
        );
        await loginService.registerMentor(_passwordController.text.trim(), newMentor).then((value) async {
            if (value == true) {
              clearTextFields();
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const Mentor()
              ));
            } else {
              setState(() {
                _loading = false;
              });
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => const ErrorScreen()
              ));
              Utils.showSnackBar("Cannot retrieve data");
              print(value);
            }
        });
      }
    }
  }


  void clearTextFields(){
    //clears all text from text fields
    _emailController.clear();
    _passwordController.clear();
    _transcriptController.clear();
    _standardizedController.clear();
    _extracurricularsController.clear();
    _collegeController.clear();
    _careerController.clear();
    _majorController.clear();
    _yearController.clear();
    _descriptionController.clear();
    _nameController.clear();
  }
}
