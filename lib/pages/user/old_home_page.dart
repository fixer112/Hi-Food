import 'package:flutter/material.dart';
import 'package:hi_food/models/auth_provider.dart';
import 'package:hi_food/pages/auth.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Auth authservice = Provider.of<Auth>(context);
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.power_settings_new),
              onPressed: () => authservice.logout(context),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
              //child: child,
              ),
        ));
  }
}
