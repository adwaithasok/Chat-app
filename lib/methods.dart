import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newapp/screens/signin_screen.dart';

Future<User?> createAcount(String name, String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  try {
    User? user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;

        user?.updateDisplayName(name);

        await _firestore.collection("users").doc(_auth.currentUser?.uid).set({
        "name": name,
        "email": email,
        "status": "unavailable"
        
      });
    if (user ==  "") {
      print('create acount sucsessfull');

      

      return user;
    } else {
      print('acout create failed');
    }
    return user;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User?> login(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    User? user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user == "") {
      print('login sucsessfull');
      return user;
    } else {
      print('acout create failed');
    }
    return user;
  } catch (e) {
    print(e);
    return null;
  }
}

Future logout(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    await _auth.signOut().then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => SignInScreen()));
    });
  } catch (e) {
    print("error");
  }
}
