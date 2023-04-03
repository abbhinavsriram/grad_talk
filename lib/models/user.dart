import 'dart:core';

//Different types of users for the app
class NewUser{
  NewUser({

    required this.name,
    required this.email,
    required this.college,
    required this.career,
    required this.description,
    required this.extracurriculars,
    required this.major,
    required this.role,
    required this.scores,
    required this.transcript,
    required this.id,
    required this.year,
    required this.currentlyConnected,
    required this.groupID,
    required this.token,
  });
  String name;
  String email;
  String college;
  String career;
  String description;
  String extracurriculars;
  String major;
  String role;
  String scores;
  String transcript;
  String id;
  String year;
  bool currentlyConnected;
  String groupID;
  String token;


}


class MentorUser extends NewUser{
  MentorUser({
    required name,
    required email,
    required college,
    required career,
    required description,
    required extracurriculars,
    required major,
    required role,
    required scores,
    required transcript,
    required id,
    required year,
    required currentlyConnected,
    required groupID,
    required token,
    required this.numRatings,
    required this.rating,
    required this.isMuted,


  }) : super(
    name: name,
    email: email,
    college: college,
    career: career,
    description: description,
    extracurriculars: extracurriculars,
    major: major,
    role: role,
    scores: scores,
    transcript: transcript,
    id: id,
    year: year,
    currentlyConnected: currentlyConnected,
    groupID: groupID,
    token: token,

  );

  double numRatings;
  double rating;
  bool isMuted;



}


class StudentUser extends NewUser{
  StudentUser({
    required name,
    required email,
    required college,
    required career,
    required description,
    required extracurriculars,
    required major,
    required role,
    required scores,
    required transcript,
    required id,
    required year,
    required currentlyConnected,
    required groupID,
    required token,
    required this.request


  }) : super(
    name: name,
    email: email,
    college: college,
    career: career,
    description: description,
    extracurriculars: extracurriculars,
    major: major,
    role: role,
    scores: scores,
    transcript: transcript,
    id: id,
    year: year,
    currentlyConnected: currentlyConnected,
    groupID: groupID,
    token: token,

  );

  String request;



}