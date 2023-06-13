import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocatorController extends GetxController{
  RxDouble Lat = 0.0.obs;
  RxDouble Lon = 0.0.obs;

  RxList<Placemark> locate = <Placemark>[].obs;


  Rx<MapType> m = MapType.normal.obs;

  List<MapType> l1 = <MapType>[
    MapType.normal,
    MapType.hybrid,
    MapType.satellite,
    MapType.none,
    MapType.terrain,
  ].obs;
}