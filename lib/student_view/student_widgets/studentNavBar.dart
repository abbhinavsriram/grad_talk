import 'package:grad_talk/database_services.dart';
import 'package:grad_talk/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/student_view/pages.dart';
import 'package:grad_talk/theme.dart';
import 'package:grad_talk/student_view/pages.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../student_view/home_page.dart';

class StudentNavBar extends StatelessWidget {
  StudentNavBar({Key? key}) : super(key: key);
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  final pages = const [
    ProfilePage(),
    Student(),
    ConvScreen(),
    MentorProfilePage(),
    ErrorScreen(),
    ReportPage(),
    AuthPage(),
    SearchPage()
  ];

  void pageRouter(BuildContext context, int index) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => pages[index]
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(
        padding: padding,
        children: [
          const SizedBox(height: 50),
          const ListTile(
              title: Center(child: Text("GradTalk", style: TextStyle(fontSize: 20)))
          ),
          const SizedBox(height: 16),
          ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {
                pageRouter(context, 0);
              }          ),
          const SizedBox(height: 16),
          ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                pageRouter(context, 1);
              }
          ),
          const SizedBox(height: 16),
          ListTile(
              leading: const Icon(Icons.chat_bubble_outline_rounded),
              title: const Text("Chat"),
              onTap: () => pageRouter(context, 2),
          ),
          const SizedBox(height: 16),
          ListTile(
              leading: const Icon(Icons.search),
              title: const Text("Find new graduates"),
              onTap: () {
                pageRouter(context, 7);
              }
          ),
          const SizedBox(height: 16),
          ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Mentor's Profile"),
              onTap: () {
                pageRouter(context, 3);
              }),
          const SizedBox(height: 16),
          ListTile(
              leading: const Icon(Icons.report),
              title: const Text("Report Mentor"),
              onTap: () {
                pageRouter(context, 5);
              }
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
                  const AuthPage()));
            },
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () => DatabaseService().endConversation('mentor'),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: const Center(
                child: Text("End Conversation", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}




/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_talk/screens/screens.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/theme.dart';
import "package:grad_talk/student_view/pages.dart";
import 'package:firebase_auth/firebase_auth.dart';




class StudentNavBar extends StatelessWidget {
  const StudentNavBar({Key? key}) : super(key: key);
  final padding = const EdgeInsets.symmetric(horizontal: 20);


  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(height: 50),
              const DrawerHeader(
                child: Text('GradTalk'),
              ),
              const SizedBox(height: 16),
              ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("Home"),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Student()));
                    Navigator.pop(context);
                  }
              ),
              const SizedBox(height: 16),
              ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Your Profile"),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const ProfilePage()));
                    Navigator.pop(context);
                  }
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.chat_bubble_outline_rounded),
                title: const Text("Chat"),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const ConvScreen()));
                  Navigator.pop(context);
                }
              ),
              const SizedBox(height: 16),
              ListTile(
                  leading: const Icon(Icons.search),
                  title: const Text("Find new graduates"),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const SearchPage()));
                    Navigator.pop(context);
                  }
              ),
              const SizedBox(height: 16),
              ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Mentor Profile"),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const MentorProfilePage()));
                    Navigator.pop(context);
                  }
              ),

              const SizedBox(height: 16),
              ListTile(
                  leading: const Icon(Icons.report),
                  title: const Text("Report Mentor"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const ReportPage()));
                    Navigator.pop(context);
                  }
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
                  const AuthPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/