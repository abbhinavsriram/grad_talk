import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_talk/database_services.dart';
import 'package:grad_talk/mentor_view/mentor_report_page.dart';
import 'package:grad_talk/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/theme.dart';

import 'mentor_widgets/mentorNavBar.dart';


class ConvScreen extends StatefulWidget {



  const ConvScreen({Key? key})
      : super(key: key);

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
      drawer: NavBar(),
      //https://www.freecodecamp.org/news/build-a-chat-app-ui-with-flutter/
      body: Stack(
        children: <Widget>[
          // chat messages here
          chatMessages(),
          const SizedBox(height: 100),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              width: MediaQuery.of(context).size.width,
              color: AppColors.secondary,
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

  chatMessages() {//connect to groups

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
    String groupID = await DatabaseService().getGroupId(FirebaseAuth.instance.currentUser!.uid);
    if (_messageController.text.isNotEmpty) {

      DatabaseService().sendNewMessage(groupID, _messageController.text.trim(), FirebaseAuth.instance.currentUser!.uid, DateTime.now());
      setState(() {
        _messageController.clear();
      });
    } else {
      setState(() {
        _messageController.clear();
      });
      return Utils.showSnackBar("You cannot send a blank text message");

    }
  }

}


getChats(String groupId) async {

}




/*
class ConvScreen extends StatelessWidget {

  static Route route(MessageData data) => MaterialPageRoute(
      builder: (context) => ConvScreen(
        messageData: data,
      ),
  );

  const ConvScreen({Key? key, required this.messageData}) : super(key: key);

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          title: _ChatBarTitle(
            messageData: messageData
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Center(
                  child: IconBorder(
                    icon: Icons.person,
                    onTap: () {}
                  ),
                ),
            ),
            const SizedBox(width: 15),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Center(
                  child: IconBorder(
                      icon: Icons.report,
                      onTap: (){}
                  )
                ),
            )
          ],
        ),
      ),

      body: Column(
        children: const [
          Expanded(child: _DemoMessage()),
          _MessagingBar()
        ],
      )
    );
  }
}


class _ChatBarTitle extends StatelessWidget {
  const _ChatBarTitle({Key? key, required this.messageData}) : super(key: key);


  final MessageData messageData;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          messageData.senderName,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 2),
        const Text(
          'Online now',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          )
        )
      ],
    );
  }
}



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

class _DateLabel extends StatelessWidget {
  const _DateLabel({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.cardDark,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textFaded
              )
            ),
          ),
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
            _DateLabel(label: "Yesterday"),
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