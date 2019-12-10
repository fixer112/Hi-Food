import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hi_food/values.dart';

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  Widget build( BuildContext context ){
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: Container(
                child: ListView(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 370,
                          child: FittedBox(
                            child: Image.asset('assets/images/food.jpeg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          height: 370,
                          padding: EdgeInsets.all(10.0),
                          color: Color.fromRGBO(0, 0, 0, 0.4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: primaryColor,
                                  ),
                                  height: 20,
                                  width: 130,
                                  alignment: Alignment.center,
                                  child: Text('sweet sensation', style: TextStyle(color: Colors.white, fontSize: 13),),
                                ),
                              ),
                              SizedBox(height: 17.0,),
                              Text( 'Hot Sauce Pizza with Ketchup', style: TextStyle(
                                fontSize: 23.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),),
                              Container(
                                height: .8,
                                color: Color(0xFFB7B7B7),
                                margin: EdgeInsets.all(17.0),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon( Icons.star, color: primaryColor, ),
                                          SizedBox(width: 5.0,),
                                          Text('4.5', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                                        ],
                                      ),
                                      SizedBox(height: 3.0,),
                                      Text(' 1.6k Ratings', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 12.0),),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5.0),
                                    child: Text('|', style: TextStyle(color: Color(0xFFB7B7B7)),),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon( Icons.done_all, color: primaryColor, ),
                                          SizedBox(width: 5.0,),
                                          Text('135k', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                                        ],
                                      ),
                                      SizedBox(height: 3.0,),
                                      Text(' Completed Orders', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 12.0),),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5.0),
                                    child: Text('|', style: TextStyle(color: Color(0xFFB7B7B7)),),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon( Icons.timer, color: primaryColor, ),
                                          SizedBox(width: 5.0,),
                                          Text('20mins', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                                        ],
                                      ),
                                      SizedBox(height: 3.0,),
                                      Text(' Delivery time', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 12.0),),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFFFB6D5),
                              ),
                              padding: EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Discount', style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor),),
                                  SizedBox(height: 5.0),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text( 'You get 20% off when you order over N5000 worth of snacks', textAlign: TextAlign.left,),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(15.0),
                              margin: EdgeInsets.only(bottom: 10.0),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: .8, color: Color(0xffb7b7b7),)),
                              ),
                              child: Text(
                                'Ingredients (4)',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(15.0),
                              height: 150,
                              alignment: Alignment.center,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(18.0),
                                        child: Container(
                                          height: 90,
                                          width: 90,
                                          child: FittedBox(
                                            child: Image.asset('assets/images/food.jpeg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5.0,),
                                      Text('TOMATO', style: TextStyle(fontSize: 13.0),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(12.0),
                              child: Column(
                                children: <Widget>[
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
                                          // Navigate to full reviews page
                                        },
                                      ),
                                    ]
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10.0),
                                    decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(width: .8, color: Color(0xffb7b7b7),)),
                                    ),
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
                                                    style: TextStyle(fontSize: 40.0, color: Colors.pink),
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
                                                      Icon(Icons.star, color: Colors.pink, size: 20,),
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
                                                            color: Colors.pink
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
                                        SizedBox(height: 10.0,),
                                        Container(
                                          child: Column(
                                            children: List.generate(2, (int index){
                                              return Container( padding: EdgeInsets.all(15.0), margin: EdgeInsets.only(top: 20.0),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20.0),
                                                border: Border.all(color: Color(0xffd7d7d7), width: .8),
                                              ),
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      CircleAvatar(
                                                        backgroundImage: AssetImage('assets/images/food.jpeg'),
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
                                                        var color = Colors.pink;
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
                                                    margin: EdgeInsets.only(top: 10.0),
                                                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                                    child: Text(
                                                      '''To add custom fonts to your application, add a fonts section here, in this "flutter" section. Each entry in this list should have a list giving the asset and other descriptors for the font. For''',
                                                      style: TextStyle(),
                                                    ),
                                                  ),
                                                  /* Row (
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Icon( Icons.done_all, size: 20.0, color: Colors.pink, ),
                                                      SizedBox(width: 8),
                                                      Text('verified purchase', style: TextStyle(color: Colors.pink, fontSize: 14.0, fontStyle: FontStyle.italic),),
                                                    ],
                                                  ), */
                                                ],
                                              ));
                                            }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: AppBar(
                    elevation: 0,
                    backgroundColor: Color.fromRGBO(0, 0, 0, 0.2),
                    leading: IconButton(
                      color: Colors.white,
                      icon: Icon( Icons.arrow_back ),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    actions: <Widget>[
                      IconButton(
                        color: primaryColor,
                        icon: Icon( Icons.share ),
                        onPressed: (){

                        },
                      ),
                      IconButton(
                        color: primaryColor,
                        icon: Icon( Icons.favorite ),
                        onPressed: (){

                        },
                      ),
                      IconButton(
                        color: primaryColor,
                        icon: Icon( Icons.add_shopping_cart ),
                        onPressed: (){
                          wannaCart(context);
                        },
                      ),
                    ],
                  ),
                ),
                /* Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(13.0),
                  child: RaisedButton(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon( Icons.add_shopping_cart ),
                          SizedBox(width: 10.0,),
                          Text('ADD TO CART'),
                        ],
                      ),
                    ),
                    color: primaryColor,
                    textColor: Colors.white,
                    onPressed: (){

                    },
                  ),
                ),*/
              ]
            ),
          ],
        ),
      ),
    );
  }

  void wannaCart(context){
    showDialog(
      context: context,
      builder: (context){
        return MiniCart();
      }
    );
  }
}

class MiniCart extends StatefulWidget {
  @override
  _MiniCartState createState() => _MiniCartState();
}

class _MiniCartState extends State<MiniCart> {
  int cartQuantity = 1;

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              child: Container(color: Colors.transparent,),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            color: Colors.white,
            height: 250,
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    'N1,499.99',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Card(
                  elevation: 4.0,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 70,
                            width: 90,
                            child: FittedBox(
                              child: Image.asset('assets/images/food.jpeg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.0,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Pineapple Pizza', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                              SizedBox(height: 12.0,),
                              Row(
                                children: <Widget>[
                                  controlButton('-', (){
                                    setState((){
                                      cartQuantity--;
                                    });
                                  }),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 12.0),
                                    child: Text('$cartQuantity', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, )),
                                  ),
                                  controlButton('+', (){
                                    setState((){
                                      cartQuantity++;
                                    });
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      actionButton( Icons.delete_sweep, 'REMOVE', (){
                        // remove from cart
                        Navigator.pop(context);
                      }),
                      SizedBox(width: 10.0,),
                      actionButton( Icons.add_box, 'DONE', (){
                        // increment or reduce quantity in cart
                        Navigator.pop(context);
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]
      )
    );
  }

  Widget actionButton( icon, text, function ){
    return RaisedButton(
      color: primaryColor,
      textColor: Colors.white,
      child: Row(
        children: <Widget>[
          Icon( icon ),
          SizedBox(width: 10.0,),
          Text( text )
        ],
      ),
      onPressed: function,
    );
  }

  Widget controlButton( text, function ){
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(13.0),
        ),
        child: Text(text, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18), textAlign: TextAlign.center,),
      ),
      onTap: function,
    );
  }
}