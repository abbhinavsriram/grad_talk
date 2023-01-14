import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_talk/widgets/widgets.dart';

import 'database_services.dart';

class LoginServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  Future login(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user!;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return Utils.showSnackBar(e.message);
    }
  }

  Future registerUser(
      String name,
      String email,
      String password,
      String college,
      String career,
      String description,
      String extracurriculars,
      String major,
      String role,
      String scores,
      String transcript,
      String year,
      ) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password))
          .user!;

      if (user != null) {
        // call our database service to update the user data.
        await DatabaseService(uid: user.uid).saveUserData(
            name,
            email,
            college,
            career,
            description,
            extracurriculars,
            major,
            role,
            scores,
            transcript,
            user.uid,
            year,
            false,
            "none",
            false
        );
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

}