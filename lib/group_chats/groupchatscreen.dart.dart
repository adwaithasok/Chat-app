import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class groupchatroom extends StatelessWidget {
  QueryDocumentSnapshot<Object?> document;

  groupchatroom({
    required this.document,
  });

  final TextEditingController _message = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": _auth.currentUser?.displayName,
        "message": _message.text,
        "time": FieldValue.serverTimestamp()
      };
      _message.clear();

      await document.reference.collection("chats").add(messages);
    } else
      print("enter some text");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Container(
                  height: size.height / 1.25,
                  width: size.width,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: document.reference
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
                height: size.height / 6,
                width: size.width,
                alignment: Alignment.center,
                child: Container(
                    height: size.height / 10,
                    width: size.width / 1.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: size.height / 15,
                          width: size.width / 1.3,
                          child: TextField(
                              controller: _message,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(8),
                              ))),
                        ),
                        IconButton(
                            onPressed: onSendMessage, icon: Icon(Icons.send))
                      ],
                    )),
              ),
            ],
          )),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map) {
    return Container(
      width: size.width,
      alignment: map['sendby'] == _auth.currentUser?.displayName
          ? Alignment.bottomRight
          : Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.only(left: 10,right: 20,top: 5,bottom: 10),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),

          ),
          color: Colors.blue,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              map['sendby'],
              style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0),
              child: Text(
                map['message'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
             
           
            

          ],
        ),
      ),
    );
  }
}
