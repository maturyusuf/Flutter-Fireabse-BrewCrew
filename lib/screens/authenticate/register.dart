import 'package:firebase_tutorial/shared/constants.dart';
import 'package:flutter/material.dart';
import '../../services/auth.dart';
import '../../shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({Key? key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign up to Brew Crew"),
        actions: [
          ElevatedButton(
            onPressed: () {
              widget.toggleView();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.person), Text("Sign In")],
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          
          key: _formkey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: textInputDecoration,
                validator: (value) {
                  return value!.isEmpty ? "Enter an email!" : null;
                },
                onChanged: (value) {
                  setState(() {
                    if (_formkey.currentState!.validate()) {
                      email = value;
                    }
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Password",
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.pink, width: 2.0))),
                validator: (value) {
                  return value!.length < 6
                      ? "Enter a password longer than 6 characters!"
                      : null;
                },
                obscureText: true,
                onChanged: (value) {
                  if (_formkey.currentState!.validate()) {
                    password = value;
                  }
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.registerWithEmailAndPassword(
                        email, password);
                    if (result == null) {
                      setState(() {
                        error =
                            "Registration failed. Please check your email and password.";
                        loading = false;
                      });
                    }
                  }
                },
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
