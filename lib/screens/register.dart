
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:grad_talk/login_services.dart';
import 'package:grad_talk/screens/screens.dart';
import '../mentor_view/mentor_pages.dart';
import '../student_view/pages.dart';
import '../theme.dart';
import '../widgets/widgets.dart';


class SignUpWidget extends StatefulWidget {

  final Function() onClickedSignIn;
  const SignUpWidget({Key? key, required this.onClickedSignIn}) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();

}
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

class _SignUpWidgetState extends State<SignUpWidget> {

  //Credit for Dropdown menu : https://blog.logrocket.com/creating-dropdown-list-flutter/
  List<DropdownMenuItem<String>> get rolesDropdown{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Parent", child: Text("Parent")),
      const DropdownMenuItem(value: "Mentor", child: Text("Mentor")),
    ];
    return menuItems;
  }
  String selectedItem = "Parent";
  bool _loading = false;
  LoginServices loginService = LoginServices();
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
      ) : SafeArea(
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
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: AppColors.accent),
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
                            borderSide: const BorderSide(color: AppColors.accent),
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
                            borderSide: const BorderSide(color: AppColors.accent),
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
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.accent),
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
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.accent),
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
                            borderSide: const BorderSide(color: AppColors.accent),
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
                            borderSide: const BorderSide(color: AppColors.accent),
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
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.accent),
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
                            borderSide: const BorderSide(color: AppColors.accent),
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
                            borderSide: const BorderSide(color: AppColors.accent),
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
                            borderSide: const BorderSide(color: AppColors.accent),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        hintText: "Please give a short introduction",
                      ),
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
                                color: AppColors.accent,
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
    if (formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      await loginService.registerUser(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _collegeController.text.toLowerCase().trim(),
        _careerController.text.trim(),
        _descriptionController.text.trim(),
        _extracurricularsController.text.trim(),
        _majorController.text.toLowerCase().trim(),
        selectedItem,
        _standardizedController.text.trim(),
        _transcriptController.text.trim(),
        _yearController.text.trim(),
      )
          .then((value) async {
        if (value == true) {
          if (selectedItem == "Mentor") {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => const Mentor()
            ));
          } else if (selectedItem == "Parent") {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => const Student()
            ));
          } else {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => const ErrorScreen()
            ));
            Utils.showSnackBar("Not a valid role");
            print(selectedItem);
          }
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
