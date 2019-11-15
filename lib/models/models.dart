import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hi_food/models/db.dart';
import 'package:hi_food/models/location.dart';

class Resturant implements Favorites {
  final String id;
  final String name;
  final String description;
  final String image;
  final String address;
  bool recommend;
  var avgRate;
  var totalRating;
  final DateTime timestamp;
  final GeoPoint location;
  double distance;
  Subscription subscription;

  Resturant({
    this.id,
    this.name,
    this.description,
    this.image,
    this.address,
    this.location,
    this.timestamp,
    this.distance,
    this.subscription,
    this.recommend,
    this.avgRate,
    this.totalRating,
  });

  factory Resturant.fromMap(Map data) {
    return Resturant(
      id: data['id'] ?? '',
      avgRate: data['avg_rate'] ?? 0.0,
      totalRating: data['total_rating'] ?? 0.0,
      subscription: Subscription(price: 0.0, timestamp: DateTime.now()),
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      image: data['image'] ?? '',
      address: data['address'] ?? '',
      location: data['location'] ?? GeoPoint(0.0, 0.0),
      timestamp: DateTime.parse(data['timestamp'].toDate().toString()) ?? '',
      recommend: false,
    );
  }
  factory Resturant.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data ?? {};

    var res = Resturant(
      id: doc.documentID,
      avgRate: data['avg_rate'] ?? 0.0,
      totalRating: data['total_rating'] ?? 0.0,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      image: data['image'] ?? '',
      address: data['address'] ?? '',
      location: data['location'] ?? GeoPoint(0.0, 0.0),
      timestamp: DateTime.parse(data['timestamp'].toDate().toString()) ?? '',
      subscription: Subscription(price: 0.0, timestamp: DateTime.now()),
      recommend: false,
    );

    if (data['subscription'] != null) {
      res.subscription = Subscription.fromMap(data['subscription']);
      //print(res.subscription.price);
    }
    return res;
  }
}

class Food implements Favorites {
  final String name;
  final String image;
  final price;
  var unit;
  DateTime orderTimestamp;
  final String category;
  final bool available;
  final DateTime timestamp;
  final List ingredients;
  final String resturantId;
  var avgRate;
  var totalRating;
  Resturant resturant;
  Food({
    this.name,
    this.category,
    this.image,
    this.ingredients,
    this.price,
    this.available,
    this.timestamp,
    this.resturantId,
    this.resturant,
    this.unit,
    this.orderTimestamp,
    this.avgRate,
    this.totalRating,
  });

  factory Food.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Food(
      avgRate: data['avg_rate'] ?? 0.0,
      totalRating: data['total_rating'] ?? 0.0,
      resturantId: data['resturant_id'] ?? '',
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      price: data['price'] ?? '',
      category: data['category'] ?? '',
      ingredients: data['ingredients'] ?? [],
      available: data['available'] ?? false,
      timestamp: DateTime.parse(data['timestamp'].toDate().toString()) ?? '',
    );
  }
  factory Food.fromMap(Map data) {
    return Food(
      avgRate: data['avg_rate'] ?? 0.0,
      totalRating: data['total_rating'] ?? 0.0,
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      price: data['price'] ?? '',
      category: data['category'] ?? '',
      ingredients: data['ingredients'] ?? [],
      available: data['available'] ?? false,
      timestamp: DateTime.parse(data['timestamp'].toDate().toString()) ?? '',
    );
  }
}

class FoodCategory {
  final String name;
  final DateTime timestamp;
  FoodCategory({this.name, this.timestamp});

  factory FoodCategory.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return FoodCategory(
      name: data['name'],
      timestamp: DateTime.parse(data['timestamp'].toDate().toString()) ?? '',
    );
  }
}

class Subscription {
  final DateTime timestamp;
  var price;
  Subscription({this.price, this.timestamp});
  factory Subscription.fromMap(Map data) {
    return Subscription(
      price: data['price'],
      timestamp: DateTime.parse(data['timestamp'].toDate().toString()) ?? '',
    );
  }
}

abstract class Favorites {}

class Orders {
  final List<Food> foods;
  final DateTime timestamp;

  Orders({this.foods, this.timestamp});

  /* factory Orders.fromMap() {
    Map data = doc.data;

    return Orders(
      foods: data['foods'],
    );
  } */
}
