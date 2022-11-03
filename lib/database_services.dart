import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:grad_talk/screens/screens.dart';
import 'package:grad_talk/widgets/widgets.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  final CollectionReference users = FirebaseFirestore.instance.collection("users");
  final CollectionReference userChat = FirebaseFirestore.instance.collection("chats");


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


  getChats(String groupId) async {
    CollectionReference groupCollection = FirebaseFirestore.instance.collection('messages');
    return groupCollection.doc(groupId).collection('text').orderBy('time').snapshots();
  }


}
/*
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
