import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hi_food/models/db.dart';
import 'package:hi_food/models/models.dart';
import 'package:hi_food/pages/user/foods.dart';
import 'package:hi_food/values.dart';
import 'package:hi_food/widgets/food_widget.dart';
import 'package:hi_food/widgets/restaurant_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class FoodPage extends StatefulWidget {
  final Food food;
  FoodPage(this.food);
  @override
  _FoodPageState createState() => new _FoodPageState();
}

class _FoodPageState extends State<FoodPage> with TickerProviderStateMixin {
  TabController _tabController;
  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    cat = 'all';
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //var top = 0.0;

    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          height: 300.0,
          color: primaryColor,
          child: FittedBox(
            child: CachedNetworkImage(
              //height: 50.0,
              imageUrl: widget.food.image,
              placeholder: (context, url) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  backgroundColor: primaryColor,
                ),
              ),
              errorWidget: (context, url, error) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Icon(
                  Icons.error,
                  color: primaryColor,
                ),
              ),
            ),
            fit: BoxFit.cover,
          ),
        ),
        ListView(
          children: <Widget>[
            Container(
              height: 300.0,
              color: Colors.transparent,
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    widget.food.name,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              widget.food.available
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: primaryColor,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              '${widget.food.available ? 'Available' : 'Not Available'}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Container(
                          width: 1,
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          color: Color(0xFF424242),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: primaryColor,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              '${widget.food.avgRate.toString()} (${formatNumber(widget.food.totalRating)}) ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Container(
                          width: 1,
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          color: Color(0xFF424242),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.attach_money,
                              color: primaryColor,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              'N ${widget.food.price.toString()}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        
                      ],
                    ),
                  ),
                  Container(
                    height: .8,
                    margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    color: Color(0xFFB2B2B2),
                  ),
                  Text(
                    'Ingredients: ${widget.food.ingredients.join(', ')}.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Container(
                    height: .8,
                    margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    color: Color(0xFFB2B2B2),
                  ),
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      'Restaurants',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Container(
                    height: 400,
                    child: ListView(
                      children: <Widget>[
                        RestaurantWidget(name: 'Mama Cass', distance: 2,),
                        RestaurantWidget(name: 'Evelyn Moore', distance: 5,),
                        RestaurantWidget(name: 'Vellum', distance: 3,),
                        RestaurantWidget(name: 'Dobchiran', distance: 9,),
                        RestaurantWidget(name: 'Reamer Ltd', distance: 2,),
                        RestaurantWidget(name: 'Mama Radix', distance: 1,),
                      ],
                    ),
                  )
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
            actions: <Widget>[
              /* IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ), */
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: primaryColor,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    ));
    //  );
  }
}
