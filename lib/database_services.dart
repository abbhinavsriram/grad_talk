import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/login_services.dart';
import 'package:grad_talk/mentor_view/mentor_home_page.dart';
import 'package:grad_talk/student_view/home_page.dart';
import 'package:grad_talk/student_view/login_page.dart';
import 'package:grad_talk/theme.dart';
import'package:firebase_auth/firebase_auth.dart';
import 'package:grad_talk/screens/screens.dart';
import '../main.dart';
import 'package:grad_talk/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService {

  final String? uid;
  DatabaseService({
    this.uid
  });


  final CollectionReference users = FirebaseFirestore.instance.collection("users");
  final CollectionReference groups = FirebaseFirestore.instance.collection("groups");

  Future<QuerySnapshot> getUserData(String userID) async {
    QuerySnapshot snapshot = await users.where("uid", isEqualTo: userID).get();
    return snapshot;
  }
  //Creates group, but does not check if parent has more than one connection
  Future createGroup(String mentorID, String parentID) async {
    QuerySnapshot snapshot = await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserData(FirebaseAuth.instance.currentUser!.uid);
    if(snapshot.docs[0]['currentlyConnected'] != false){
      return Utils.showSnackBar("You are currently connected to a mentor");
    }
    DocumentReference groupDR = await groups.add({
      "mentor": mentorID,
      "parent": parentID,
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
      "groupId": groupDR.id
    });
    DocumentReference mentorDR = users.doc(mentorID);
    await mentorDR.update({
      "currentlyConnected": true,
      "groupId": groupDR.id
    });

  }
  Future saveUserData(
      String name,
      String email,
      String college,
      String career,
      String description,
      String extracurriculars,
      String major,
      String role,
      String scores,
      String transcript,
      String id,
      String year,
      bool currentlyConnected,
      String groupID,
      bool isMuted,
      ) async {
    return await users.doc(uid).set({
      "name": name,
      "email": email,
      "career": career,
      "currentlyConnected": currentlyConnected,
      "description": description,
      "extracurriculars": extracurriculars,
      "major": major,
      "groupId": groupID,
      "role": role,
      "scores": scores,
      "transcript": transcript,
      "uid": id,
      "year": year,
      "majorCombination": setCombinations(major),
      "collegeCombination": setCombinations(college),
      "college": college,
      "muted": isMuted
    });
  }
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
  sendNewMessage(String groupId, String text, String userID, DateTime time) async {
    groups.doc(groupId).collection("messages").add({
      "text": text,
      "groupId": groupId,
      "senderId": userID,
      "time": time.toString()
    });
  }
  endConversation(field) async {
    QuerySnapshot snapshot = await getUserData(FirebaseAuth.instance.currentUser!.uid);
    if(snapshot.docs[0]['currentlyConnected'] == false){
      return Utils.showSnackBar("You are not connected to another person right now");
    }
    QuerySnapshot snapshot2 = await getOtherID(field);

    DocumentReference currentDR = users.doc(FirebaseAuth.instance.currentUser!.uid);
    await currentDR.update({
      "currentlyConnected": false,
      "groupId": "none"
    });
    DocumentReference mentorDR = users.doc(snapshot2.docs[0]['uid']);
    await mentorDR.update({
      "currentlyConnected": false,
      "groupId": "none"
    });

  }

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
  Future<QuerySnapshot> getOtherID(String field) async {
    String groupID = await DatabaseService().getGroupId(FirebaseAuth.instance.currentUser!.uid);
    QuerySnapshot snapshot = await groups.where("groupId", isEqualTo: groupID).get();
    String mentorId = snapshot.docs[0][field];
    snapshot = await getUserData(mentorId);
    print("Snapshot sent");
    return snapshot;

  }

  setCombinations(String data) {
    List<String> combinationList = [];
    String combination = "";
    for (int i = 0; i < data.length; i++) {
      combination = combination + data[i];
      combinationList.add(combination);
    }
    return combinationList;
  }
}


