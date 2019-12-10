import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hi_food/models/db.dart';
import 'package:hi_food/models/models.dart';
//import 'package:hi_food/pages/user/food.dart';
import 'package:hi_food/pages/user/foodpage.dart';
import 'package:hi_food/values.dart';
import 'package:hi_food/widgets/food_widget.dart';
import 'package:hi_food/widgets/search.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:timeago/timeago.dart' as timeago;

class Foods extends StatefulWidget {
  Foods({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FoodsState createState() => _FoodsState();
}

class _FoodsState extends State<Foods> with SingleTickerProviderStateMixin {
  //AnimationController _animationController;

  //Animation<double> _animation;
  @override
  void initState() {
    checkGps(function: () => setState(() {}));
    checkGPS(context);
    super.initState();
  }

  var db = DB();
  final double btnRadius = 5;
  double rating = 0.0;
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return !check
        ? noGps(() {
            checkGps(function: () => setState(() {}));
            checkGPS(context);
          })
        : Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Search('food', refresh),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      height: 50.0,
                      padding: EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 4.0, color: primaryColor),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'RECENT ORDERS',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          RaisedButton(
                            color: primaryColor,
                            textColor: Colors.white,
                            onPressed: () {},
                            child: const Text('VIEW ALL',
                                style: TextStyle(fontSize: 15)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      //height: 200,
                      child: StreamProvider<List<Food>>.value(
                        value: db.streamAllOrders(),
                        child: OrdersW(),
                        catchError: (context, e) {
                          print(e);
                          return;
                        },
                        initialData: [],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    foodList(db.streamFoods(),
                        Stream.fromFuture(db.streamFoodCategories()), refresh)
                  ],
                )
              ],
            ),
          );
  }
}

class OrdersW extends StatefulWidget {
  _OrdersWState createState() => _OrdersWState();
}

class _OrdersWState extends State<OrdersW> {
  @override
  Widget build(BuildContext context) {
    var foods = Provider.of<List<Food>>(context);

    if (foods.length >= 10) {
      foods = foods.sublist(0, 10);
    }

    return Container(
        height: 220.0,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: foods.map((food) {
            final ago = timeago.format(
              food.orderTimestamp,
            );

            //print(foods[index].name);
            return Container(
              width: 200.0,
              child: Container(
                child: Card(
                  elevation: 4.0,
                  child: InkWell(
                    splashColor: primaryColor,
                    onTap: () {
                      print('So well');
                      // Changed the navigator just to test the new food page
                      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FoodPage(food)));
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FoodPage()));
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 120.0,
                          width: 200.0,
                          child: FittedBox(
                            child: CachedNetworkImage(
                              //height: 50.0,
                              imageUrl: food.image,
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
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(10),
                          child: Column(children: <Widget>[
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    food.name.length > 10
                                        ? food.name
                                                .substring(0, 10)
                                                .toUpperCase() +
                                            '...'
                                        : food.name.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'N ' + food.price.toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: <Widget>[
                                SmoothStarRating(
                                    allowHalfRating: true,
                                    onRatingChanged: (v) {
                                      //rating = v;
                                      //setState(() {});
                                    },
                                    starCount: 5,
                                    rating:
                                        double.parse(food.avgRate.toString()),
                                    size: 20.0,
                                    color: ratingColor,
                                    borderColor: ratingColor,
                                    spacing: 0.0),
                                Text(
                                  '(${formatNumber(food.totalRating)})',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ]),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(ago),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ));
  }
}

class Categories extends StatefulWidget {
  final Function() notify;
  Categories({this.notify});

  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    super.initState();
    cat = 'all';
  }

  @override
  Widget build(BuildContext context) {
    var categories = Provider.of<List<FoodCategory>>(context);

    return showCats(categories, widget.notify);
  }
}

class Products extends StatefulWidget {
  Products({this.notify});
  final Function() notify;
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var foods = Provider.of<List<Food>>(context);

    //var loc = Provider.of<LocationProvider>(context);

    return food(foods);
  }
}

foodList(Stream<List<Food>> streamFoods,
    Stream<List<FoodCategory>> streamFoodCats, Function refresh) {
  return Column(
    children: <Widget>[
      StreamProvider<List<FoodCategory>>.value(
        value: streamFoodCats,
        child: Categories(notify: refresh),
        catchError: (context, e) {
          print(e);
          return;
        },
        initialData: [],
      ),
      SizedBox(
        height: 10.0,
      ),
      StreamProvider<List<Food>>.value(
        updateShouldNotify: (_, __) => true,
        value: streamFoods,
        child: Products(notify: refresh),
        catchError: (context, e) {
          print(e);
          return;
        },
        initialData: [],
      ),
    ],
  );
}

showCats(List<FoodCategory> categories, Function notify) {
  int value = 0;
  return Container(
    height: 50,
    child: ListView(
      //shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      children: List.generate(categories.length, (index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ChoiceChip(
            selectedColor: primaryColor,
            //disabledColor: ,
            labelStyle:
                TextStyle(color: value == index ? Colors.white : Colors.black),
            label: Text(categories[index].name.toUpperCase()),
            selected: value == index,
            onSelected: (selected) {
              //setState(() {
              value = index;
              cat = categories[index].name;
              //Products(set);
              //print(cat);
              //});
              notify();
            },
          ),
        );
      }),
    ),
  );
}
