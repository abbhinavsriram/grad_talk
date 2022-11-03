import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_talk/student_view/student_widgets/studentNavBar.dart';
import 'package:grad_talk/student_view/student_widgets/student_widgets.dart';
import 'package:grad_talk/models/models.dart';
import 'package:grad_talk/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/theme.dart';

import '../database_services.dart';




class ConvScreen extends StatefulWidget {

  const ConvScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ConvScreen> createState() => _ConvScreenState();
}

class _ConvScreenState extends State<ConvScreen> {
  final groupId = DatabaseService().getUserData2("users", "groupId", FirebaseAuth.instance.currentUser!.uid);
  Stream<QuerySnapshot>? chats;
  final messageController = TextEditingController();
  String senderId = FirebaseAuth.instance.currentUser!.uid;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Chats"),
      ),
      body: Stack(
        children: <Widget>[
          // chat messages here
          chatMessages(),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[700],
              child: Row(children: [
                Expanded(
                    child: TextFormField(
                      controller: messageController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Send a message...",
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


  getChats(String groupId) async{
    return FirebaseFirestore.instance.collection("groupChat").doc(groupId)
        .collection("messages")
        .orderBy("time")
        .snapshots();

  }

  getChats2(){
    getChats(groupId).then((val){
      setState(() {
        chats = val;
      });
    });

  }

  chatMessages() {//connect to groups

    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            //create message tiles
            return MessageTile(
                message: snapshot.data.docs[index]['message'],
                sender: snapshot.data.docs[index]['senderId'],
                sentByMe: senderId ==
                    snapshot.data.docs[index]['senderId']);
          },
        )
            : Container();
      },
    );
  }
  sendMessage() {
    String receiver = DatabaseService().getUserData2("groups", "mentorId", groupId);
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "groupId": groupId,
        "text": messageController.text.trim(),
        "sender": FirebaseAuth.instance.currentUser!.uid,
        "receiver": receiver,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      FirebaseFirestore.instance.collection("groups").doc(groupId).collection("messages").add(chatMessageMap);
      setState(() {
        messageController.clear();
      });
    }
  }


}







/*
class _MessageTile extends StatelessWidget {
  const _MessageTile({Key? key, required this.message, required this.messageDate}) : super(key: key);

  final String message;
  final String messageDate;

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_borderRadius),
                    topRight: Radius.circular(_borderRadius),
                    bottomRight: Radius.circular(_borderRadius),
                    bottomLeft: Radius.circular(_borderRadius)
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                child: Text(message),
              ),

            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Text(
                  messageDate,
                  style: const TextStyle(
                    color: AppColors.textFaded,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
class _MessageOwnTile extends StatelessWidget {
  const _MessageOwnTile({Key? key, required this.message, required this.messageDate}) : super(key: key);

  final String message;
  final String messageDate;

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
              color: AppColors.secondary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_borderRadius),
                    topRight: Radius.circular(_borderRadius),
                    bottomRight: Radius.circular(_borderRadius),
                    bottomLeft: Radius.circular(_borderRadius)
                  ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                child: Text(message),
              ),

            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Text(
                messageDate,
                style: const TextStyle(
                  color: AppColors.textFaded,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}





class _DemoMessage extends StatelessWidget {
  const _DemoMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          children: const [
            _MessageTile(message: "Hello How's it going", messageDate: "12:00pm"),
            _MessageTile(message: "Hello", messageDate: "1:00pm"),
            _MessageTile(message: "Nothing much", messageDate: "2:00pm"),
            _MessageOwnTile(message: "Ok", messageDate: "9:00pm"),
            _MessageOwnTile(message: "Sorry for the late response!", messageDate: "9:00pm"),
            _MessageTile(message: "Sorry for the late response!", messageDate: "9:00pm"),
            _MessageOwnTile(message: "Sorry for the late response!", messageDate: "9:00pm"),
          ],

        )
    );
  }
}

class _MessagingBar extends StatelessWidget {
  const _MessagingBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 2,
                  color: Colors.grey
                )
              )
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: TextField(
                style: TextStyle(
                  fontSize: 14,

                ),
                decoration: InputDecoration(
                  hintText: "Send a message",
                  border: InputBorder.none
                )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 24,
              bottom: 12,
              top: 12,
            ),
            child: ActionButton(color: AppColors.accent, icon: Icons.send, onPressed: (){},)

          )


        ]
      )
    );
  }
}


*/