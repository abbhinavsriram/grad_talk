import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/student_view/pages.dart';
import 'package:grad_talk/student_view/review_page.dart';
import 'package:grad_talk/student_view/student_widgets/studentNavBar.dart';
import 'package:grad_talk/widgets/widgets.dart';
import '../database_services.dart';
import '../theme.dart';

class SearchProfile extends StatelessWidget {
  final String mentorID;
  final String career;
  final String college;
  final String description;
  final String extracurriculars;
  final String major;
  final String name;
  final String scores;
  final String transcript;
  final String year;
  final num rating;
  final num numReviews;

  const SearchProfile({
    Key? key,
    required this.mentorID,
    required this.career,
    required this.college,
    required this.description,
    required this.extracurriculars,
    required this.major,
    required this.name,
    required this.scores,
    required this.transcript,
    required this.year,
    required this.rating,
    required this.numReviews,
  }) : super(key: key);

  @override
  //Displays profile of mentor who user clicked on in search
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$name's profile"),
        centerTitle: true,
      ),
      drawer: StudentNavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: fieldText("Name"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: valueText(name),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: fieldText("College"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: valueText(college),
              ),

              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: fieldText("Major"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: valueText(major),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: fieldText("Rating"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: valueText("${rating.toStringAsFixed(1)} (${numReviews.round().toString()})"),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: fieldText("Graduating year"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: valueText(year),
              ),

              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: fieldText("Career"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: valueText(career),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: fieldText("Description"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: valueText(description),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: fieldText("Extracurriculars"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: valueText(extracurriculars),
              ),

              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: fieldText("Standardized test scores"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: valueText(scores),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: fieldText("Transcript"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: valueText(transcript),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewReviewPage(average: rating, numRatings: numReviews, mentorID: mentorID)
                    ));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: GradTalkColors.primary,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Center(
                      child: Text("View reviews", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: () {
                    checkReview(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: GradTalkColors.primary,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Center(
                      child: Text("Write a review", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: () {
                    DatabaseService().sendRequest(mentorID, FirebaseAuth.instance.currentUser!.uid);
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const Student()
                    ));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: GradTalkColors.primary,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Center(
                      child: Text("Connect", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(MaterialPageRoute(
                        builder: (context) => const SearchPage()
                    ));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: GradTalkColors.primary,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Center(
                      child: Text("Back to search", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
  //header format

  Widget fieldText(String field){
    return Text(
      field,
      style: const TextStyle(
        fontSize: 17,
        color: GradTalkColors.primary,
      ),
    );
  }
  //body text format

  Widget valueText(String value){
    return Text(
      value,
      style: const TextStyle(
          fontSize: 16
      ),
    );
  }
  //checks if user can write a review for the mentor. If not, outputs error
  checkReview(BuildContext context) async {
    
    bool canReview = await DatabaseService().canReview(FirebaseAuth.instance.currentUser!.uid, mentorID);
    print("We can review: ${canReview}");
    if(canReview == true){
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ReviewPage(mentorID: mentorID)
      ));
    } else {
      Utils.showSnackBar("Cannot review this mentor. You may have written a review already or are yet to connect to connect with this person");
    }
  }
}

