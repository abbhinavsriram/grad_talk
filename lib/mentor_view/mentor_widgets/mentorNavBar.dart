import 'package:grad_talk/database_services.dart';
import 'package:grad_talk/screens/screens.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/theme.dart';
import "package:grad_talk/mentor_view/mentor_pages.dart";
import 'package:firebase_auth/firebase_auth.dart';

import '../../student_view/home_page.dart';


class NavBar extends StatelessWidget {
  NavBar({Key? key}) : super(key: key);
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  final pages = const [
    MentorProfilePage(),
    Mentor(),
    ConvScreen(),
    MentorProfilePage(),
    ReportPage(),
    StudentInfoPage(),
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
              leading: const Icon(Icons.person),
              title: const Text("Your Profile"),
              onTap: () {
                pageRouter(context, 3);
              }),
          const SizedBox(height: 16),
          ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Student's Profile"),
              onTap: () {
                pageRouter(context, 5);
              }),
          const SizedBox(height: 16),
          ListTile(
              leading: const Icon(Icons.report),
              title: const Text("Report Parent"),
              onTap: () {
                pageRouter(context, 4);
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
