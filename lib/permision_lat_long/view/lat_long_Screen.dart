// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../controller/lat_log_controller.dart';
//
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   HomeController homeController = Get.put(HomeController());
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(child: Scaffold(
//       appBar: AppBar(title: Text("Permission"),
//           centerTitle: true),
//       body: Center(
//         child: Column(
//           children: [
//             ElevatedButton(onPressed: () async {
//               var Status = await Permission.location.status;
//               if( Status.isDenied)
//               {
//                 Permission.location.request();
//                 Get.snackbar('Location', 'Scucess');
//               }
//
//             }, child: Text("Location"),),
//             SizedBox(height: 20,),
//             ElevatedButton(onPressed: () async {
//               Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//
//               homeController.lat.value = position.longitude;
//               homeController.log.value = position.latitude;
//             }, child: Text("track"),),
//             Obx(() =>  Text("Lat :${homeController.lat.value}",style: TextStyle(fontSize: 30),),),
//             Obx(() =>  Text("Log :${homeController.log.value}",style: TextStyle(fontSize: 30),),),
//             SizedBox(height: 350),
//             Align(
//               alignment: Alignment.bottomRight,
//               child: Padding(
//                 padding:  EdgeInsets.all(8.0),
//                 child: FloatingActionButton(onPressed: () {
//                   Get.toNamed('loc');
//                 },child: Icon(Icons.location_on),),
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../controller/lat_log_controller.dart';

class LocatorView extends StatefulWidget {
  const LocatorView({Key? key}) : super(key: key);

  @override
  State<LocatorView> createState() => _LocatorViewState();
}

class _LocatorViewState extends State<LocatorView> {
  LocatorController controller = Get.put(LocatorController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink.shade200,
          title: Text(
            "Locator",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 3,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () async {
                    var status = await Permission.storage.status;
                    if (status.isDenied) {
                      Permission.storage.request();
                    }
                  },
                  child: Text("permission", style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade200),
                ), SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    var status = await Permission.camera.status;
                    if (status.isDenied) {
                      Permission.camera.request();
                    }
                  },
                  child: Text("camera", style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade200),
                ), SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    openAppSettings();
                  },
                  child: Text("setting", style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade200),
                ), SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    var status = await Permission.location.status;
                    if (status.isDenied) {
                      Permission.location.request();
                    } else if (status.isGranted) {
                      Position position = await Geolocator.getCurrentPosition(
                          desiredAccuracy: LocationAccuracy.high);

                      controller.Lat.value = position.latitude;
                      controller.Lon.value = position.longitude;
                    }
                  },
                  child: Text(
                    "Get Lat & Lon",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade200),
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(() => SelectableText(
                      "Latitude :- ${controller.Lat.value}",
                      style: TextStyle(fontSize: 16),
                    )),
                SizedBox(
                  height: 10,
                ),
                Obx(() => SelectableText(
                      "Longitude :- ${controller.Lon.value}",
                      style: TextStyle(fontSize: 16),
                    )),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    List<Placemark> placemarks = await placemarkFromCoordinates(
                        controller.Lat.value, controller.Lon.value);
                    controller.locate.value = placemarks;
                  },
                  child: Text(
                    "Get Address",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade200),
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(
                  () => SelectableText(
                    controller.locate.isEmpty ? " " : "${controller.locate[0]}",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.pink.shade200,
            onPressed: () => Get.toNamed('map'),
            child: Icon(
              Icons.pin_drop,
              color: Colors.white,
            )),
      ),
    );
  }
}
