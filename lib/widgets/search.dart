import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hi_food/models/db.dart';
import 'package:hi_food/models/models.dart';
import 'package:hi_food/values.dart';

class Search extends StatefulWidget {
  final String cat;
  final Function notify;
  Search(this.cat, this.notify, {Key key}) : super(key: key);

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
        onChanged: (text) {
          if (widget.cat == 'food') {
            foodSearch = text;
          }
          if (widget.cat == 'resturant') {
            resSearch = text;
          }
          widget.notify();
        },
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
