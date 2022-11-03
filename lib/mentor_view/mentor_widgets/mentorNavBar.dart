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
    SettingsPage(),
    ReportPage(),
  ];

  void selectedItem(BuildContext context, int index) {
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
              onTap: () => authentication()
          ),
          const SizedBox(height: 16),
          ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () => selectedItem(context, 1)
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.chat_bubble_outline_rounded),
            title: const Text("Chat"),
            onTap: () => selectedItem(context, 2),
            trailing: ClipOval(
              child: Container(
                color: AppColors.accent,
                width: 20,
                height: 20,
                child: const Center(
                  child: Text(
                    "8",
                    style: TextStyle(
                      color: AppColors.textDark,
                      fontSize: 12,
                    )
                  )
                )
              )
            )
          ),

          const SizedBox(height: 16),
          ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Mentors Profile"),
              onTap: () => selectedItem(context, 3)
          ),
          const SizedBox(height: 16),
          ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () => selectedItem(context, 4)
          ),
          const SizedBox(height: 16),
          ListTile(
              leading: const Icon(Icons.report),
              title: const Text("Report Mentor"),
              onTap: () => selectedItem(context, 5)
          ),
          const SizedBox(height: 16),
          ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
    );
  }


  void authentication(){
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser?.uid);
    }
    else{
      print("yello");
    }
  }
}
