import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hi_food/models/db.dart';
import 'package:hi_food/models/models.dart';
import 'package:hi_food/pages/user/foods.dart';
import 'package:hi_food/values.dart';
import 'package:hi_food/widgets/food_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ResturantPage extends StatefulWidget {
  final Resturant resturant;
  ResturantPage(this.resturant);
  @override
  _ResturantPageState createState() => new _ResturantPageState();
}

class _ResturantPageState extends State<ResturantPage>
    with TickerProviderStateMixin {
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
              imageUrl: widget.resturant.image,
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
                    widget.resturant.name,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 40.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.event_available,
                              color: primaryColor,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              '${widget.resturant.open ? 'Open' : 'Closed'}',
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
                              Icons.free_breakfast,
                              color: primaryColor,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              '${widget.resturant.openTime} - ${widget.resturant.closeTime}',
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
                              '${widget.resturant.avgRate.toString()} (${formatNumber(widget.resturant.totalRating)}) ',
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
                              Icons.timer,
                              color: primaryColor,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              '${(widget.resturant.distance / 1000 / 0.2).round()} Mins',
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
                              Icons.location_on,
                              color: primaryColor,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              '${(widget.resturant.distance / 1000).roundToDouble()} km',
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
                              Icons.done,
                              color: primaryColor,
                              size: 20.0,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              '${widget.resturant.totalOrders}\nOrders',
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
                    widget.resturant.description,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Container(
                    height: .8,
                    margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    color: Color(0xFFB2B2B2),
                  ),
                  Container(
                    child: TabBar(
                      onTap: refresh(),
                      controller: _tabController,
                      tabs: <Widget>[
                        Tab(
                          child: Text(
                            'Info',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Foods',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 500.0,
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        infoBar(context, widget.resturant),
                        foodBar(widget.resturant, refresh),
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

infoBar(context, Resturant resturant) {
  return ListView(
    children: <Widget>[
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Reviews & Ratings',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.pushNamed(context, '/reviews');
              },
            ),
          ]),
      SizedBox(
        height: 15.0,
      ),
      Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        '${resturant.avgRate.toString()}/5',
                        style: TextStyle(fontSize: 40.0, color: primaryColor),
                      ),
                      Text('${resturant.totalRating} ratings')
                    ],
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    children: List.generate(5, (int index) {
                      var rate = Random().nextInt(80);
                      return Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(
                            width: 3.0,
                          ),
                          Text(
                            (5 - index).toString() + ' ($rate)',
                            style: TextStyle(fontSize: 14.0),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: Colors.grey),
                            height: 10.0,
                            width: 100.0,
                            child: Container(
                              margin: EdgeInsets.only(right: 100.0 - rate),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: primaryColor),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ), // Ratings
            SizedBox(
              height: 30.0,
            ),
            Container(
              child: Column(
                children: List.generate(3, (int index) {
                  return Container(
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: Color(0xFFB2B2B2), width: .8)),
                      ),
                      padding: EdgeInsets.only(top: 17.0, bottom: 17.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/rest.jpg'),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                'Samuel Adeniyi',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: <Widget>[
                              Row(
                                children: List.generate(5, (int index) {
                                  var color = primaryColor;
                                  if (index == 4) {
                                    color = Colors.grey;
                                  }
                                  return Icon(
                                    Icons.star,
                                    color: color,
                                    size: 19,
                                  );
                                }),
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Icon(
                                Icons.done_all,
                                size: 20.0,
                                color: primaryColor,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'verified purchase',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 14.0,
                                    fontStyle: FontStyle.italic),
                              ),
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
      SizedBox(
        height: 10.0,
      ),
      Container(
        height: .8,
        margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
        color: Color(0xFFB2B2B2),
      ),
      Text(
        'Other Info',
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 10.0,
      ),
      Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.cloud,
                  size: 19.0,
                  color: primaryColor,
                ),
                SizedBox(
                  width: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Website',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    InkWell(
                      onTap: () => launch(resturant.website),
                      child: Text(resturant.website,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: primaryColor,
                          )),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.email,
                  size: 19.0,
                  color: primaryColor,
                ),
                SizedBox(
                  width: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Email',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    InkWell(
                      onTap: () => launch('mailto:${resturant.email}'),
                      child: Text(
                        resturant.email,
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: primaryColor),
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  size: 19.0,
                  color: primaryColor,
                ),
                SizedBox(
                  width: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Address',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      resturant.address,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    ],
  );
}

/* foodBar(String id, refresh) {
  return foodList(Stream.fromFuture(DB().getResFoods(id)).asBroadcastStream(),
      DB().streamFoodCategories().asBroadcastStream(), refresh);
} */
foodBar(Resturant res, Function refresh) {
  return Padding(
    padding: const EdgeInsets.only(top: 15.0),
    child: Column(
      children: <Widget>[
        FutureBuilder<List<FoodCategory>>(
            future: DB().streamFoodCategories(),
            initialData: [],
            builder: (context, snapshot) {
              var categories = snapshot.data;
              return showCats(categories, refresh);
            }),
        FutureBuilder<List<Food>>(
            future: DB().getResFoods(res),
            initialData: [],
            builder: (context, snapshot) {
              var foods = snapshot.data;
              return food(foods);
            }),
      ],
    ),
  );
}
