import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp/screens/signin_screen.dart';

class HomePage extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  static String tag = 'home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    const profiepic = Hero(
        tag: 'Hero',
        child: Padding(
          padding: EdgeInsets.all(50.0),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/alucard.jpg'),
          ),
        ));

    const welcome = Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'welcome',
          style: TextStyle(fontSize: 26.0, color: Colors.black),
        ));

    const lorem = Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          ' Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque tempor dictum purus, vitae blandit leo lobortis vitae. Etiam ipsum lacus, eleifend ut vestibulum vitae, ultrices vel est. Vivamus egestas varius orci non pellentesque. Aenean quis varius lacus, non placerat elit. Integer a diam vehicula, congue mi eget, egestas sem. Aenean.',
          style: TextStyle(fontSize: 16.0, color: Colors.black),
        ));

    final loginbButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent,
        elevation: 0.0,
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              print("Signed Out");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignInScreen()));
            });
          },
          padding: const EdgeInsets.all(10),
          child: Text(
            'Logout',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        padding: const EdgeInsets.all(28.0),
        child: ListView(
          children: [
            Column(
              children: <Widget>[
                profiepic,
                welcome,
                lorem,
                loginbButton,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
