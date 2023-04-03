import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/mentor_view/mentor_pages.dart';
import 'package:grad_talk/mentor_view/mentor_widgets/mentor_widgets.dart';

import '../theme.dart';

//Mentor can view all requests on this page
class ViewRequestPage extends StatefulWidget {

  const ViewRequestPage({
    Key? key,
  }) : super(key: key);


  @override
  State<ViewRequestPage> createState() => _ViewRequestPageState();
}

class _ViewRequestPageState extends State<ViewRequestPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text("All Requests")
      ),
        body: Column(
          children: [
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("users")
                      .where('request', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                builder: (context, snapshots){
                  return (snapshots.connectionState == ConnectionState.waiting)
                      ? const Center(child: CircularProgressIndicator())
                      :ListView.builder(
                      itemCount: snapshots.data?.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshots.data!.docs[index].data() as Map<
                            String,
                            dynamic>;
                          return ListTile(
                            leading: FloatingActionButton(
                              heroTag: null,
                              backgroundColor: GradTalkColors.primary,

                              child: const Text("View"),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => RequestProfile(data: data,)
                                ));
                              },
                            ),
                            title: Text(
                              "${data['name']}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            trailing: Text(
                              data['college'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            subtitle: Text(
                              data['major'],
                              maxLines: 7,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: GradTalkColors.fadedText
                              ),
                            ),
                          );
                      }
                  );
                },

              ),
            ),
          ],
        )


    );
  }
}