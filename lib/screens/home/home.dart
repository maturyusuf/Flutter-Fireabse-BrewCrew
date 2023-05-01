import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_tutorial/models/brew.dart';
import 'package:firebase_tutorial/screens/home/setting_form.dart';
import 'package:firebase_tutorial/services/auth.dart';
import 'package:firebase_tutorial/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brew_list.dart';

class Home extends StatelessWidget {
  Home({Key? key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _ShowSettingsPanel(){
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
            child: SettingsForm(),
          );
        });
    }
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      initialData: [],// Replace with initial data if needed
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Brew Crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            ElevatedButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text("Log Out"),
            ),
            IconButton(
              onPressed: (){
                _ShowSettingsPanel();
              },
             icon: Icon(Icons.settings),
             ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}