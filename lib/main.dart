import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:location_getx/Google_location/view/location_Screen.dart';
import 'package:location_getx/permision_lat_long/view/lat_long_Screen.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (p0) => LocatorView(),
      'map':(context) => Mapscreen(),
    },
  ));
}