import 'package:flutter/material.dart';
import 'package:grad_talk/notification_services.dart';
import 'package:grad_talk/student_view/home_page.dart';
import'package:firebase_auth/firebase_auth.dart';
import 'package:grad_talk/timer_services.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:grad_talk/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_talk/models/models.dart';



class DatabaseService {

  final String? uid;
  DatabaseService({
    this.uid
  });

  /*s
  Credit for CRUD syntax:
  Milke, Johannes. “Flutter Firebase Crud (Create, Read, Update, Delete).” YouTube, YouTube, 14 Apr. 2022, 
    https://www.youtube.com/watch?v=ErP_xomHKTw. 
  
  */
  final CollectionReference users = FirebaseFirestore.instance.collection("users");
  final CollectionReference groups = FirebaseFirestore.instance.collection("groups");
  final CollectionReference reports = FirebaseFirestore.instance.collection("reports");
  //gets user information from database
  Future<QuerySnapshot> getUserData(String userID) async {
    QuerySnapshot snapshot = await users.where("uid", isEqualTo: userID).get();
    return snapshot;
  }
  //Creates group
  Future createGroup(String mentorID, String parentID) async {
    QuerySnapshot snapshot = await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserData(FirebaseAuth.instance.currentUser!.uid);
    if(snapshot.docs[0]['currentlyConnected'] != false){
      return Utils.showSnackBar("You are currently connected to a mentor");
    }
    DocumentReference groupDR = await groups.add({
      "Mentor": mentorID,
      "Parent": parentID,
      "dateCreated": DateTime.now(),
      "groupId": ""
    });
    //We do not know what the ID will be yet when the document reference is first called
    //This is why we update it afterwards
    await groupDR.update({
      "groupId": groupDR.id
    });
    DocumentReference parentDR = users.doc(parentID);
    await parentDR.update({
      "currentlyConnected": true,
      "groupId": groupDR.id,
      "request": "none",
    });
    DocumentReference mentorDR = users.doc(mentorID);
    await mentorDR.update({
      "currentlyConnected": true,
      "groupId": groupDR.id
    });
    //automatically changes all other requests to "none" once one is accepted
    WriteBatch batch = FirebaseFirestore.instance.batch();
    FirebaseFirestore.instance.collection("users").get().then((querySnapshot) {
        querySnapshot.docs.forEach((document) {
        try {
          if (document.data()['request'] == mentorID) {
            batch.update(document.reference,
                {"request": "none"});
            NotificationServices().sendMessage(document.data()['uid'], "Request update", "Your request was denied");
          }
        } on FormatException catch (error) {

          print("The following error was found: ${error.source}");
        }
      });
    });
    NotificationServices().sendMessage(parentID, "New group", "Your request was accepted");
    NotificationServices().sendMessage(mentorID, "New group", "You created a new group");
    TimerService().startTimer();

  }

  //changes request section to null
  Future rejectRequest(String studentID) async {
    users.doc(studentID).update({
      'request': "none"
    });
    NotificationServices().sendMessage(studentID, "Request update", "Your request was rejected");

  }

  //adds report to database
  Future addReport(String report, String userID) async {
    await reports.add({
      "text": report,
      "id": userID,
      "time": DateTime.now(),
    });

  }

  //saves student data to database
  Future saveStudentData(StudentUser newUser) async {
    await users.doc(uid).set({
      "name": newUser.name,
      "email": newUser.email,
      "career": newUser.career,
      "currentlyConnected": newUser.currentlyConnected,
      "description": newUser.description,
      "extracurriculars": newUser.extracurriculars,
      "major": newUser.major,
      "groupId": newUser.groupID,
      "role": newUser.role,
      "scores": newUser.scores,
      "transcript": newUser.transcript,
      "uid": newUser.id,
      "year": newUser.year,
      "college": newUser.college,
      "request": "none",
      "token": "",
      "majorCombination": setCombinations(newUser.major),
      "collegeCombination": setCombinations(newUser.college),
    });
    NotificationServices().newToken();
  }
  //saves mentor data to database
  Future saveMentorData(MentorUser newUser) async {
    await users.doc(uid).set({
      "name": newUser.name,
      "email": newUser.email,
      "career": newUser.career,
      "currentlyConnected": newUser.currentlyConnected,
      "description": newUser.description,
      "extracurriculars": newUser.extracurriculars,
      "major": newUser.major,
      "groupId": newUser.groupID,
      "role": newUser.role,
      "scores": newUser.scores,
      "transcript": newUser.transcript,
      "uid": newUser.id,
      "year": newUser.year,
      "college": newUser.college,
      "muted": newUser.isMuted,
      "numRatings": newUser.numRatings,
      "average": newUser.rating,
      "token": "",
      "majorCombination": setCombinations(newUser.major),
      "collegeCombination": setCombinations(newUser.college),
    });
    NotificationServices().newToken();
  }
  //Checks if user is part of group. If so, returns array of messages. Otherwise, outputs error
  getAllMessages(context) async {

    QuerySnapshot snapshot = await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserData(FirebaseAuth.instance.currentUser!.uid);
    // saving the values to our shared preferences
    String groupID = snapshot.docs[0]['groupId'];
    if(groupID == "none"){
      Navigator.of(context).pop(MaterialPageRoute(
          builder: (context) => const Student()
      ));
      Utils.showSnackBar("Please join a group first");

    } else {
      print(groupID);
      print(groups.doc(groupID).collection('messages').snapshots());
      return groups.doc(groupID).collection('messages').orderBy("time").snapshots();
    }
  }
  //uploads message to database
  sendNewMessage(String groupId, String text, String userID, DateTime time, String field) async {
    groups.doc(groupId).collection("messages").add({
      "text": text,
      "groupId": groupId,
      "senderId": userID,
      "time": time.toString()
    });

    QuerySnapshot otherUser = await getOtherID(field);
    String otherID = otherUser.docs[0]['uid'];

    print(otherID);
    NotificationServices().sendMessage(otherID, "New message", text);

  }
  //sends request from student to mentor
  Future sendRequest(String mentorID, String parentID) async {
    QuerySnapshot snapshot = await getUserData(FirebaseAuth.instance.currentUser!.uid);
    if(snapshot.docs[0]['currentlyConnected'] == false){
      await users.doc(parentID).update({
        "request": mentorID,  
      });

      NotificationServices().sendMessage(mentorID, "New request", "You received a new request!");
      return Utils.showSnackBar("Request sent!");
    } 
    else {
      return Utils.showSnackBar("You are currently connected to a mentor");
    }
  }

