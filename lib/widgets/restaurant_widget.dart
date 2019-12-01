import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hi_food/models/models.dart';
import 'package:hi_food/pages/user/resturant.dart';

import '../values.dart';

class RestaurantWidget extends StatefulWidget {
  final String name;
  final int distance;
  final Resturant restaurant;
  RestaurantWidget({this.name, this.distance, this.restaurant});
  @override
  _RestaurantWidgetState createState() => _RestaurantWidgetState();
}

class _RestaurantWidgetState extends State<RestaurantWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(color: Color(0xFFB2B2B2), width: .8),
      )),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            widget.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: SizedBox(width: 20,),
          ),
          Container(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  size: 18,
                ),
                Text(
                  '${widget.distance.toString()} km',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(width: 30,), 
          Container(
            height: 30,
            child: RaisedButton(
              child: Text('VISIT',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              color: primaryColor,
              onPressed: () {
               
              },
            ),
          )
        ],
      ),
    );
  }
}
