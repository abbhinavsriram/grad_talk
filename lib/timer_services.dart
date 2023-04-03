import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_talk/database_services.dart';

/*
Credit for timer functions:
Mevada, Milind. “Understanding Flutter's Timer Class and Timer.periodic.” LogRocket Blog, LogRocket, 21 Oct. 2021, 
  https://blog.logrocket.com/understanding-flutter-timer-class-timer-periodic/. 

*/

class TimerService {


  int hoursConversationLimit = 60;
  Timer? timer;
  //Checks the role of the other group member

  Future<String> getField() async {
    QuerySnapshot currentUser = await DatabaseService().getUserData(FirebaseAuth.instance.currentUser!.uid);
    if(currentUser.docs[0]['role'] == 'Mentor'){
      return 'Parent';
    }
    return 'Mentor';
  }
  //begins 5 day timer
  void startTimer(){
    Timer.periodic(Duration(seconds: 1), (timer) {
      if(hoursConversationLimit >= 0){
        hoursConversationLimit--;
      }
      if(hoursConversationLimit < 0){
        timer.cancel();
        stopTimer();
        return;
      }
    });

  }
  //stops the count
  void stopTimer() async {
    String field = await getField();
    timer?.cancel();
    DatabaseService().endConversation(field);
    hoursConversationLimit = 60;
    return;
  }

}