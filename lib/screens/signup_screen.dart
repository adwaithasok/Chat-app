import 'package:flutter/material.dart';
import 'package:newapp/methods.dart';
import 'package:newapp/reusable_widgets/reusable_widget.dart';
import 'package:newapp/screens/home_screen.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final head2 = Text("Enter The Details Below to Create Account",
        style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white));
    final head = const Text("Sign Up",
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white));
    return Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: isLoading
            ? Center(
                child: Container(
                  height: 120,
                  width: 120,
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      head,
                      SizedBox(
                        height: 10,
                      ),
                      head2,
                      const SizedBox(
                        height: 150,
                      ),
                      reusableTextField(
                        "Enter UserName",
                        "name",
                        Icons.person_outline,
                        false,
                        _userNameTextController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField("Enter Email Id", "username@gmail.com",
                          Icons.person_outline, false, _emailTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField(
                          "Enter Password",
                          "Must have at least 7 characters",
                          Icons.lock_outlined,
                          true,
                          _passwordTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      firebaseUIButton(context, "Sign Up", () {
                        if (_userNameTextController.text.isNotEmpty &&
                            _emailTextController.text.isNotEmpty &&
                            _passwordTextController.text.isNotEmpty) {
                          setState(() {
                            isLoading = true;
                          });
                          createAcount(
                                  _userNameTextController.text,
                                  _emailTextController.text,
                                  _passwordTextController.text)
                              .then((user) {
                            if (user != null) {     

                              setState(() {
                                isLoading = false;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const HomePage()));
                            print('log in sucsessfull');

                            } else {
                              print('loginfailed');
                              setState(() {
                                isLoading = false;
                              });
                            }
                          });
                        } else {
                          print('please enter fields');
                        }

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => HomePage()));
                      }),
                    ],
                  ),
                ),
              )));
  }
}

String? validatetext(String? formtext) {
  if (formtext!.isEmpty) return 'field is required';
  {
    return null;
  }
}
