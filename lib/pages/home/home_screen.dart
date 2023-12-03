// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/global_controller.dart';
import '../../widgets/inputs/app_input.dart';
import 'home_drawer.dart';
import 'select_ride.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final ctrl = Get.put(GlobalController());
final globalCtrl = Get.put(GlobalController());

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? mapController;
  CameraPosition? initialPosition;
  LocationData? currentLocation;
  final userLocation = ctrl.userLocation.value;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void _getUserLocation() async {
    Location location = Location();
    LocationData locationData = await location.getLocation();
    setState(() {
      currentLocation = locationData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(         centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(40),
            )),
            title: Text(
              'Welcome Driver ${globalCtrl.user.value.firstName ?? ''}',
              style: const TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
          ),

          drawer: HomeDrawer(),
          // body:
          // Column(children: [
          //   LayoutBuilder(
          //       builder: (BuildContext context, BoxConstraints constraints) {
          //     return SizedBox(
          //       height: constraints.maxHeight / 2,
          //       child:
          //        GoogleMap(
          //         myLocationEnabled: true,
          //         myLocationButtonEnabled: true,
          //         mapType: MapType.normal,
          //         onMapCreated: (controller) {
          //           setState(() {
          //             mapController = controller;
          //           });
          //         },
          //         initialCameraPosition: _kGooglePlex,
          //         markers: <Marker>{},
          //       ),
          //     );
          //   }),
          //   DraggableScrollableSheet(
          //       initialChildSize: 0.5,
          //       minChildSize: 0.5,
          //       maxChildSize: 1,
          //       snapSizes: [0.5, 1],
          //       snap: true,
          //       builder: (BuildContext context, scrollSheetController) {
          //         return Container(
          //           color: Colors.white,
          //           padding: const EdgeInsets.all(10),
          //           child: ListView(controller: scrollSheetController, children: [
          //             const SizedBox(
          //               height: 15,
          //             ),
          //             const Center(
          //               child: Text(
          //                 'Taking a trip?',
          //                 style: TextStyle(
          //                   color: Colors.black,
          //                   fontSize: 24,
          //                   fontFamily: 'Inter',
          //                   fontWeight: FontWeight.w400,
          //                 ),
          //               ),
          //             ),
          //             GestureDetector(
          //               onTap: (){
          //                 Get.to(() => SelectRide());
          //               },
          //               child: AppInput(
          //                 enabled: false,
          //                 placeholder: 'Where are you going to ?',
          //                 prefixIcon: const Icon(Icons.search),

          //               ),
          //             ),
          //           ]),
          //         );
          //       }),
          // ]),
          bottomSheet: Container(
            height: 200,
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: ListView(children: [
              const SizedBox(
                height: 15,
              ),
              const Center(
                child: Text(
                  'Taking a trip?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const SelectRide());
                },
                child: const AppInput(
                  enabled: false,
                  placeholder: 'Where are you going to ?',
                  prefixIcon:  Icon(Icons.search),
                ),
              ),
            ]),
          ),
          body: Center(
            child: GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(userLocation.latitude, userLocation.longitude),
                zoom: 15.0,
              ),
              //markers: <Marker>{},
            ),
          ),
        ));
  }
}
