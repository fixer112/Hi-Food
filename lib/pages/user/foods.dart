import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hi_food/models/db.dart';
import 'package:hi_food/models/location.dart';
import 'package:hi_food/models/models.dart';
import 'package:hi_food/values.dart';
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
    super.initState();
    checkGPS(context);
    checkGps(function: () => setState(() {}));
    //refresh();
    //checkGps(function: () => setState(() {}));

    /* _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(curve: Curves.bounceOut, parent: _animationController));
    _animationController.forward(); */
  }

  var db = DB();
  final double btnRadius = 5;
  double rating = 0.0;
  refresh() {
    setState(() {});
  }

  /* setAvailable(bool value) {
    recentAvailable = value;
    refresh();
  }

  bool recentAvailable = false; */

  @override
  Widget build(BuildContext context) {
    //checkGps(function: () => setState(() {}));
    return !check
        ? noGps(() {
            checkGps(function: () => setState(() {}));
            checkGPS(context);
          })
        : Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Search('food'),
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
                  /* ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(6, (int index) {
                return Container(width: 200.0, child: demoLister);
              }),
            ), */
                ),

                SizedBox(
                  height: 10.0,
                ),
                StreamProvider<List<FoodCategory>>.value(
                  value: db.streamFoodCategories(),
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
                  value: db.streamFoods(),
                  child: Products(),
                  catchError: (context, e) {
                    print(e);
                    return;
                  },
                  initialData: [],
                ),
                //productList(),
              ],
            ),
          );
  }
}

class OrdersW extends StatefulWidget {
  /* OrdersW({this.recentAvailable});
  final Function(bool value) recentAvailable; */

  _OrdersWState createState() => _OrdersWState();
}

class _OrdersWState extends State<OrdersW> {
  @override
  Widget build(BuildContext context) {
    var foods = Provider.of<List<Food>>(context);

    //foods = [];
    /* if (foods.length >= 10) {
      foods = foods.sublist(0, 10);
    }

    if (foods.length > 0) {
      Future.delayed(Duration(seconds: 2), () => widget.recentAvailable(true));

      //widget.notify();
    } else {
      //Future.delayed(Duration(seconds: 2), () => widget.recentAvailable(true));
      //widget.notify();
    } */

    return Container(
        height: 220.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(foods.length, (int index) {
            final ago = timeago.format(
              foods[index].orderTimestamp,
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
                      //print('Card tapped.');
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 120.0,
                          width: 200.0,
                          child: FittedBox(
                            child: CachedNetworkImage(
                              //height: 50.0,
                              imageUrl: foods[index].image,
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
                                    foods[index].name.length > 10
                                        ? foods[index]
                                                .name
                                                .substring(0, 10)
                                                .toUpperCase() +
                                            '...'
                                        : foods[index].name.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'N ' + foods[index].price.toString(),
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
                                    rating: 4.1,
                                    size: 20.0,
                                    color: ratingColor,
                                    borderColor: primaryColor,
                                    spacing: 0.0),
                                Text(
                                  ' (50)',
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
          }),
        ));
  }
}

class Categories extends StatefulWidget {
  final Function() notify;
  Categories({this.notify});

  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int value = 0;
  @override
  void initState() {
    super.initState();
    cat = 'all';
  }

  @override
  Widget build(BuildContext context) {
    var categories = Provider.of<List<FoodCategory>>(context);

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
              labelStyle: TextStyle(
                  color: value == index ? Colors.white : Colors.black),
              label: Text(categories[index].name.toUpperCase()),
              selected: value == index,
              onSelected: (selected) {
                setState(() {
                  value = index;
                  cat = categories[index].name;
                  //Products(set);
                  print(cat);
                });
                widget.notify();
              },
            ),
          );
        }),
      ),
    );
  }
}

class Products extends StatefulWidget {
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    var foods = Provider.of<List<Food>>(context);
    var loc = Provider.of<LocationProvider>(context);

    if (cat != 'all') {
      foods = foods.where((food) => food.category == cat).toList();
    }

    /* foods.sort((a, b) {
      return a.resturant.location
          .compareTo(b.resturant.distance.toInt());
    }); */
    //print(foods);
    //return Container();
    return foods == null
        ? Container()
        : Column(
            children: foods.map((food) {
            //var res = db.getResturant(food.resturantId);
            //print(food.category);
            return Card(
              elevation: 4.0,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {},
                  splashColor: primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                food.name.length > 22
                                    ? food.name.substring(0, 22).toUpperCase() +
                                        '...'
                                    : food.name.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                )),
                            SizedBox(
                              height: 3,
                            ),
                            Text('N${food.price}',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w300)),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SmoothStarRating(
                                    allowHalfRating: true,
                                    onRatingChanged: (v) {
                                      //rating = v;
                                      //setState(() {});
                                    },
                                    starCount: 5,
                                    rating: 4.3,
                                    size: 20.0,
                                    color: ratingColor,
                                    borderColor: primaryColor,
                                    spacing: 0.0),
                                Text(
                                  ' (50)',
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  food.resturant.name,
                                  style: TextStyle(
                                      //fontStyle: FontStyle.italic,
                                      fontSize: 14.0),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    '(${food.category})',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 12.0),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Row(children: <Widget>[
                                food.resturant.distance == null
                                    ? Container()
                                    : Row(children: <Widget>[
                                        Icon(
                                          Icons.location_on,
                                          size: 15.0,
                                        ),
                                        Text(
                                          (food.resturant.distance / 1000)
                                                  .round()
                                                  .toString() +
                                              ' km',
                                          style: TextStyle(fontSize: 12.00),
                                        )
                                      ]),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: food.resturant.recommend != true
                                      ? Container()
                                      : Icon(Icons.star, size: 15.0),
                                )
                              ]),
                            ),
                          ]),
                      Container(
                          height: 100.0,
                          width: 100.0,
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
                          ))
                    ],
                  ),
                ),
              ),
            );
          }).toList());
  }
}
