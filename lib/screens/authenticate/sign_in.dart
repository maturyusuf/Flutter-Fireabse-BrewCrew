import "package:firebase_tutorial/services/auth.dart";
import "package:firebase_tutorial/shared/constants.dart";
import "package:flutter/material.dart";

import "../../shared/loading.dart";

class SignIn extends StatefulWidget {
  final Function toggleView;
  const  SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  bool loading = false;

  //textfield state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign in to Brew Crew"),
        actions: [
          ElevatedButton(
            onPressed: () {
              widget.toggleView();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.person), Text("Register")],
            ),
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "Email"),
                  validator: (value) {
                    return value!.isEmpty ? "Enter an email" : null;
                  },
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "Password"),
                  validator: (value) {
                    return value!.length < 6
                        ? "Enter password within more than 6 characters"
                        : null;
                  },
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                          dynamic result = await _auth.signInEmailAndPassword(email, password);
                          if(result ==null){
                            setState(() {
                              error = "Could not signed in with those credentials !";
                              loading = false;
                            });
                          }
                      }
                      //     print(email);
                      //    print(password);
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(color: Colors.white),
                    )),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ],
            ),
          )
          //Sign in with Email & Password

          /*
        ==Anonimously Sign In==
        FloatingActionButton(
          onPressed:() async{
           dynamic result =  await _auth.signInAnon();
           if(result==null){
            print("error signing in");
           }
           else{
            print("Signed in");
            print(result.uid);
           }
          },
          child: Icon(Icons.arrow_right)

              ),
      */
          ),
    );
  }
}
