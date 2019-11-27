import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hi_food/values.dart';

class ResturantPage extends StatefulWidget {
  @override
  _ResturantPageState createState() => new _ResturantPageState();
}

class _ResturantPageState extends State<ResturantPage> {

  @override
  Widget build(BuildContext context) {
    var top = 0.0;

    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: 300.0,
              color: primaryColor,
              child: FittedBox(
                child: Image.asset('assets/images/food.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            ListView(
              children: <Widget>[
                Container(
                  height: 200.0,
                  color: Colors.transparent,
                ),
                Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 5.0,),
                      Text(
                        'Sweet Sensation',
                        style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0,),
                      Container(
                        height: 40.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon( Icons.free_breakfast, color: primaryColor, ),
                                SizedBox(width: 4.0,),
                                Text(
                                  '9AM - 6PM',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Container(
                              width: 1,
                              margin: EdgeInsets.only(left: 20.0,right: 20.0),
                              color: Color(0xFF424242),
                            ),
                            Row(
                              children: <Widget>[
                                Icon( Icons.star, color: primaryColor, ),
                                SizedBox(width: 4.0,),
                                Text(
                                  '4.3 (2.1K)',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Container(
                              width: 1,
                              margin: EdgeInsets.only(left: 20.0,right: 20.0),
                              color: Color(0xFF424242),
                            ),
                            Row(
                              children: <Widget>[
                                Icon( Icons.location_on, color: primaryColor, ),
                                SizedBox(width: 4.0,),
                                Text(
                                  '20 Mins',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Container(
                              width: 1,
                              margin: EdgeInsets.only(left: 20.0,right: 20.0),
                              color: Color(0xFF424242),
                            ),
                            Row(
                              children: <Widget>[
                                Icon( Icons.done, color: primaryColor, size: 20.0, ),
                                SizedBox(width: 4.0,),
                                Text(
                                  '232\nOrders',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: .8,
                        margin: EdgeInsets.only(top: 20.0,bottom: 20.0),
                        color: Color(0xFFB2B2B2),
                      ),
                      Text(
                        'The MIT License (MIT)  Copyright (c) 2016 Güray Yarar \nPermission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Container(
                        height: .8,
                        margin: EdgeInsets.only(top: 20.0,bottom: 20.0),
                        color: Color(0xFFB2B2B2),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Reviews & Ratings',
                            style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon( Icons.arrow_forward ),
                            onPressed: (){
                              Navigator.pushNamed(context, '/reviews');
                            },
                          ),
                        ]
                      ),
                      SizedBox(height: 15.0,),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        '4.3/5',
                                        style: TextStyle(fontSize: 40.0, color: primaryColor),
                                      ),
                                      Text(
                                        '8 ratings'
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 15.0,),
                                  Column(
                                    children: List.generate(5, (int index){
                                      var rate = Random().nextInt(80);
                                      return Row(
                                        children: <Widget>[
                                          Icon(Icons.star, color: primaryColor, size: 20,),
                                          SizedBox(width: 3.0,),
                                          Text((5-index).toString()+' ($rate)', style: TextStyle(fontSize: 14.0),),
                                          SizedBox(width: 15.0,),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4.0),
                                              color: Colors.grey
                                            ),
                                            height: 10.0,
                                            width: 100.0,
                                            child: Container(
                                              margin: EdgeInsets.only(right: 100.0-rate),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4.0),
                                                color: primaryColor
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ), // Ratings
                            SizedBox(height: 30.0,),
                            Container(
                              child: Column(
                                children: List.generate(3, (int index){
                                  return Container( 
                                    decoration: BoxDecoration(
                                      border: Border(top: BorderSide(color: Color(0xFFB2B2B2), width: .8)),
                                    ),
                                    padding: EdgeInsets.only(top: 17.0, bottom: 17.0), child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                            backgroundImage: AssetImage('assets/images/rest.jpg'),
                                          ),
                                          SizedBox(width: 20.0,),
                                          Text(
                                            'Samuel Adeniyi',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.0,),
                                      Row(
                                        children: <Widget>[
                                          Row(children: List.generate(5, (int index){
                                            var color = primaryColor;
                                            if( index==4 ) {
                                              color = Colors.grey;
                                            }
                                            return Icon( Icons.star, color: color, size: 19, );
                                          }),),
                                          SizedBox(width: 15.0,),
                                          Text(
                                            '11/12/2019',
                                            style: TextStyle(fontStyle: FontStyle.italic),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                        child: Text(
                                          '''To add custom fonts to your application, add a fonts section here,
      in this "flutter" section. Each entry in this list should have a
      list giving the asset and other descriptors for the font. For''',
                                          style: TextStyle(),
                                        ),
                                      ),
                                      Row (
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Icon( Icons.done_all, size: 20.0, color: primaryColor, ),
                                          SizedBox(width: 8),
                                          Text('verified purchase', style: TextStyle(color: primaryColor, fontSize: 14.0, fontStyle: FontStyle.italic),),
                                        ],
                                      ),
                                    ],
                                  ));
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Container(
                        height: .8,
                        margin: EdgeInsets.only(top: 20.0,bottom: 20.0),
                        color: Color(0xFFB2B2B2),
                      ),
                      Text(
                        'Other Info',
                        style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0,),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon( Icons.cloud, size: 19.0, color: primaryColor, ),
                                SizedBox(width: 15.0,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Website', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),),
                                    SizedBox(height: 4.0,),
                                    Text('http://ssnigeria.com', style: TextStyle(fontStyle: FontStyle.italic),)
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 15.0,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon( Icons.email, size: 19.0, color: primaryColor, ),
                                SizedBox(width: 15.0,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Email', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),),
                                    SizedBox(height: 4.0,),
                                    Text('info@ssnigeria.com', style: TextStyle(fontStyle: FontStyle.italic),)
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 15.0,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon( Icons.location_on, size: 19.0, color: primaryColor, ),
                                SizedBox(width: 15.0,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),),
                                    SizedBox(height: 4.0,),
                                    Text('120, Gateway College', style: TextStyle(fontStyle: FontStyle.italic),)
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 15.0,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 80.0,
              child: AppBar(
                elevation: 0,
                backgroundColor: Color.fromRGBO(0, 0, 0, 0.3),
                leading: IconButton(
                  icon: Icon( Icons.arrow_back, color: Colors.white ),
                  onPressed: (){
                    Navigator.pop(context);
                  }
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon( Icons.search, color: Colors.white, ),
                    onPressed: (){

                    },
                  ),
                  IconButton(
                    icon: Icon( Icons.favorite, color: primaryColor, ),
                    onPressed: (){

                    },
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}