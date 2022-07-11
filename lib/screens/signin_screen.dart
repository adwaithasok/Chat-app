import 'package:flutter/material.dart';
import 'package:newapp/methods.dart';
import 'package:newapp/reusable_widgets/reusable_widget.dart';
import 'package:newapp/screens/signup_screen.dart';
import 'package:newapp/screens/home_screen.dart';



class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
              height: 120,
              width: 120,
              child: CircularProgressIndicator(),
            ))
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: Colors.black),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 180,
                      ),
                      reusableTextField("Enter email", "username@gmail.com",
                          Icons.person_outline, false, _emailTextController),
                      const SizedBox(
                        height: 25,
                      ),
                      reusableTextField(
                          "Enter Password",
                          "Must have at least 7 characters",
                          Icons.lock_outline,
                          true,
                          _passwordTextController),
                      const SizedBox(
                        height: 25,
                      ),
                      firebaseUIButton(context, "sign in", () {
                        if (_emailTextController.text.isNotEmpty &&
                            _passwordTextController.text.isNotEmpty) {
                          setState(() {
                            isLoading = true;
                          });
                          login(_emailTextController.text,
                                  _passwordTextController.text)
                              .then((user) {
                            if (user != null) {
                              print('log in sucsess');
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const HomePage()));
                            } else {
                              print('login failed');
                              setState(() {
                                isLoading = false;
                              });
                            }
                          });
                        } else {
                          print('please fill form correctly');
                        }
                      }),
                      signUpOption()
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have account?",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
