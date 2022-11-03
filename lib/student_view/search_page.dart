import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_talk/database_services.dart';
import 'package:grad_talk/student_view/student_widgets/student_widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: StudentNavBar(),
        appBar: AppBar(
          title: Card(
            child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search), hintText: 'Search a major, university, or name'),
                onChanged: (val) {
                  setState((){
                    name = val;
                  });
                }
              ),
            ),
          ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users')
              .where('role', isEqualTo: 'Mentor').snapshots(),
          builder: (context, snapshots){
            return (snapshots.connectionState == ConnectionState.waiting)
                ?Center(child: CircularProgressIndicator())
                :ListView.builder(
                itemBuilder: (context, index){
                  var data = snapshots.data!.docs[index].data() as Map<String, dynamic>;
                  if(name.isEmpty){
                    return ListTile(
                      leading: FloatingActionButton(
                        child: Text("Add"),
                        onPressed: () {
                          DatabaseService().createGroup(data['uid'], FirebaseAuth.instance.currentUser!.uid, context);

                        },
                      ),
                      title: Text(
                        data['name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      trailing: Text(
                        data['college'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle: Text(
                        data['description'],
                        maxLines: 7,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                        ),
                      ),
                    );
                  }
                  else if(data['major'].toString().startsWith(name.toLowerCase())){
                    return ListTile(
                      leading: FloatingActionButton(
                        child: Text("Add"),
                        onPressed: () {
                          DatabaseService().createGroup(data['uid'], FirebaseAuth.instance.currentUser!.uid, context);

                        },
                      ),
                      title: Text(
                        data['name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      trailing: Text(
                        data['college'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle: Text(
                        data['description'],
                        maxLines: 7,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),

                    );
                  }
                  else if(data['college'].toString().startsWith(name.toLowerCase())){
                    return ListTile(
                      leading: FloatingActionButton(
                        child: Text("Add"),
                        onPressed: () {
                          DatabaseService().createGroup(data['uid'], FirebaseAuth.instance.currentUser!.uid, context);

                        },
                      ),
                      title: Text(
                        data['name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      trailing: Text(
                        data['college'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle: Text(
                        data['major'],
                        maxLines: 7,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),

                    );
                  }
                  else if(data['name'].toString().startsWith(name.toLowerCase())){
                    return ListTile(
                      leading: FloatingActionButton(
                        child: Text("Add"),
                        onPressed: () {
                          DatabaseService().createGroup(data['uid'], FirebaseAuth.instance.currentUser!.uid, context);

                        },
                      ),
                      title: Text(
                        data['name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      trailing: Text(
                        data['college'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle: Text(
                        data['description'],
                        maxLines: 7,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),

                    );
                  }
                  return Container();
                }
            );
          },

      )


    );
  }
}
