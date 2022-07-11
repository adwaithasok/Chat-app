import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp/screens/home_screen.dart';
import 'package:newapp/screens/signin_screen.dart';

// ignore: use_key_in_widget_constructors
class Authenticate extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return const HomePage();
    } else {
      return const SignInScreen();
    }
  }
}
