import 'package:flutter/material.dart';
import 'package:tidings_project/screen/authentication/sign_in.dart';
import 'package:tidings_project/screen/authentication/signup.dart';


class Authenticate extends StatefulWidget {
  static String tag = 'Login Page';
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignin = true;
  void toggleView() {
    setState(() => showSignin = !showSignin);
  }
  @override
  Widget build(BuildContext context) {
    if(showSignin) {
      return SignIn(toggleView: toggleView);
    } else{
      return SignUp(toggleView: toggleView);
    }
  }
}

    
