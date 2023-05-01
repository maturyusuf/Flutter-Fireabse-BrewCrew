import "package:firebase_tutorial/models/user.dart";
import "package:firebase_tutorial/screens/authenticate/register.dart";
import "package:firebase_tutorial/screens/authenticate/sign_in.dart";
import "package:firebase_tutorial/screens/home/home.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView:toggleView);
    } else {
      return Register(toggleView:toggleView);
    }
  }
}
