import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grad_talk/login_screens/screens.dart';
import 'package:grad_talk/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grad_talk/widgets/widgets.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> backgroundNotificationHandler(RemoteMessage message) async {
  print("Background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.getInitialMessage;
  FirebaseMessaging.onBackgroundMessage(backgroundNotificationHandler);
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        debugShowCheckedModeBanner: false,
        darkTheme: AppTheme.dark(),
        themeMode: ThemeMode.dark,
        home: const AuthPage(),
    );
  }


}

