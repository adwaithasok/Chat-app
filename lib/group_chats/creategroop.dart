


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:newapp/group_chats/grouplist.dart';
import 'package:newapp/reusable_widgets/reusable_widget.dart';

class createGroup extends StatefulWidget {
  @override
  State<createGroup> createState() => _createGroupState();
  
}

class _createGroupState extends State<createGroup> {
  TextEditingController _groupcName = TextEditingController();
  TextEditingController _addgroup = TextEditingController();
  Map<String, dynamic>? userdata;

  @override

  Widget build(BuildContext context) {


     final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final uid = user!.uid;

    FirebaseFirestore.instance.collection("users").doc(uid).get().then((value) {
      setState(() {
        userdata = value.data();
      });
    });
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                reusableTextField("Enter group name", "enter group name",
                    Icons.flutter_dash, false, _groupcName),
                SizedBox(
                  height: 50,
                ),
                reusableTextField("Participants Username", "Separated by comma",
                    Icons.groups_rounded, false, _addgroup),
                SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          List<String> paticipants = _addgroup.text.split(',');
                          paticipants.add(userdata!["name"]);
                          FirebaseFirestore.instance
                              .collection("groupChat")
                              .add({
                            "name": _groupcName.text,
                            "participants": paticipants
                          }).then((_) => {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => groupChat()))
                                  });
                        },
                        child: Text(
                          "create group",
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
