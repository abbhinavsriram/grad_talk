import 'package:grad_talk/database_services.dart';
import 'package:grad_talk/login_screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/student_view/pages.dart';
import 'package:grad_talk/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Sidebar menu for student module
class StudentNavBar extends StatelessWidget {
  StudentNavBar({Key? key}) : super(key: key);
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  //array of all pages available for student user
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
            onTap: () {
              DatabaseService().endConversation('Mentor');
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: GradTalkColors.primary,
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
