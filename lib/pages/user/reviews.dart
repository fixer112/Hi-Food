import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hi_food/values.dart';

class Reviews extends StatefulWidget {
  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build( BuildContext context ) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          leading: IconButton(
            icon: Icon( Icons.arrow_back ),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          title: Text( 'Rating & Reviews' ),
          actions: <Widget>[
            IconButton(
              icon: Icon( Icons.add_comment ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context)=>addReviews()
                ));
              },
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
            SizedBox(height: 15.0,),
            RaisedButton(
              color: primaryColor,
              textColor: Colors.white,
              child: Text( 'LOAD MORE' ),
              onPressed: (){

              },
            ),
          ],
        ),
      ),
    );
  }
}

class addReviews extends StatefulWidget {
  @override
  _addReviewsState createState() => _addReviewsState();
}

class _addReviewsState extends State<addReviews> {
  var _value = 0;

  @override
  Widget build( BuildContext context ) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: Icon( Icons.arrow_back ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text( 'Add Reviews' ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Message',
                    border: InputBorder.none
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  expands: true,
                ),
              ),
            ),
            Container(height: .8, color: Color(0xFFD7D7D7),margin: EdgeInsets.only(bottom: 10.0),),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(5, (int index){
                        var height = _value==index ? 50.0 : 45.0;
                        return InkWell( child: Stack(
                          children: <Widget>[
                            Icon( _value==index ? Icons.star : Icons.star_border, color: primaryColor, size: height, ),
                            Container(
                              height: height,
                              width: height,
                              alignment: Alignment.center,
                              child: Text('${index+1}', style: TextStyle(color: _value==index ? Colors.white : primaryColor, fontSize: 12.0, fontWeight: _value==index ? FontWeight.bold : FontWeight.normal)),
                            ),
                          ],
                        ), onTap: (){
                          setState(() {
                            _value = index;
                          });
                        },);
                      }),
                    ),
                  ),
                  IconButton(
                    color: primaryColor,
                    icon: Icon( Icons.send, size: 40.0, ),
                    onPressed: (){

                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0,),
          ],
        ),
      ),
    );
  }
}