/*

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  final CollectionReference users = FirebaseFirestore.instance.collection("users");
  final CollectionReference userChat = FirebaseFirestore.instance.collection("messages");
  final CollectionReference groups = FirebaseFirestore.instance.collection("groups");

  Future createGroup(String mentorId, String? parentId, context) async {

    print("Create group");
    String parentConnections = getUserData2("users", 'connections', parentId!);
    String mentorConnections = getUserData2("users", 'connections', mentorId);

    if(parentConnections == "false"){
      if(mentorConnections == "false"){
        final groups = FirebaseFirestore.instance.collection('groups').doc(uid);
        await groups.set({
          //fill this in
          'mentorId': mentorId,
          'parentId': parentId,
        });
        return;

      }
      else if(mentorConnections == "true"){
        Utils.showSnackBar("This mentor is already connected with someone else");
        return;
      }
    }

    if(parentConnections == "true"){
      Utils.showSnackBar("You are already connected to a mentor");
      return;
    }

    return ErrorScreen();


  }

  dynamic getUserData(String? uid) async {
    FirebaseFirestore.instance.collection("users")
    .doc(uid).get().then((snapshot) async {
      if(snapshot.exists){
        //TODO: https://www.youtube.com/watch?v=G4INTsatBew
          String name = snapshot.data()!["name"];
          String role = snapshot.data()!["role"];
          String career = snapshot.data()!["career"];
          String college = snapshot.data()!["college"];
          String description = snapshot.data()!["description"];
          String extracurriculars = snapshot.data()!["extracurriculars"];
          String major = snapshot.data()!["major"];
          String scores = snapshot.data()!["scores"];
          String transcript = snapshot.data()!["transcript"];
          String userId = snapshot.data()!["uid"];
          String year = snapshot.data()!["year"];
          String hasConnection = snapshot.data()!["groupId"];

          return [name, role, career, college,
            description, extracurriculars, major, scores,
            transcript, userId, year, hasConnection];
      }
    });
  }

  getUserData2(String collection, String field, String uid) {
    final docRef = FirebaseFirestore.instance.collection(collection).doc(uid);
    docRef.get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        return data[field];
      },
      onError: (e) => print("Error getting document: $e"),

    );
    return "Error";
  }

  updateUserData(String? id, dynamic info){
    FirebaseFirestore.instance.collection("users").doc(id).update({
      "name": info[0],
      "role": info[1],
      "career": info[2],
      "college": info[3],
      "description": info[4],
      "extracurriculars": info[5],
      "major": info[6],
      "scores": info[7],
      "transcript": info[8],
      "uid": info[9],
      "year": info[10],
      "hasConnections": info[11]

    });


  }
  sendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    groups.doc(groupId).collection("messages").add(chatMessageData);
  }


  getChats(String groupId) async {
    return groups.doc(groupId).collection("messages")
        .orderBy("time")
        .snapshots();

  }


}

//check if you are actually calling the users database
class Users {
  String uid;
  String role;
  String name;
  String career;
  String college;
  String description;
  String extracurriculars;
  String major;
  String scores;
  String transcript;
  String year;
  String currentConnections;

  Users({
    this.uid = '',
    this.role = '',
    this.name = '',
    this.career = '',
    this.college = '',
    this.description = '',
    this.extracurriculars = '',
    this.major = '',
    this.scores = '',
    this.transcript = '',
    this.year = '',
    this.currentConnections = 'false',
  });

  factory Users.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Users(
        name: data?['name'],
        role: data?['role'],
        career: data?['career'],
        college: data?['college'],
        description: data?['description'],
        extracurriculars: data?['extracurriculars'],
        major: data?['major'],
        scores: data?['scores'],
        transcript: data?['transcript'],
        uid: data?['uid'],
        year: data?['year'],
        currentConnections: data?['currentConnections']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (role != null) "role": role,
      if (career != null) "career": career,
      if (college != null) "college": college,
      if (description != null) "description": description,
      if (extracurriculars != null) "extracurriculars": extracurriculars,
      if (major != null) "major": major,
      if (scores != null) "scores": scores,
      if (transcript != null) "transcript": transcript,
      if (uid != null) "uid": uid,
      if (year != null) "year": year,
      if (role != null) "currentConnections": currentConnections,

    };
  }



}
class Users{
  String uid;
  String role;
  String name;
  String career;
  String college;
  int maxConnections;
  String description;
  String extracurriculars;
  String major;
  String scores;
  String transcript;
  String year;
  int currentConnections;

  Users({
    this.uid = '',
    this.role = '',
    this.name = '',
    this.career = '',
    this.college = '',
    this.maxConnections = 1,
    this.description = '',
    this.extracurriculars = '',
    this.major = '',
    this.scores = '',
    this.transcript = '',
    this.year = '',
    this.currentConnections = 0,

  });

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'role': role,
    'name': name,
    'career': career,
    'college': college,
    'maxConnections': maxConnections,
    'description': description,
    'extracurriculars': extracurriculars,
    'major': major,
    'scores': scores,
    'transcript': transcript,
    'year': year,
    'currentConnections': currentConnections,

  };

  static Users fromJson(Map<String, dynamic> json) => Users(
      name: json['name'],
      role: json['role'],
      career: json['career'],
      college: json['college'],
      maxConnections: json['maxConnections'],
      description: json['description'],
      extracurriculars: json['extracurriculars'],
      major: json['major'],
      scores: json['scores'],
      transcript: json['transcript'],
      uid: json['uid'],
      year: json['year'],
      currentConnections: json['currentConnections']

  );
}

*/
