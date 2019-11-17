import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geohash/geohash.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hi_food/models/auth_provider.dart';
import 'package:hi_food/models/location.dart';
import 'package:hi_food/values.dart';
import 'package:latlong/latlong.dart';
import 'package:location_permissions/location_permissions.dart';
import 'dart:async';
import 'models.dart';

class DB with ChangeNotifier {
  final Firestore _db = Firestore.instance;
  var loc = LocationProvider();

  Future<Resturant> getResturant(id) async {
    var data = await _db.collection('resturants').document(id).get();
    var res = Resturant.fromFirestore(data);
    //res.distance = 0.0;
    return res;
  }

  Future<Food> getFood(id) async {
    var data = await _db.collection('foods').document(id).get();
    var food = Food.fromFirestore(data);
    return food;
  }

  Future<List<Resturant>> getResturants(QuerySnapshot snap) async {
    List<Resturant> resturants = [];

    //var geo = Geoflutterfire();
    for (var doc in snap.documents) {
      //print(geo.data);
      var res = Resturant.fromFirestore(doc);
      Position position = await Geolocator().getCurrentPosition();
      Distance distance = new Distance();

      res.distance = distance(LatLng(position.latitude, position.longitude),
          LatLng(res.location.latitude, res.location.longitude));

      resturants.add(res);
    }

    return resturants;
  }

  Future<List<Food>> getFoods(QuerySnapshot snap) async {
    List<Food> foods = [];
    Position position = await Geolocator().getCurrentPosition();
    Distance distance = new Distance();

    for (var doc in snap.documents) {
      var f = Food.fromFirestore(doc);
      var res = await getResturant(f.resturantId);
      //print(res.location.latitude);
      f.resturant = res;
      f.resturant.distance = distance(
          LatLng(position.latitude, position.longitude),
          LatLng(
              f.resturant.location.latitude, f.resturant.location.longitude));
      //print(f.resturant.distance);
      foods.add(f);
    }
    return foods;
  }

  Future<List<Resturant>> sortResturants(List<Resturant> resturants) async {
    /* bool check = await LocationProvider().check();
    if (!check) {
      return resturants;
    } */

    resturants.sort((a, b) {
      return b.subscription.price
          .round()
          .compareTo(a.subscription.price.round());
    });
    double subDis = 0.2 * defaultLocationRange;
    //print(subDis);
    List<Resturant> byPrice = resturants
        .where((resturant) => resturant.subscription.price > 0)
        .toList()
        .where((resturant) {
          var day = DateTime.now()
              .difference(resturant.subscription.timestamp)
              .inDays;
          resturant.recommend = true;
          //print('day $day');
          return day < 30;
        })
        .toList()
        .where((r) => (r.distance / 1000).round() <= subDis)
        .toList();
    /* for (var r in byPrice) {
      r.recommend = true;
    } */
    //resturants.removeWhere((r) => byPrice.contains(r));
    resturants.sort((a, b) => a.distance.round().compareTo(b.distance.round()));

    List<Resturant> newResturants = [...byPrice, ...resturants]
        .where(
            (resturant) => (resturant.distance / 1000) <= defaultLocationRange)
        .toList();
    return newResturants;
  }

  Future<List<Food>> sortFoodResturants(List<Food> foods) async {
    /* bool check = await LocationProvider().check();

    if (!check) {
      return foods;
    } */
    /* Position position = await Geolocator().getCurrentPosition();
    Distance distance = new Distance();
    for (var food in foods) {
      food.resturant.distance = distance(
          LatLng(position.latitude, position.longitude),
          LatLng(food.resturant.location.latitude,
              food.resturant.location.longitude));
    } */
    foods.sort((a, b) {
      return b.resturant.subscription.price
          .round()
          .compareTo(a.resturant.subscription.price.round());
    });
    double subDis = 0.2 * defaultLocationRange;
    List<Food> byPrice = foods
        .where((food) => food.resturant.subscription.price > 0)
        .toList()
        .where((food) {
          var day = DateTime.now()
              .difference(food.resturant.subscription.timestamp)
              .inDays;
          food.resturant.recommend = true;
          // print('day $day');
          return day < 30;
        })
        .toList()
        .where((r) => (r.resturant.distance / 1000).round() <= subDis)
        .toList();

    //foods.removeWhere((r) => byPrice.contains(r));
    foods.sort((a, b) =>
        a.resturant.distance.round().compareTo(b.resturant.distance.round()));

    List<Food> newFoods = [...byPrice, ...foods]
        .where(
            (food) => (food.resturant.distance / 1000) <= defaultLocationRange)
        .toList();
    return newFoods;
  }

