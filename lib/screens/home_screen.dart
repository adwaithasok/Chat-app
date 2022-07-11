import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp/group_chats/creategroop.dart';
import 'package:newapp/group_chats/grouplist.dart';
import 'package:newapp/screens/chatscreen.dart';
import 'package:newapp/screens/signin_screen.dart';
import 'package:newapp/methods.dart';

import 'notifications.dart';

class HomePage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  static String tag = 'home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? userMap;
  bool isLoading = false;

  final TextEditingController _serch = TextEditingController();

String chatRoomId(String user1,String user2){
  if( user1[0].toLowerCase().codeUnits[0]>user2.toLowerCase().codeUnits[0]){
    return "$user1,$user2";

  }else{
    return "$user2,$user1";

  }
}

  

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 60,
          leading: const Icon(
            Icons.menu,
          ),
          title: const Text(
            'TheLaDBibel',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 200.0, shadowColor: Colors.black, bottomOpacity: 20.0,

          // ignore: prefer_const_literals_to_create_immutables
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 50),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => notificationpage()));
                },
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: InkWell(
                onTap: (() => logout(context)),
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
            ),
          ],

          backgroundColor: Colors.black,
        ),
        
        body: isLoading
            ? Center(
                child: Container(
                    height: 50, width: 50, child: CircularProgressIndicator()),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                     Padding(
                       padding: const EdgeInsets.only(top:20.0),
                       child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Container(
                                child: Text("Find your friend",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20))),
                          ),


                           Padding(
                             padding: const EdgeInsets.all(0.0),
                             child: IconButton(onPressed: () {
                               Navigator.push(context,
              MaterialPageRoute(builder: (_) => const groupChat()));
         
        },
       icon: Icon(Icons.groups_rounded,color: Colors.black,)),
                           ),

                            OutlinedButton(
            onPressed: (){
               Navigator.push(context,
              MaterialPageRoute(builder: (_) =>  createGroup()));
            },
           
            child: Text('create group',style: TextStyle(color: Colors.black),)
            ),
        
        
        
        
        
                        ],
                       ),
                     ),
                      SizedBox(
                        height: size.height / 30,
                      ),


                      StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("users").snapshots(),
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
                            // subtitle:Text(
                            //   document["subhead"],
                            // ),
                            children: <Widget>[
                              ListTile(
                                leading: const Icon(Icons.account_circle_sharp,color: 
                      Colors.black,size: 40,),
                    trailing: const Icon(Icons.message_rounded,color:
                     Colors.black,size: 40,),
                                
                                title: Text("message"),
                                onTap: () {
                                  String roomId = chatRoomId(
                                      _auth.currentUser!.displayName!,
                                      document['name']);

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => Chatroom(
                                        chatRoomId: roomId,
                                        document: document.data() as Map<String,dynamic>,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              ListTile(leading: const Icon(Icons.account_circle_sharp,color: 
                      Colors.black,size: 40,),
                    trailing: const Icon(Icons.email,color:
                     Colors.black,size: 40,),
                                title: Text(document["email"]),
                                onTap: () {},
                              ),
                              
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
              })
                    ])));
  }
}
