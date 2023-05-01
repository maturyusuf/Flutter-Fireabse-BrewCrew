import 'package:firebase_tutorial/models/user.dart';
import 'package:firebase_tutorial/services/database.dart';
import 'package:firebase_tutorial/shared/constants.dart';
import 'package:firebase_tutorial/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  String? _currentName;
  dynamic? _currentStrength;
  int? _currentSugar;
  final _formKey = GlobalKey<FormState>();
  final List<int> sugars = [0, 1, 2, 3, 4];
  
  @override
  Widget build(BuildContext context) {
    final Myuser user = Provider.of<Myuser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data!;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Update your brew settings",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val?.isEmpty ?? true ? "Please enter a name" : null,
                    onChanged: (val) => setState(() {
                      _currentName = val;
                    }),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //DropDown
                  DropdownButtonFormField(
                    value: _currentSugar ?? userData.sugars,
                    decoration: textInputDecoration,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                          value: sugar, child: Text("$sugar sugars"));
                    }).toList(),
                    onChanged: (int? value) {
                      setState(() {
                        _currentSugar = value;
                      });
                    },
                  ),

                  //slider

                  Slider(
                      min: 100,
                      max: 900,
                      divisions: 8,
                      value: _currentStrength==null ? double.parse(userData.strength) : double.parse(_currentStrength),
                      activeColor: Colors.brown[int.parse(_currentStrength ?? '0')],
                      inactiveColor: Colors.brown[int.parse(_currentStrength ?? '0')],
                      onChanged: (value) {
                        setState(() {
                          _currentStrength = value.round().toString();
                        });
                      }),

                  ElevatedButton(
                      onPressed: () async {
                        if(_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                            _currentSugar ?? userData.sugars,
                             _currentName ?? userData.name,
                              _currentStrength ?? userData.strength);
                        }
                        Navigator.pop(context);
                      },
                      style:
                          ElevatedButton.styleFrom(primary: Colors.pink[400]),
                      child:
                          Text("Update", style: TextStyle(color: Colors.white)))
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}