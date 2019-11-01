import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:hi_food/models/auth_provider.dart';
import 'package:hi_food/pages/auth.dart';
import 'package:hi_food/pages/foods.dart';
import 'package:hi_food/pages/resturants.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Auth authservice = Provider.of<Auth>(context);
    GlobalKey _bottomNavigationKey = GlobalKey();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Hi-Food'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.fastfood)),
              Tab(icon: Icon(Icons.restaurant_menu))
            ],
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          buttonBackgroundColor: Colors.pink,
          color: Colors.pink,
          height: 50.0,
          key: _bottomNavigationKey,
          items: <Widget>[
            Icon(Icons.home, size: 30, color: Colors.white, ),
            Icon(Icons.shopping_cart, size: 30, color: Colors.white, ),
            Icon(Icons.account_circle, size: 30, color: Colors.white, ),
            Icon(Icons.menu, size: 30, color: Colors.white, ),
          ],
          onTap: (index) {
          },
        ),
        body: TabBarView(
          children: [
            Foods(),
            Resturants(),
          ],
        ),
      )
    );
  }
}