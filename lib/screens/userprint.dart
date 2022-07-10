// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:newapp/group_chats/group_chat_room.dart';
// import 'package:newapp/group_chats/group_chat_screen.dart';
// import 'package:newapp/screens/chatroom.dart';
// import 'package:newapp/screens/home_screen.dart';

// class userprint extends StatefulWidget {
//   const userprint({Key? key}) : super(key: key);

//   @override
//   State<userprint> createState() => _userprintState();
// }

// class _userprintState extends State<userprint> {
//   bool isLoading = false;

//   final TextEditingController _serch = TextEditingController();

//   String chatRoomId(String user1, String user2) {
//     if (user1[0].toLowerCase().codeUnits[0] >
//         user2.toLowerCase().codeUnits[0]) {
//       return "$user1,$user2";
//     } else {
//       return "$user2,$user1";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     final User? user = _auth.currentUser;
//     final uid = user!.uid;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         toolbarHeight: 60,
//         leading: InkWell(
//           onTap: () {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (_) => const HomePage()));
//           },
//           child: const Icon(
//             Icons.arrow_back,
//             color: Colors.black54,
//             size: 25,
//           ),
//         ),
//         backgroundColor: Colors.white,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Text(
//             'Stay up to date',
//             style: TextStyle(
//                 fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: .0),
//           ),
//           StreamBuilder<QuerySnapshot>(
//               stream:
//                   FirebaseFirestore.instance.collection("users").snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 0.0),
//                       child: Container(
//                           alignment: Alignment.centerLeft,
//                           height: MediaQuery.of(context).size.height / 2,
//                           width: 50,
//                           child: CircularProgressIndicator()),
//                     ),
//                   );
//                 } else {
//                   return Expanded(
//                     child: ListView(
//                       children: snapshot.data!.docs.map((document) {
//                         return Card(
//                           shape: RoundedRectangleBorder(
//                             side: const BorderSide(
//                               color: Colors.black,
//                             ),
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                           child: ExpansionTile(
//                             leading: Icon(Icons.event_note),
//                             textColor: Colors.black,
//                             collapsedTextColor: Colors.black,
//                             collapsedIconColor: Colors.red,

//                             title: Text(
//                               document["name"],
//                             ),
//                             // subtitle:Text(
//                             //   document["subhead"],
//                             // ),
//                             children: <Widget>[
//                               ListTile(
//                                 leading: const Icon(Icons.account_circle_sharp,color: 
//                       Colors.black,size: 40,),
//                     trailing: const Icon(Icons.message_rounded,color:
//                      Colors.black,size: 40,),
                                
//                                 title: Text("message"),
//                                 onTap: () {
//                                   String roomId = chatRoomId(
//                                       _auth.currentUser!.displayName!,
//                                       document['name']);

//                                   Navigator.of(context).push(
//                                     MaterialPageRoute(
//                                       builder: (_) => Chatroom(
//                                         chatRoomId: roomId,
//                                         document: document.data() as Map<String,dynamic>,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                               ListTile(leading: const Icon(Icons.account_circle_sharp,color: 
//                       Colors.black,size: 40,),
//                     trailing: const Icon(Icons.email,color:
//                      Colors.black,size: 40,),
//                                 title: Text(document["email"]),
//                                 onTap: () {},
//                               ),
                              
//                             ],
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   );
//                 }
//               })
//         ],
//       ),
//        floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (_) =>  createGroup()));
//         },
//         backgroundColor: Colors.black,
//         child: Icon(
//           Icons.group,
//         ),
//       ),
//     );
//   }
// }
