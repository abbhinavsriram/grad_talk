import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../theme.dart';
import 'mentor_widgets/mentor_widgets.dart';

//Displays all of the reviews a mentor has received

class MentorViewReviewPage extends StatefulWidget {
  final String mentorID;
  final double average;
  final double numRatings;

  const MentorViewReviewPage({
    required this.mentorID,
    required this.average,
    required this.numRatings,
    Key? key,
  }) : super(key: key);


  @override
  State<MentorViewReviewPage> createState() => _MentorViewReviewPageState();
}

class _MentorViewReviewPageState extends State<MentorViewReviewPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text("All Reviews")
      ),
        body: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "Overall rating: ${widget.average.toStringAsFixed(1)}",
                style: const TextStyle(
                  fontSize: 16
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                    "Number of ratings: ${widget.numRatings.round()}",
                    style: const TextStyle(
                        fontSize: 16
                    ),
                )
            ),
            SizedBox(height: 10),
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("users")
                      .doc(widget.mentorID)
                      .collection('reviews').orderBy("time", descending: true)
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
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                "Rating: ${data['rating']} / 5",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              subtitle: Text(
                                data['review'],
                                maxLines: 100,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: GradTalkColors.fadedText
                                ),
                              ),
                              minVerticalPadding: 5,
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