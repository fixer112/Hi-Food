import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'dart:async';

//Strings
String appName = 'Hi-Food';

//Colors
Color primaryColor = Colors.pink;
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
