import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hi_food/models/db.dart';
import 'package:hi_food/models/location.dart';
import 'package:hi_food/models/models.dart';
import 'package:hi_food/values.dart';
import 'package:hi_food/widgets/search.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Resturants extends StatefulWidget {
  Resturants({Key key}) : super(key: key);

  _ResturantState createState() => _ResturantState();
}

class _ResturantState extends State<Resturants> {
  var db = DB();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkGPS(context);
    checkGps(function: () => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return !check
        ? noGps(() {
            checkGps(function: () => setState(() {}));
            checkGPS(context);
          })
        : ListView(
            padding: EdgeInsets.all(6.0),
            children: <Widget>[
              Search('resturant'),
              SizedBox(
                height: 10.0,
              ),
              StreamProvider<List<Resturant>>.value(
                value: db.streamResturants(),
                child: ResturantW(),
                catchError: (context, e) {
                  print(e);
                  return;
                },
                initialData: [],
              ),
            ],
          );
  }
}

class ResturantW extends StatefulWidget {
  ResturantW({Key key}) : super(key: key);

  _ResturantWState createState() => _ResturantWState();
}

class _ResturantWState extends State<ResturantW> {
  //final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var resturants = Provider.of<List<Resturant>>(context);
    var loc = Provider.of<LocationProvider>(context);

    /* resturants.sort((a, b) {
      return a.distance.toInt().compareTo(b.distance.toInt());
    }); */
    // Future<double> distanceInMeters = Geolocator().distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);

    //return Container(
    //print(resturants);
    return ListView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      children: resturants.map((resturant) {
        //print(resturant.distance);
        return Card(
          elevation: 4.0,
          child: InkWell(
            splashColor: primaryColor,
            onTap: () {},
            child: Row(
              children: <Widget>[
                Container(
                    height: 85.0,
                    width: 85.0,
                    child: FittedBox(
                      child: CachedNetworkImage(
                        //height: 50.0,
                        imageUrl: resturant.image,
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
                    )),
                SizedBox(
                  width: 15.0,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
                  Text(
                    resturant.name,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  Text(
                    resturant.description.length > 25
                        ? resturant.description.substring(0, 25).toUpperCase() +
                            '...'
                        : resturant.description.toUpperCase(),
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SmoothStarRating(
                          allowHalfRating: true,
                          onRatingChanged: (v) {
                            //rating = v;
                            //setState(() {});
                          },
                          starCount: 5,
                          rating: double.parse(resturant.avgRate.toString()),
                          size: 20.0,
                          color: ratingColor,
                          borderColor: ratingColor,
                          spacing: 0.0),
                      Text(
                        '(${formatNumber(resturant.totalRating)})',
                        style: TextStyle(fontSize: 13),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Row(children: <Widget>[
                      resturant.distance == null
                          ? Container()
                          : Row(children: <Widget>[
                              Icon(
                                Icons.location_on,
                                size: 15.0,
                              ),
                              Text(
                                (resturant.distance / 1000).round().toString() +
                                    ' km',
                                style: TextStyle(fontSize: 12.00),
                              )
                            ]),
                      /* FutureBuilder(
                          future: loc.getDistance(resturant),
                          builder: (context, snap) {
                            if (snap.data == null) {
                              return Container();
                            }
                            return Row(children: <Widget>[
                              Icon(
                                Icons.location_on,
                                size: 15.0,
                              ),
                              Text(
                                (snap.data / 1000).round().toString() + ' km',
                                style: TextStyle(fontSize: 12.00),
                              )
                            ]);
                          },
                        ), */
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: resturant.recommend != true
                            ? Container()
                            : Icon(Icons.star, size: 15.0),
                      )
                    ]),
                  ),
                ]),
              ],
            ),
          ),
        );
      }).toList(),
    );

    // );
  }
}
