import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hi_food/models/auth_provider.dart';
import 'package:hi_food/pages/home_page.dart';
import 'package:hi_food/values.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key key}) : super(key: key);

  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              headInfo(context),
              authMethods(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget authMethods(context) {
    Auth authservice = Provider.of<Auth>(context);
    String comingSoon = 'auth is coming soon';
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            Text(
              'SIGN IN TO CONTINUE',
              style: textStyle(
                  Colors.black, 20, FontWeight.bold, FontStyle.normal),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  authIcon(
                      FontAwesomeIcons.phoneSquareAlt,
                      () =>
                          snackbar('Phone $comingSoon', context, _scaffoldKey)),
                  authIcon(
                      FontAwesomeIcons.facebook,
                      () => authservice
                          .facebookAuth()
                          .then((user) => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Home())))
                          .catchError((e) => snackbar(
                              e.message, context, _scaffoldKey,
                              seconds: 10))),
                  authIcon(
                      FontAwesomeIcons.twitter,
                      () => snackbar(
                          'Twitter $comingSoon', context, _scaffoldKey)),
                  authIcon(
                      FontAwesomeIcons.google,
                      () => authservice
                          .googleAuth()
                          .then((user) => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Home())))
                          .catchError((e) => snackbar(
                              e.message, context, _scaffoldKey,
                              seconds: 10))),
                  authIcon(
                      FontAwesomeIcons.envelope,
                      () =>
                          snackbar('Email $comingSoon', context, _scaffoldKey)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget authIcon(IconData icon, Function function) {
    return /* IconButton(
      icon: Icon(icon),
      onPressed: () {},
    ); */
        InkWell(
      onTap: () => function(),
      splashColor: Colors.white,
      child: Container(
        width: 50.0,
        height: 50.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          //color: primaryColor,
        ),
        child: Icon(
          icon,
          size: 25.0,
        ),
      ),
    );
  }

  Widget headInfo(context) {
    double height = MediaQuery.of(context).size.height * 0.7;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Container(
                height: height,
                child: Hero(
                  tag: 'splash',
                  child: Image.asset(
                    'assets/images/food.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: height * 0.15),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        appName,
                        style: headStyle,
                      ))),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.1, horizontal: height * 0.01),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "You can't record an album called 'Meat is Murder and slip out for a burger.",
                        style: italicStyle,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      Text('~ Hugh L', style: italicStyle),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
