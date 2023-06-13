// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location_getx/Google_location/controller/location-controller.dart';
//
// class Location_Screen extends StatefulWidget {
//   const Location_Screen({Key? key}) : super(key: key);
//
//   @override
//   State<Location_Screen> createState() => _Location_ScreenState();
// }
//
// Location_controller Controller = Get.put(Location_controller());
//
// class _Location_ScreenState extends State<Location_Screen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     Controller.getCurrentLocation();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Google map"),
//         ),
//         body: Obx(() =>  GoogleMap(
//           onMapCreated: (controller) {
//             Controller.completer.value.complete(controller);
//           },
//             initialCameraPosition:
//                 CameraPosition(target: Controller.latlong.value, zoom: 12),
//             markers: Controller.Markers(),
//             myLocationEnabled: true,
//             myLocationButtonEnabled: true,
//             mapType: Controller.m.value,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../permision_lat_long/controller/lat_log_controller.dart';

class Mapscreen extends StatefulWidget {
  const Mapscreen({Key? key}) : super(key: key);

  @override
  State<Mapscreen> createState() => _MapscreenState();
}

class _MapscreenState extends State<Mapscreen> {
  LocatorController locatorController = Get.put(LocatorController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          rotateGesturesEnabled: true,
          myLocationEnabled: true,
          mapToolbarEnabled: true,
          markers: {
            Marker(
              markerId: MarkerId("Me"),
              position: LatLng(
                  locatorController.Lat.value, locatorController.Lon.value),
            ),
          },
          compassEnabled: true,
          buildingsEnabled: true,
          onCameraMove: (position) =>
              LatLng(locatorController.Lat.value, locatorController.Lon.value),
          initialCameraPosition: CameraPosition(
            target: LatLng(
                locatorController.Lat.value, locatorController.Lon.value),
          ),
        ),
      ),
    );
  }
}