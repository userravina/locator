import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location_controller extends GetxController {
  RxDouble lat = 21.1702.obs;
  RxDouble lon = 72.8311.obs;
  Rx<Position> position = Position(
          accuracy: 0,
          altitude: 0,
          heading: 0,
          latitude: 0,
          longitude: 0,
          speed: 0,
          speedAccuracy: 0,
          timestamp: DateTime.now(),
          floor: 0)
      .obs;
  Rx<LatLng> latlong = LatLng(21.1702, 72.8311).obs;
  Rx<Completer<GoogleMapController>> completer =
      Completer<GoogleMapController>().obs;

  RxSet<Marker> Markers() {
    return {
      Marker(
          markerId: MarkerId("current position"),
          position: LatLng(position.value.latitude, position.value.longitude),
          infoWindow: InfoWindow(title: "Current position"))
    }.obs;
  }

  void getCurrentLocation()
  async {
    position.value = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    latlong.value = LatLng(position.value.latitude, position.value.longitude);
    update();
  }

}