  //adds review to mentor's collection. Updates number of reviews and average
  addReview(String uid, String reviewer, String review, String rating) async {
    
    bool isProfane = ProfanityFilter().hasProfanity(review);
    if(isProfane){
      return Utils.showSnackBar("Review is inappropriate");
    } else{
      users.doc(uid).collection("reviews").add({
        "rating": int.parse(rating),
        "review": review,
        "reviewer": reviewer,
        "time": DateTime.now()
      });

      QuerySnapshot mentor = await DatabaseService().getUserData(uid);
      double average = mentor.docs[0]['average'];
      double numRatings = mentor.docs[0]['numRatings'];
      double total = average * numRatings;
      total += int.parse(rating);
      numRatings += 1;
      double newAverage = total / (numRatings);
      users.doc(uid).update({
        "average": newAverage,
        "numRatings": numRatings
      });
      NotificationServices().sendMessage(uid, "New review", "You received a new review");  

    }
    
  }

  //updates database for both mentor and student
  endConversation(String field) async {
    QuerySnapshot snapshot = await getUserData(FirebaseAuth.instance.currentUser!.uid);
    if(snapshot.docs[0]['currentlyConnected'] == false){
      return Utils.showSnackBar("You are not connected to another person right now");
    }
    QuerySnapshot snapshot2 = await getOtherID(field);

    DocumentReference currentDR = users.doc(FirebaseAuth.instance.currentUser!.uid);
    NotificationServices().sendMessage(FirebaseAuth.instance.currentUser!.uid, "Converstion ended", "Your conversation was ended");
    await currentDR.update({
      "currentlyConnected": false,
      "groupId": "none"
    });
    String mentorID = snapshot2.docs[0]['uid'];
    NotificationServices().sendMessage(mentorID, "Conversation ended", "Your conversation was ended");
    DocumentReference mentorDR = users.doc(mentorID);
    await mentorDR.update({
      "currentlyConnected": false,
      "groupId": "none"
    });


  }

  //gets groupID for a specific user ID
  Future<String> getGroupId(String userid) async {
    QuerySnapshot snapshot = await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserData(FirebaseAuth.instance.currentUser!.uid);
    // saving the values to our shared preferences
    print(snapshot.docs[0]['groupId']);
    print('Test');
    print(FirebaseAuth.instance.currentUser!.uid);
    String groupID = snapshot.docs[0]['groupId'];
    return groupID;
  }

  //gets ID of the other person in the group
  Future<QuerySnapshot> getOtherID(String field) async {
    String groupID = await DatabaseService().getGroupId(FirebaseAuth.instance.currentUser!.uid);
    QuerySnapshot snapshot = await groups.where("groupId", isEqualTo: groupID).get();
    String mentorId = snapshot.docs[0][field];
    snapshot = await getUserData(mentorId);
    print("Snapshot sent");
    return snapshot;

  }
  //Creates array, with each indexed space containing a combination of the inputted word, allowing for keywords to be used in search
  setCombinations(String data) {
    List<String> combinationList = [];
    String combination = "";
    for (int i = 0; i < data.length; i++) {
      combination = combination + data[i];
      combinationList.add(combination);
    }
    return combinationList;
  }

  //checks if user is eligible to provide a review
  Future<bool> canReview(String reviewer, String mentorID) async {
    bool hasConnected = false;

    await FirebaseFirestore.instance.collection("groups").get().then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
      try {
          if ((document.data()['Parent'] == reviewer) && (document.data()['Mentor'] == mentorID)) {
            hasConnected = true;
          }
        } on FormatException catch (error) {
          print("The following error was found: ${error.source}");
        }
      });
    });
    await FirebaseFirestore.instance.collection("users").doc(mentorID).collection('reviews').get().then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        try {
          print(document.data()['reviewer']);
          print(reviewer);
          if (document.data()['reviewer'] == reviewer) {
            print("this condition works too");
            hasConnected = false;
          }
        } on FormatException catch (error) {

          print("The following error was found: ${error.source}");
        }
      });
      print(hasConnected);
      return hasConnected;

    });
    return hasConnected;

    
  }

}
