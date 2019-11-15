import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:hi_food/values.dart';

class Rconfig {
  Future<RemoteConfig> getRemoteConfig() async {
    var remoteConfig = await RemoteConfig.instance;
    final defaults = <String, dynamic>{
      'primary_color': '4caf50',
      'rating_color': 'f18A11',
      'default_location_range': 5.0,
      'min_location_range': 1.0,
      'max_location_range': 100.0,
    };
    remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
    await remoteConfig.setDefaults(defaults);
    /* if (await checkInternet()) {
      await remoteConfig.fetch(expiration: Duration(seconds: 0));
      await remoteConfig.activateFetched();
    } */
    //print(remoteConfig.getString('primary_color'));
    String primary = remoteConfig.getString('primary_color');
    primaryColor = Color(int.parse('0xFF' + primary));
    primarySwatch =
        MaterialColor(int.parse('0xFF' + primary), getSwatch(primary));
    ratingColor =
        Color(int.parse('0xFF' + remoteConfig.getString('rating_color')));
    defaultLocationRange = remoteConfig.getDouble('default_location_range');
    minLocationRange = remoteConfig.getDouble('min_location_range');
    maxLocationRange = remoteConfig.getDouble('max_location_range');
    return remoteConfig;
    //Colors.green
  }
}
