import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:hi_food/models/location.dart';
import 'package:hi_food/models/models.dart';
import 'package:intl/intl.dart';

//Strings
String appName = 'Hi-Food';
String cat = 'all';

//Range
double defaultLocationRange;
double minLocationRange;
double maxLocationRange;

//Text
String search;

//Bools
bool check = false;

//Colors
Map<int, Color> color = {
  50: Color.fromRGBO(147, 205, 72, .1),
  100: Color.fromRGBO(147, 205, 72, .2),
  200: Color.fromRGBO(147, 205, 72, .3),
  300: Color.fromRGBO(147, 205, 72, .4),
  400: Color.fromRGBO(147, 205, 72, .5),
  500: Color.fromRGBO(147, 205, 72, .6),
  600: Color.fromRGBO(147, 205, 72, .7),
  700: Color.fromRGBO(147, 205, 72, .8),
  800: Color.fromRGBO(147, 205, 72, .9),
  900: Color.fromRGBO(147, 205, 72, 1),
};
Map<int, Color> getSwatch(String color) {
  final hslColor = HSLColor.fromColor(Color(int.parse('0xFF' + color)));
  final lightness = hslColor.lightness;

  /// if [500] is the default color, there are at LEAST five
  /// steps below [500]. (i.e. 400, 300, 200, 100, 50.) A
  /// divisor of 5 would mean [50] is a lightness of 1.0 or
  /// a color of #ffffff. A value of six would be near black
  /// but not quite.
  final lowDivisor = 6;

  /// if [500] is the default color, there are at LEAST four
  /// steps above [500]. A divisor of 4 would mean [900] is
  /// a lightness of 0.0 or color of #000000
  final highDivisor = 5;

  final lowStep = (1.0 - lightness) / lowDivisor;
  final highStep = lightness / highDivisor;

  return {
    50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
    100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
    200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
    300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
    400: (hslColor.withLightness(lightness + lowStep)).toColor(),
    500: (hslColor.withLightness(lightness)).toColor(),
    600: (hslColor.withLightness(lightness - highStep)).toColor(),
    700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
    800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
    900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
  };
}

MaterialColor primarySwatch;
Color primaryColor;
Color backgroundColor = Colors.white10;
Color ratingColor /* = Color(0xFFF18A11) */;

//Searches
List<Food> searchedFoods = [];
List<Resturant> searchedResturants = [];
//KEYS
final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
//Style
TextStyle headStyle =
    TextStyle(color: Colors.white, fontSize: 38.0, fontWeight: FontWeight.bold);

TextStyle italicStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic);

TextStyle textStyle(
    Color color, double fontSize, FontWeight fontWeight, FontStyle fontStyle) {
  return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle);
}

checkGPS(context) {
  LocationProvider().check().then((check) {
    //print(check);
    if (!check) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text('Enable Gps'),
            content: Text(
              'Please turn device location on for better experience. We need your location information to serve you based on your location.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  });
}

dialog(context, String title, Widget content) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: Text(title),
        content: content,
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

//Widget
snackbar(text, BuildContext context, _scaffoldKey, {seconds = 5}) {
  final snack =
      SnackBar(content: Text(text), duration: Duration(seconds: seconds));
  //Scaffold.of(context).removeCurrentSnackBar();
  //Scaffold.of(context).showSnackBar(snack);
  _scaffoldKey.currentState.removeCurrentSnackBar();
  _scaffoldKey.currentState.showSnackBar(snack);
}

Future<bool> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  }
  return true;
}

Future<bool> checkNetwork(
  BuildContext context,
  _scaffoldKey,
) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    snackbar('Check Internet Connection', context, _scaffoldKey);
    print('no network');
    return false;
  }
  return true;
}

void checkGps({Function function}) {
  LocationProvider().check().then((value) {
    //if (value) {
    check = value;
    function();
    //print(check);
    // }
  });
}

Widget noGps(Function function) {
  return Container(
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.location_off,
            size: 80.0,
          ),
          RaisedButton(
            onPressed: () {
              function();
            },
            shape: StadiumBorder(),
            color: primaryColor,
            textColor: Colors.white,
            child: Text('Try Again'),
          )
        ],
      ),
    ),
  );
}

String formatNumber(numberToFormat) {
  return NumberFormat.compactCurrency(
    decimalDigits: 0,
    symbol:
        '', // if you want to add currency symbol then pass that in this else leave it empty.
  ).format(numberToFormat);
}
/* Future<RemoteConfig> setupRemoteConfig() async {
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  // Enable developer mode to relax fetch throttling
  remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
  remoteConfig.setDefaults(<String, dynamic>{
    'primary_color': 'ffff00',
    //'hello': 'default hello',
  });
  return remoteConfig;
} */
