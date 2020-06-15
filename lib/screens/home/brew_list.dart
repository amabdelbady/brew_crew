import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'brew_tile.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);

    return Center(
      child: brews == null ? Loading() :
      ListView.builder(
          itemCount: brews.length,
          itemBuilder: (context, index){
          return BrewTile(brew: brews[index]);
          }
      ),
    );
  }
}
