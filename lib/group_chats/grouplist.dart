import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp/group_chats/creategroop.dart';
import 'package:newapp/group_chats/groupchatscreen.dart.dart';
import 'package:newapp/group_chats/grouplist.dart';
import 'package:newapp/screens/chatscreen.dart';
import 'package:newapp/screens/home_screen.dart';

class groupChat extends StatefulWidget {
  const groupChat({Key? key}) : super(key: key);

  @override
  State<groupChat> createState() => _groupChatState();
}

class _groupChatState extends State<groupChat> {
  bool isLoading = false;
  Map<String, dynamic>? userdata;

  final TextEditingController _serch = TextEditingController();
  String chatRoomId(
    String user1,
    String user2,
  ) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1,$user2";
    } else {
      return "$user2,$user1";
    }
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final uid = user!.uid;

    FirebaseFirestore.instance.collection("users").doc(uid).get()
      .then((value) {
        setState(() {
          userdata = value.data();
        });
      });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        leading: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const HomePage()));
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black54,
            size: 25,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'GROUPS',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: .0),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("groupChat")
                  .where("participants", arrayContains: userdata?['name'])
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Container(
                          alignment: Alignment.centerLeft,
                          height: MediaQuery.of(context).size.height / 2,
                          width: 50,
                          child: CircularProgressIndicator()),
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView(
                      children: snapshot.data!.docs.map((document) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ExpansionTile(
                            leading: Icon(Icons.event_note),
                            textColor: Colors.black,
                            collapsedTextColor: Colors.black,
                            collapsedIconColor: Colors.red,
                            title: Text(
                              document["name"],
                            ),
                            children: <Widget>[
                              ListTile(
                                title: Text("message"),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          groupchatroom(document: document),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => createGroup()));
        },
        backgroundColor: Colors.black,
        child: Icon(
          Icons.group,
        ),
      ),
    );
  }
}