  Stream<List<Resturant>> streamResturants() async* {
    Position position = await Geolocator().getCurrentPosition();
    var range = LocationProvider().getGeohashRange(
        position.latitude, position.longitude, (maxLocationRange / 1.609));
    // print((50 / 1.609));
    //print(Geohash.encode(7.14484395, 3.9995));

    yield* _db
        .collection('resturants')
        .where('geohash', isGreaterThanOrEqualTo: range['lower'])
        .where('geohash', isLessThanOrEqualTo: range['upper'])
        //.limit(50)
        .snapshots()
        .asyncMap((snap) async {
      List<Resturant> resturants = await getResturants(snap);

      resturants = await sortResturants(resturants);

      return resturants;
    });
  }

  Stream<List<Food>> streamFoods() async* {
    Position position = await Geolocator().getCurrentPosition();
    //print('${position.latitude} ${position.longitude}');
    //print(Geohash.encode(7.14484395, 3.199580629643363));
    //print(defaultLocationRange);
    var range = LocationProvider().getGeohashRange(
        position.latitude, position.longitude, (maxLocationRange / 1.609));
    List<Food> foods = [];

    yield* _db
        .collection('foods')
        .where('geohash', isGreaterThanOrEqualTo: range['lower'])
        .where('geohash', isLessThanOrEqualTo: range['upper'])
        //.limit(2)
        .snapshots()
        .asyncMap((snap) async {
      foods = await getFoods(snap);
      foods = await sortFoodResturants(foods);
      //print(foods);
      return foods;
    });
  }

  Stream<List<Orders>> streamMyOrders() async* {
    var auth = Auth();
    List<Orders> orders = [];
    var user = await auth.getUser();

    //print(user.uid);
    yield* _db
        .collection('users')
        .document(user.uid)
        .collection('orders')
        .snapshots()
        .asyncMap((snap) async {
      List<Food> foods = [];
      for (var doc in snap.documents) {
        for (var f in doc.data['foods']) {
          var food = await getFood(f['food_id']);
          food.unit = f['unit'];
          food.orderTimestamp =
              DateTime.parse(doc.data['timestamp'].toDate().toString());
          foods.add(food);
        }
        var order = Orders(
            foods: foods,
            timestamp:
                DateTime.parse(doc.data['timestamp'].toDate().toString()));
        orders.add(order);
      }
      return orders;
    });
  }

  Stream<List<Food>> streamAllOrders() async* {
    //print(user.uid);
    /*  Position position = await Geolocator().getCurrentPosition();
    var range = LocationProvider().getGeohashRange(
        position.latitude, position.longitude, (defaultLocationRange / 1.609));
    */
    yield* _db
        .collectionGroup('orders')
        .orderBy('timestamp', descending: true)
        //.where('geohash', isGreaterThanOrEqualTo: range['lower'])
        // .where('geohash', isLessThanOrEqualTo: range['upper'])
        .limit(5)
        .snapshots()
        .asyncMap((snap) async {
      List<Orders> orders = [];
      List<Food> foods = [];
      for (var doc in snap.documents) {
        for (var f in doc.data['foods']) {
          var food = await getFood(f['food_id']);
          food.unit = f['unit'];
          food.orderTimestamp =
              DateTime.parse(doc.data['timestamp'].toDate().toString());
          foods.add(food);
        }
        var order = Orders(
            foods: foods,
            timestamp:
                DateTime.parse(doc.data['timestamp'].toDate().toString()));
        orders.add(order);
      }
      for (var order in orders) {
        for (var food in order.foods) {
          if (!foods.contains(food)) {
            //print('${food.name} ${food.unit} ${food.timestamp}');
            foods.add(food);
          }
        }
      }
      //foods.sort((a, b) => b.orderTimestamp.compareTo(a.orderTimestamp));
      return foods;
    });
  }

  Stream<List<FoodCategory>> streamFoodCategories() {
    return _db.collection('food_categories').orderBy('name').snapshots().map(
        (list) => list.documents
            .map((doc) => FoodCategory.fromFirestore(doc))
            .toList());
  }

  /* Future<QuerySnapshot> searchFood(text) async {
    return _db.collection('foods').startAt([text]).endAt([text + '\uf8ff'])
        //.where('name', isGreaterThanOrEqualTo: text)
        //.where('name', isLessThanOrEqualTo: text + 'z')
        .getDocuments();
  }

  Future<QuerySnapshot> searchResturant(text) async {
    return _db
        .collection('resturants')
        .where('name', isEqualTo: text)
        .where('address', isEqualTo: text)
        .getDocuments();
  }

  Stream<List<Resturant>> searchResturant2() async* {
    yield* _db
        .collection('resturants')
        .where('name', isEqualTo: search)
        .where('address', isEqualTo: search)
        .snapshots()
        .asyncMap((snap) async {
      var res = await getResturants(snap);
      return res;
    });
  } */
}
