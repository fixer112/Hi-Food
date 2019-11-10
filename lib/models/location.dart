import 'package:flutter/material.dart';
import 'package:geohash/geohash.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hi_food/models/models.dart';
import 'package:latlong/latlong.dart';
import 'package:location_permissions/location_permissions.dart';

class LocationProvider with ChangeNotifier {
  Geolocator geolocator = Geolocator();

  Position _position;

  Position getLocation() {
    return _position;
  }

  getGeohashRange(
    double latitude,
    double longitude,
    double distance, // miles
  ) {
    var lat = 0.0144927536231884; // degrees latitude per mile
    var lon = 0.0181818181818182;
    //1.609// degrees longitude per mile
    distance = distance;

    var lowerLat = latitude - lat * distance;
    var lowerLon = longitude - lon * distance;

    var upperLat = latitude + lat * distance;
    var upperLon = longitude + lon * distance;

    var lower = Geohash.encode(lowerLat, lowerLon);
    var upper = Geohash.encode(upperLat, upperLon);
    var data = {'upper': upper, 'lower': lower};
    return data;
  }

  Future<bool> check() async {
    Geolocator geolocator = Geolocator();
    GeolocationStatus status =
        await geolocator.checkGeolocationPermissionStatus();

    if (status == GeolocationStatus.granted) {
      bool enabled = await geolocator.isLocationServiceEnabled();
      if (!enabled) {
        return false;
      }

      return true;
    } else {
      PermissionStatus permission =
          await LocationPermissions().requestPermissions();

      if (permission == PermissionStatus.granted) {
        return true;
      }

      return false;
    }
  }

  updateLocation() async {
    Position newPosition = await Geolocator().getCurrentPosition();
    //.timeout(new Duration(seconds: 20));

    _position = newPosition;
    notifyListeners();
    print('position ${newPosition.latitude}');

    //print('Error: ${e.toString()}');
  }

  getDistance(Resturant resturant) async {
    //updateLocation();
    /* GeolocationStatus status =
        await Geolocator().checkGeolocationPermissionStatus(); */
    //GeolocationStatus status = await check();
    /* print(status);
    if (status == GeolocationStatus.disabled) {
      notifyListeners();
      return 0.0;
    } */

    /* Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high); */

    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    //print(position);
    Distance distance = new Distance();
    double distanceInMeters;
    distanceInMeters = distance(
        new LatLng(position.latitude, position.longitude),
        new LatLng(resturant.location.latitude, resturant.location.longitude));
    /* await Geolocator().distanceBetween(
      position.latitude,
      position.longitude,
      resturant.location.latitude,
      resturant.location.longitude,
    ); */

    notifyListeners();
    //print(getLocation());
    return distanceInMeters;
  }
}
