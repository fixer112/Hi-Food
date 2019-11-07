import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hi_food/models/auth_provider.dart';
import 'package:hi_food/models/location.dart';
import 'package:latlong/latlong.dart';
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

    for (var doc in snap.documents) {
      var res = Resturant.fromFirestore(doc);

      resturants.add(res);
    }

    return resturants;
  }

  Future<List<Food>> getFoods(QuerySnapshot snap) async {
    List<Food> foods = [];
    for (var doc in snap.documents) {
      var f = Food.fromFirestore(doc);
      foods.add(f);
      var res = await getResturant(f.resturantId);
      f.resturant = res;
    }
    return foods;
  }

  Future<List<Resturant>> sortResturants(List<Resturant> resturants) async {
    bool check = await LocationProvider().check();
    if (!check) {
      return resturants;
    }
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Distance distance = new Distance();
    for (var resturant in resturants) {
      resturant.distance = distance(
          LatLng(position.latitude, position.longitude),
          LatLng(resturant.location.latitude, resturant.location.longitude));
    }

    resturants.sort((a, b) {
      return b.subscription.price
          .round()
          .compareTo(a.subscription.price.round());
    });
    List<Resturant> byPrice = resturants
        .where((resturant) => resturant.subscription.price > 0)
        .toList()
        .where((resturant) {
          var day = DateTime.now()
              .difference(resturant.subscription.timestamp)
              .inDays;
          resturant.recommend = true;
          print('day $day');
          return day < 30;
        })
        .toList()
        .where((r) => (r.distance / 1000).round() <= 15)
        .toList();
    /* for (var r in byPrice) {
      r.recommend = true;
    } */
    resturants.removeWhere((r) => byPrice.contains(r));
    resturants.sort((a, b) => a.distance.round().compareTo(b.distance.round()));

    List<Resturant> newResturants = [...byPrice, ...resturants];
    return newResturants;
  }

  Future<List<Food>> sortFoodResturants(List<Food> foods) async {
    bool check = await LocationProvider().check();
    if (!check) {
      return foods;
    }
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Distance distance = new Distance();
    for (var food in foods) {
      food.resturant.distance = distance(
          LatLng(position.latitude, position.longitude),
          LatLng(food.resturant.location.latitude,
              food.resturant.location.longitude));
    }
    foods.sort((a, b) {
      return b.resturant.subscription.price
          .round()
          .compareTo(a.resturant.subscription.price.round());
    });
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
        .where((r) => (r.resturant.distance / 1000).round() <= 15)
        .toList();
    /* for (var r in byPrice) {
      r.resturant.recommend = true;
    } */
    foods.removeWhere((r) => byPrice.contains(r));
    foods.sort((a, b) =>
        a.resturant.distance.round().compareTo(b.resturant.distance.round()));

    List<Food> newFoods = [...byPrice, ...foods];
    return newFoods;
  }

  Stream<List<Resturant>> streamResturants() {
    return _db.collection('resturants').snapshots().asyncMap((snap) async {
      List<Resturant> resturants = await getResturants(snap);

      resturants = await sortResturants(resturants);

      return resturants;
    });
  }

  Stream<List<Food>> streamFoods() {
    return _db
        .collection('foods')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .asyncMap((snap) async {
      List<Food> foods = await getFoods(snap);

      foods = await sortFoodResturants(foods);
      return foods;
    });
  }

  // Future<List<Order>> getOrder(DocumentSnapshot snap) {}
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

  Stream<List<Food>> streamAllOrders() {
    List<Orders> orders = [];

    //print(user.uid);
    return _db.collectionGroup('orders').snapshots().asyncMap((snap) async {
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
      foods.sort((a, b) => b.orderTimestamp.compareTo(a.orderTimestamp));
      return foods;
    });
  }

  Stream<List<FoodCategory>> streamFoodCategories() {
    return _db.collection('food_categories').orderBy('name').snapshots().map(
        (list) => list.documents
            .map((doc) => FoodCategory.fromFirestore(doc))
            .toList());
  }
}
