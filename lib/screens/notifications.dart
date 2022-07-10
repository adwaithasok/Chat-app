import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp/screens/home_screen.dart';

class notificationpage extends StatefulWidget {
  const notificationpage({Key? key}) : super(key: key);

  @override
  State<notificationpage> createState() => _notificationpageState();
}

class _notificationpageState extends State<notificationpage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final uid = user!.uid;

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
            'Stay up to date',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: .0),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("notifications")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    
                    child: Padding(
                      padding: const EdgeInsets.only(top:0.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: MediaQuery.of(context).size.height/20,
                        width: 50,
                        
                        child:
                      
                       CircularProgressIndicator()),
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView(
                      children: snapshot.data!.docs.map((document) {
                        return Card(
                          color: document["viewedBy"].contains(uid)
                              ? Colors.white
                              : Colors.black12,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            onTap: () {
                              if (!document["viewedBy"].contains(uid)) {
                              List<dynamic> viewdBy = document["viewedBy"];
                              viewdBy.add(uid);
                              document.reference.update({"viewedBy": viewdBy});
                              }
                            },
                            isThreeLine: true,
                            leading: Icon(Icons.event_note),
                            title: Text(
                              document["head"],
                              style: TextStyle(decorationColor: Colors.red),
                            ),
                            // subtitle: Text('Title2'),
                            subtitle: Column(
                              children: <Widget>[
                                Text(document["subhead"]),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}
