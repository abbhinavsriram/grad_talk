import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/database_services.dart';

import 'package:grad_talk/student_view/student_widgets/studentNavBar.dart';
import '../student_view/pages.dart';
import '../theme.dart';


class ReviewPage extends StatefulWidget {

  final String mentorID;
  const ReviewPage({
    Key? key,
    required this.mentorID,
  }) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();

}


class _ReviewPageState extends State<ReviewPage> {

/*
Credit for dropdown menu:
Fernando, Ishan. “Creating a Dropdown List in Flutter.” LogRocket Blog, Log Rocket, 27 Aug. 2021, 
  https://blog.logrocket.com/creating-dropdown-list-flutter/. 
*/
  List<DropdownMenuItem<String>> get ratingDropdown{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "5", child: Text("5")),
      const DropdownMenuItem(value: "4", child: Text("4")),
      const DropdownMenuItem(value: "3", child: Text("3")),
      const DropdownMenuItem(value: "2", child: Text("2")),
      const DropdownMenuItem(value: "1", child: Text("1")),
    ];
    return menuItems;
  }
  GlobalKey<FormState> _reviewKey = GlobalKey<FormState>();
  TextEditingController _reviewController = TextEditingController();
  String selectedItem = "5";
  bool _loading = false;
  @override
  void dispose(){
    _reviewController.dispose();

    super.dispose();
  }


  @override
  //Allows user to review their mentor
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: StudentNavBar(),
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
              key: _reviewKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 25),
                  const Text("Write a review for your mentor",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: DropdownButtonFormField<String>(
                      value: selectedItem,
                      onChanged: (String? newValue){
                        setState((){
                          selectedItem = newValue!;
                        });
                      },
                      items: ratingDropdown,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),

                    child: TextFormField(
                      maxLines: 7,
                      controller: _reviewController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: GradTalkColors.primary),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        hintText: "Write your review here",
                      ),
                      validator: (value) => value != null && value.length < 50
                          ? 'Minimum 50 characters'
                          : null,
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: GestureDetector(
                      onTap: () => newReview(),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: GradTalkColors.primary,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Center(
                          child: Text("Add review (5 - amazing, 1 - terrible)", style: TextStyle(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: GestureDetector(
                      onTap: () {
                        _reviewController.clear();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: GradTalkColors.primary,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Center(
                          child: Text("Cancel Review", style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                          ),
                        ),
                      ),
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


  Future newReview() async {
    //Checks if review is valid and uploads to database
    if (_reviewKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      QuerySnapshot mentor = await DatabaseService().getUserData(widget.mentorID);
      String newMentorId = mentor.docs[0]["uid"];
      await DatabaseService().addReview(
        newMentorId,
        FirebaseAuth.instance.currentUser!.uid,
        _reviewController.text.trim(),
        selectedItem,
      )
      .then((value) async {
        _reviewController.clear();
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const Student()
        ));
      
      });
    }
  }
}
