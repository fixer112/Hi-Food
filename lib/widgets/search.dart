import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../values.dart';

class Search extends StatefulWidget {
  final String cat;
  Search(this.cat, {Key key}) : super(key: key);

  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      padding: EdgeInsets.all(8.0),
      height: 55.0,
      child: TextField(
        onChanged: (text) {},
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(),
          labelText: 'Search',
        ),
      ),
    );
  }
}
