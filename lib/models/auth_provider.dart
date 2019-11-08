import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hi_food/pages/auth.dart';
import 'package:hi_food/pages/user/home_page.dart';
import 'package:hi_food/values.dart';

class Auth with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final facebookLogin = FacebookLogin();

  Future<FirebaseUser> getUser() async {
    FirebaseUser user = await _auth.currentUser();
    notifyListeners();
    return user != null ? user : null;
  }

  addUser(FirebaseUser user) async {
    if (user != null) {
      var doc =
          await Firestore.instance.collection('users').document(user.uid).get();
      if (!doc.exists) {
        Firestore.instance.collection('users').document(user.uid).setData({
          'id': user.uid,
          'name': user.displayName,
          'email': user.email,
          'photo': user.photoUrl,
          'number': user.phoneNumber,
          'role': ['user'],
          //'logged': true
          //'te'
        });
      }
    }
  }

  Future logout(context) async {
    getUser().then((user) {
      if (user != null) {
        Firestore.instance.collection('users').document(user.uid).updateData({
          'logged': false,
        });
      }
    });
    var result = FirebaseAuth.instance.signOut();

    notifyListeners();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => AuthPage()));
    getUser().then((user) => print(user));
    return result;
  }

  Future<FirebaseUser> facebookAuth(
    BuildContext context,
    _scaffoldKey,
  ) async {
    checkNetwork(context, _scaffoldKey);

    //print('test');
    final result = await facebookLogin.logIn(['email']);

    //try {
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token);

        final FirebaseUser user =
            (await _auth.signInWithCredential(credential)).user;
        //print("signed in " + user.displayName);
        print('Facebook Successful');
        addUser(user);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => Home()));
        return user;
        //print(user);
        //return user;
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Facebook Cancelled');
        break;
      case FacebookLoginStatus.error:
        print('Facebook Error ' + result.errorMessage);
        snackbar('An Error Occured', context, _scaffoldKey);
        // _changeBlackVisible();
        break;
    }
    /* } catch (e) {
      print("Error ${e.code} ${e.message}");
      throw new AuthException(e.code, e.message);
    } */
  }

  Future<FirebaseUser> googleAuth(
    BuildContext context,
    _scaffoldKey,
  ) async {
    checkNetwork(context, _scaffoldKey);
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      //print(googleUser);
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      addUser(user);
      print(user);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => Home()));
      return user;
    } catch (e) {
      print("Error ${e.code} ${e.message}");
      snackbar('An Error Occured', context, _scaffoldKey);
      //throw new AuthException(e.code, e.message);
    }
  }
}
