import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chatroom extends StatelessWidget {
  Map<String, dynamic>? document;
  final String chatRoomId;

  Chatroom(
      {required this.chatRoomId,
      this.document,
      });

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": _auth.currentUser?.displayName,
        "message": _message.text,
        "time": FieldValue.serverTimestamp()
      };
      _message.clear();

      await _firestore
          .collection("chatroom")
          .doc(chatRoomId)
          .collection("chats")
          .add(messages);
    } else
      print("enter some text");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
              children: [
               
            Container(
                height: size.height / 1.15,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection('chatroom')
                        .doc(chatRoomId)
                        .collection("chats")
                        .orderBy("time", descending: false)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.data != null) {
                        return ListView.builder(
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> map =
                                  snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;
        
                              return messages(size, map);
                            });
                      } else {
                        return Container();
                      }
                    })),
          
          Container(
            
              
            
              child: Container(
                height: 60,
                child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: size.height / 5,
                          width: size.width / 1.4,
                          child: TextField(
                              controller: _message,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(8),
                              ))),
                        ),
                        IconButton(onPressed: onSendMessage, icon: Icon(Icons.send))
                      ],
                    )),
              ),
            
          ),
              ],
            ),
        ));
  }

  Widget messages(Size size, Map<String, dynamic> map) {
    return Container(
      width: size.width,
      alignment: map['sendby'] == _auth.currentUser?.displayName
          ? Alignment.bottomRight
          : Alignment.bottomLeft,
      child: Container(
        height: 40,
        padding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(15.0)),

          color: Colors.blue,
        ),
        child: Text(
          map['message'],
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
