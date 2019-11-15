import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  //double range = 5;
  @override
  void initState() {
    super.initState();
  }

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
                child: Cart(25),
              ),
            ],
            bottom: TabBar(
              onTap: (int) {},
              tabs: [
                Tab(icon: Icon(FontAwesomeIcons.utensils)),
                Tab(icon: Icon(FontAwesomeIcons.building))
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
              Icon(
                FontAwesomeIcons.solidHeart,
                size: 20,
                color: Colors.white,
              ),
              Icon(
                FontAwesomeIcons.hamburger,
                size: 20,
                color: Colors.white,
              ),
              Icon(
                FontAwesomeIcons.solidUserCircle,
                size: 20,
                color: Colors.white,
              ),
              InkWell(
                onTap: () => authservice.logout(context),
                child: Icon(
                  FontAwesomeIcons.powerOff,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ],
            onTap: (index) {
              print(index);
            },
          ),
          body: Stack(
            children: [
              TabBarView(
                physics: BouncingScrollPhysics(),
                children: [
                  Foods(),
                  Resturants(),
                ],
              ),
              Positioned(
                bottom: 0.0,
                //left: 20.0,
                child: Container(
                  child: Container(
                    //height: 5.0,
                    child: Slider(
                      onChanged: (value) {
                        //print(value);
                        setState(() {
                          defaultLocationRange = value;
                        });
                      },
                      value: defaultLocationRange,
                      min: minLocationRange,
                      max: maxLocationRange,
                      label: 'Range ${defaultLocationRange.floorToDouble()}km',
                      divisions: maxLocationRange.round() -
                          //minLocationRange.floor() -
                          1,
                      activeColor: primaryColor,
                      inactiveColor: primaryColor.withOpacity(0.2),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
