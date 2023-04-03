import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_talk/models/models.dart';
import 'package:grad_talk/widgets/widgets.dart';

import 'database_services.dart';
import 'notification_services.dart';

class LoginServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  Future login(String email, String password) async {
    //Validates login info entered by the user
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user!;

      if (user != null) {
        NotificationServices().newToken();
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return Utils.showSnackBar(e.message);
    }
  }

  Future registerMentor(String password, MentorUser newMentor) async {
    //Creates a new account for mentor users.
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
          email: newMentor.email, password: password))
          .user!;

      if (user != null) {
        // call our database service to update the user data.
        newMentor.id = user.uid;
        await DatabaseService(uid: user.uid).saveMentorData(newMentor);

        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
  Future registerStudent(String password, StudentUser newStudent) async {
    //Creates new account for student users
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
          email: newStudent.email, password: password))
          .user!;

      if (user != null) {
        // call our database service to update the user data.
        newStudent.id = user.uid;
        await DatabaseService(uid: user.uid).saveStudentData(newStudent);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

}