import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../models/brew.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;
  const BrewTile({super.key, required this.brew});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[int.parse(brew.strength)],
          ),
          title: Text(brew.name),
          subtitle: Text("Takes ${brew.sugar} sugars"),
        ),
      ),);
        
  }
}