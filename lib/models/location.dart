import 'dart:io' show Platform;

import 'package:flutter/material.dart';
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

  //bool gpsEnabled = false;

  Future<bool> check() async {
    Geolocator geolocator = Geolocator();
    GeolocationStatus status =
        await geolocator.checkGeolocationPermissionStatus();
    bool enabled = await geolocator.isLocationServiceEnabled();
    //print(status);
    if (status == GeolocationStatus.granted) {
      if (!enabled) {
        //bool isOpened = await LocationPermissions().openAppSettings();
        bool isShown =
            await LocationPermissions().shouldShowRequestPermissionRationale();
        //gpsEnabled = false;
        return false;
      }
      //gpsEnabled = true;
      return true;
    } else {
      PermissionStatus permission =
          await LocationPermissions().requestPermissions();
      print(permission);
      if (permission == PermissionStatus.granted) {
        //gpsEnabled = true;
        return true;
      }
      //gpsEnabled = false;
      return false;
    }
  }

  updateLocation() async {
    Position newPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
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
