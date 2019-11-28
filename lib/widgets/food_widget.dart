import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hi_food/models/models.dart';
import 'package:hi_food/values.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

Widget food(List<Food> foods) {
  if (cat != 'all') {
    foods = foods.where((food) => food.category == cat).toList();
  }
  if (foodSearch != '') {
    //print(search.contains('rice'));

    foods = foods.where((food) {
      bool cond = food.name.toUpperCase().contains(foodSearch.toUpperCase());

      return cond;
    }).toList();
    //print(foods);
  }
  return Column(
      children: foods.map((food) {
    return Opacity(
      opacity: food.resturant.open ? 1 : 0.7,
      child: Card(
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
                              ? food.name.substring(0, 22).toUpperCase() + '...'
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
                              fontSize: 15.0, fontWeight: FontWeight.w300)),
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
                              rating: double.parse(food.avgRate.toString()),
                              size: 20.0,
                              color: ratingColor,
                              borderColor: ratingColor,
                              spacing: 0.0),
                          Text(
                            '(${formatNumber(food.totalRating)})',
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
                                  fontStyle: FontStyle.italic, fontSize: 12.0),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
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
      ),
    );
  }).toList());
}
