import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:grad_talk/widgets/widgets.dart';
import 'package:http/http.dart' as http;

import 'database_services.dart';

/*
Credit for notification functions:
dbestech. “Complete Guide Flutter Push Notifications with Firebase Cloud Messaging.” YouTube, YouTube, 17 Sept. 2022, 
  https://www.youtube.com/watch?v=AUU6gbDni4Q&amp;t=836s. 
*/


class NotificationServices{
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //checks if the user has enabled notifications for the app. If not, it requests permission.
  void permissionRequest() async {
    
    FirebaseMessaging firebaseMessaging = await FirebaseMessaging.instance;
    NotificationSettings notificationSettings  = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: false,
    );

    if(notificationSettings.authorizationStatus == AuthorizationStatus.authorized){
      print("Notifications work");
    } else if (notificationSettings.authorizationStatus == AuthorizationStatus.provisional){
      print("Temporary");
    } else{
      print("No notifications");
    }
  }


  void sendMessage(String uid, String title, String body) async {
    //sends notification messages to the user's registered device.
    try{
      QuerySnapshot user = await DatabaseService().getUserData(uid);
      String token = user.docs[0]['token'];
      print(token);
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAA8askqB8:APA91bF2ihPssUTro2ezQ1cVFEsIqFkuJsy8kA1KdoZZr8qTBQmYsgQc3k2E6-F--EEDayL4DX-aPwpUYqYaryFG1fViH-5UBKQB1J5u2LAqErNDyEXsr0YtemQYbKxV7URPyCNujBTy',

        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'notification': <String, dynamic>{
              'title': title,
              'body': body,
              'android_channel_id': "gradtalk-7514c"

            },
            "to": token
          }

        )

      );

      print("Message sent");
    } catch(e){
      Utils.showSnackBar(e.toString());

    }

  }


  void newToken() async{
    //Creates a new token for the user
    String? nToken = "";

    await FirebaseMessaging.instance.getToken().then((token) {
      saveToken(token);
    });
  }

  void saveToken(String? token) async{
    //Saves token to database
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
      'token': token
    });

  }

  initialize(){
    //Displays notifications to the user for both IOS and Android settings
    var androidInitialize = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitialize = const IOSInitializationSettings();
    var bothInitializations = InitializationSettings(android: androidInitialize, iOS: iosInitialize);
    flutterLocalNotificationsPlugin.initialize(bothInitializations, onSelectNotification: (String? payload) async {
      return;
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage newMessage) async {
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        newMessage.notification!.body.toString(), 
        htmlFormatBigText: true, 
        contentTitle: newMessage.notification!.title.toString(),
        htmlFormatContent: true,
      );
      AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        'gradtalk-7514c', 
        'gradtalk',
        priority: Priority.high,
        importance: Importance.high,
        playSound: false,
        styleInformation: bigTextStyleInformation,
        );
        NotificationDetails specificDetails  = NotificationDetails(
          android: androidNotificationDetails,
          iOS: IOSNotificationDetails()
        );

        await flutterLocalNotificationsPlugin.show(
          0, 
          newMessage.notification!.title, 
          newMessage.notification!.body, 
          specificDetails,
          );
    });
  }
}