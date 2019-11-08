import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hi_food/models/auth_provider.dart';
import 'package:hi_food/pages/auth.dart';
import 'package:hi_food/pages/user/home_page.dart';
import 'package:hi_food/values.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      Auth authservice = Provider.of<Auth>(context);

      FirebaseAuth.instance.onAuthStateChanged.listen((user) {});

      authservice.getUser().then((user) => user != null
          ? Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => Home()))
          : Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AuthPage())));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Stack(children: [
        Container(
          height: height,
          child: Opacity(
            opacity: 0.4,
            child: Hero(
              tag: 'splash',
              child: Image.asset(
                'assets/images/food.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        /* Align(
            alignment: Alignment.center,
            child: Container(
              height: height / 5,
              width: height / 5,
              child: Image.asset('assets/images/food.jpeg'),
            )) */
      ]),
    );
  }
}
/* class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Hero(
          tag: 'splash',
          child: Image.asset(
            'assets/images/food.jpeg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
 */
