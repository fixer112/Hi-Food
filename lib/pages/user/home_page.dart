import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:hi_food/models/auth_provider.dart';
import 'package:hi_food/pages/auth.dart';
import 'package:hi_food/pages/user/foods.dart';
import 'package:hi_food/pages/user/resturants.dart';
import 'package:hi_food/values.dart';
import 'package:hi_food/widgets/cart.dart';
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
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Cart(20),
              ),
            ],
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.fastfood)),
                Tab(icon: Icon(Icons.restaurant_menu))
              ],
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.white,
            buttonBackgroundColor: primaryColor,
            color: primaryColor,
            height: 50.0,
            index: 1,
            key: _bottomNavigationKey,
            items: <Widget>[
              Cart(30),
              Icon(
                Icons.home,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.account_circle,
                size: 30,
                color: Colors.white,
              ),
              InkWell(
                onTap: () => authservice.logout(context),
                child: Icon(
                  Icons.power_settings_new,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ],
            onTap: (index) {
              print(index);
            },
          ),
          body: TabBarView(
            children: [
              Foods(),
              Resturants(),
            ],
          ),
        ));
  }
}
