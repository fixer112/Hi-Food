import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:hi_food/models/location.dart';

//Strings
String appName = 'Hi-Food';
String cat = 'all';

//Bools
bool check = false;
//Colors
Color primaryColor = Colors.green;
Color backgroundColor = Colors.white10;
Color ratingColor = Color(0xFFF18A11);

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
    print(check);
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
    if (value) {
      check = value;
      function();
    }
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
            size: 100.0,
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
