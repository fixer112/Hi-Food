import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hi_food/pages/auth.dart';

class Auth with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final facebookLogin = FacebookLogin();

  Future<FirebaseUser> getUser() async {
    FirebaseUser user = await _auth.currentUser();
    notifyListeners();
    return user != null ? user : null;
  }

  Future logout(context) async {
    var result = FirebaseAuth.instance.signOut();

    notifyListeners();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => AuthPage()));
    getUser().then((user) => print(user));
    return result;
  }

  Future<FirebaseUser> facebookAuth() async {
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
        return user;
        //print(user);
        //return user;
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Facebook Cancelled');
        break;
      case FacebookLoginStatus.error:
        print('Facebook Error ' + result.errorMessage);
        // _changeBlackVisible();
        break;
    }
    /* } catch (e) {
      print("Error ${e.code} ${e.message}");
      throw new AuthException(e.code, e.message);
    } */
  }

  Future<FirebaseUser> googleAuth() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    //try {
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
    print(user);
    return user;
    /* } catch (e) {
      print("Error ${e.code} ${e.message}");
      throw new AuthException(e.code, e.message);
    } */
  }
}
