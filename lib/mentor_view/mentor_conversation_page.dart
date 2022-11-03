import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_talk/models/models.dart';
import 'package:grad_talk/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/theme.dart';
import 'package:grad_talk/mentor_view/mentor_widgets/mentor_widgets.dart';


class ConvScreen extends StatefulWidget {



  const ConvScreen({Key? key})
      : super(key: key);

  @override
  State<ConvScreen> createState() => _ConvScreenState();
}

class _ConvScreenState extends State<ConvScreen> {
  Stream<QuerySnapshot>? chats;

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text("GradTalk"),
      ),
    );
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