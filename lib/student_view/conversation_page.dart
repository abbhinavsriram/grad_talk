import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_talk/database_services.dart';
import 'package:grad_talk/student_view/pages.dart';
import 'package:grad_talk/student_view/student_widgets/student_widgets.dart';
import 'package:grad_talk/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/theme.dart';
import 'package:profanity_filter/profanity_filter.dart';


import '../database_services.dart';


/*
  Credit for connection to firebase:
    Flutter, Backslash. “Chat App in Flutter and Firebase | Tutorial for Beginners to Advance | Android &amp; IOS (Latest).” YouTube, YouTube, 26 July 2022, 
      https://www.youtube.com/watch?v=Qwk5oIAkgnY. 

  Credit for UI: 
  Krissanawat. “How to Build a Chat App UI with Flutter and Dart.” FreeCodeCamp.org, FreeCodeCamp.org, 28 Apr. 2021, 
    https://www.freecodecamp.org/news/build-a-chat-app-ui-with-flutter/. 
*/
class ConvScreen extends StatefulWidget {
  const ConvScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ConvScreen> createState() => _ConvScreenState();
}

class _ConvScreenState extends State<ConvScreen> {
  Stream<QuerySnapshot>? allMessages;
  final _messageController = TextEditingController();
  String senderId = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    print("ConvScreen works");
    getChats();
    super.initState();
  }
  @override
  void dispose(){
    super.dispose();
    _messageController.dispose();
  }
  getChats() async {
    await DatabaseService().getAllMessages(context).then((val) {
      setState(() {
        print("getChats function works");
        print(allMessages);
        allMessages = val;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Chats"),
        actions: [
          IconButton(
            icon: const Icon(Icons.report),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ReportPage()));
            },
          )
        ],
      ),
      drawer: StudentNavBar(),
      body: Column(
        children: [
          // chat messages here
          Expanded(
            child: chatMessages(),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              width: MediaQuery.of(context).size.width,
              color: GradTalkColors.secondary,
              child: Row(children: [
                Expanded(
                    child: TextFormField(
                      controller: _messageController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Type here",
                        hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                        border: InputBorder.none,
                      ),
                    )),
                const SizedBox(
                  width: 12,
                ),
                GestureDetector(
                  onTap: () {
                    sendMessage();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        )),
                  ),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }

  chatMessages() {
    //Contains array of all messages sent and received
    return StreamBuilder(
      stream: allMessages,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            //create message tiles
            return MessageTile(
                message: snapshot.data.docs[index]['text'],
                sender: snapshot.data.docs[index]['senderId'],
                sentByMe: senderId == snapshot.data.docs[index]['senderId']
            );
          },
        )
            : const Text("Start a conversation!");
      },
    );
  }
  sendMessage() async {
    //Uploads message to database
    String groupID = await DatabaseService().getGroupId(FirebaseAuth.instance.currentUser!.uid);
    if (_messageController.text.isNotEmpty) {
      final filter = ProfanityFilter();
      bool isOffensive = filter.hasProfanity(_messageController.text.trim());

      if (!isOffensive) {
        DatabaseService().sendNewMessage(
          groupID,
          _messageController.text.trim(), 
          FirebaseAuth.instance.currentUser!.uid, 
          DateTime.now(),
          "Mentor"
          );
        setState(() {
          _messageController.clear();
        });
      } else{
        return Utils.showSnackBar("That's offensive!");
      }
    } else {
      setState(() {
        _messageController.clear();
      });
      return Utils.showSnackBar("You cannot send a blank text message");

    }
  }


}
