import 'package:firebase_tutorial/models/brew.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'brew_tile.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

    final brews = Provider.of<List<Brew>>(context);
    
    brews.forEach((brew) { 
      print(brew.name);
      print("${brew.sugar}"); 
      print("${brew.strength}");
    });
    return  ListView.builder(
      itemCount: brews.length,
      itemBuilder:((context, index) {
        return BrewTile(brew:brews[index]);
      }) );
  }
}