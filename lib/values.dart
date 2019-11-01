import 'package:flutter/material.dart';

//Strings
String appName = 'Hi-Food';

//Colors
Color primaryColor = Colors.pink;
Color backgroundColor = Colors.white10;
Color ratingColor = Color(0xFFF18A11);

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
  _scaffoldKey.currentState.removeCurrentSnackBar();
  _scaffoldKey.currentState.showSnackBar(snack);
}

// Find the Scaffold in the widget tree and use it to show a SnackBar.
