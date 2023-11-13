// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:intl/intl.dart';
import '../../controllers/map_controller.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/inputs/app_input.dart';

class MapScreen extends StatefulWidget {
  final DetailsResult? startPosition;
  final DetailsResult? endPosition;
  final String? startName;
  final String? endName;
  final double? distance;

  const MapScreen(
      {Key? key,
      this.startPosition,
      this.endPosition,
      this.startName,
      this.endName,
      this.distance})
      : super(key: key);
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final ctrl = Get.put(MapController());

  late CameraPosition _initialPosition;
  final Completer<GoogleMapController> controller = Completer();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  DateTime? selectedDate;
  TimeOfDay timeOfDay = TimeOfDay(hour: 8, minute: 30);

  int selectedCarId = 1;
  bool backButtonVisible = true;
  getStateFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        final Placemark firstPlacemark = placemarks[0];
        final String state =
            firstPlacemark.administrativeArea ?? 'State information not found';
        print(state);
        return state;
      } else {
        return 'No placemarks found';
      }
    } catch (e) {
      print('Error: $e');
      return 'Error occurred';
    }
  }

  String stateInfo = '';
  getSourceState() async {
    ctrl.startState.value =
        await getStateFromCoordinates(ctrl.startLat.value, ctrl.startLng.value);
    //  print(state);

    setState(() {
      stateInfo = ctrl.startState.value;
    });
  }

  getdistinationState() async {
    ctrl.endState.value =
        await getStateFromCoordinates(ctrl.endLat.value, ctrl.endLng.value);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialPosition = CameraPosition(
      target: LatLng(widget.startPosition!.geometry!.location!.lat!,
          widget.startPosition!.geometry!.location!.lng!),
      zoom: 14.4746,
    );
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.black,
        points: polylineCoordinates,
        width: 1);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyDc6zzajds1F8pd2OsWtNwMDjtlKvBQMB8',
        PointLatLng(widget.startPosition!.geometry!.location!.lat!,
            widget.startPosition!.geometry!.location!.lng!),
        PointLatLng(widget.endPosition!.geometry!.location!.lat!,
            widget.endPosition!.geometry!.location!.lng!),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> _markers = {
      Marker(
          markerId: MarkerId('start'),
          position: LatLng(widget.startPosition!.geometry!.location!.lat!,
              widget.startPosition!.geometry!.location!.lng!)),
      Marker(
          markerId: MarkerId('end'),
          position: LatLng(widget.endPosition!.geometry!.location!.lat!,
              widget.endPosition!.geometry!.location!.lng!))
    };

    void _showDatePicker() {
      showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2050));
    }

    double calculateDistance(
      double lat1,
      double lon1,
      double lat2,
      double lon2,
    ) {
      const double earthRadius = 6371.0;

      double radiansLat1 = lat1 * (pi / 180);
      double radiansLon1 = lon1 * (pi / 180);
      double radiansLat2 = lat2 * (pi / 180);
      double radiansLon2 = lon2 * (pi / 180);

      double dLat = radiansLat2 - radiansLat1;
      double dLon = radiansLon2 - radiansLon1;

      double a = sin(dLat / 2) * sin(dLat / 2) +
          cos(radiansLat1) * cos(radiansLat2) * sin(dLon / 2) * sin(dLon / 2);
      double c = 2 * atan2(sqrt(a), sqrt(1 - a));

      double distance = earthRadius * c;

      return distance;
    }

// Calculate the distance
    double distance = calculateDistance(
      widget.startPosition!.geometry!.location!.lat!,
      widget.startPosition!.geometry!.location!.lng!,
      widget.endPosition!.geometry!.location!.lat!,
      widget.endPosition!.geometry!.location!.lng!,
    );

    ctrl.startLat.value = widget.startPosition?.geometry?.location?.lat ?? 0.0;
    ctrl.startLng.value = widget.startPosition?.geometry?.location?.lng ?? 0.0;
    ctrl.endLat.value = widget.endPosition?.geometry?.location?.lat ?? 0.0;
    ctrl.endLng.value = widget.endPosition?.geometry?.location?.lng ?? 0.0;
    ctrl.startName.value = widget.startName ?? '';
    ctrl.endName.value = widget.endName ?? '';
    ctrl.distance.value = widget.distance!;
    ctrl.distance.value = distance;

    return Scaffold(
      body: Stack(children: [
        LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            height: constraints.maxHeight / 2,
            child: GoogleMap(
              myLocationEnabled: true,
              // liteModeEnabled: false,
              mapType: MapType.normal,
              zoomControlsEnabled: true,
              polylines: Set<Polyline>.of(polylines.values),
              initialCameraPosition: _initialPosition,
              markers: Set.from(_markers),
              onMapCreated: (GoogleMapController controller) {
                Future.delayed(Duration(milliseconds: 2000), () {
                  controller.animateCamera(CameraUpdate.newLatLngBounds(
                      MapUtils.boundsFromLatLngList(
                          _markers.map((loc) => loc.position).toList()),
                      1));
                  _getPolyline();
                });
              },
            ),
          );
        }),
        DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.5,
            maxChildSize: 1,
            snapSizes: [0.5, 1],
            snap: true,
            builder: (BuildContext context, scrollSheetController) {
              return Container(
                  color: Color(0xFFD9D9D9),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    physics: ClampingScrollPhysics(),
                    controller: scrollSheetController,
                    children: [
                      Container(
                        height: 96,
                        decoration: ShapeDecoration(
                          color: Color(0xFF663399),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.startName ?? '',
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Color(0xFFE4CAFF),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Icon(Icons.forward, color: Colors.white),
                                  Text(
                                    widget.endName ?? '',
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Color(0xFFE4CAFF),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${distance.toStringAsFixed(2)} miles',
                              style: TextStyle(
                                color: Color(0xFFE4CAFF),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0, right: 30),
                          child: GestureDetector(
                            onTap: () async {
                              final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2050),
                              );

                              if (selectedDate != null) {
                                setState(() {
                                  this.selectedDate = selectedDate;
                                  ctrl.dateControllerCtx.text = selectedDate
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0];
                                });
                              }
                              getSourceState();
                              getdistinationState();
                            },
                            child: AppInput(
                              color: Colors.white,
                              enabled: false,
                              controller: ctrl.dateControllerCtx,
                              placeholder: 'Date of Travel',
                              prefixIcon: Icon(Icons.calendar_month),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0, right: 30),
                          child: GestureDetector(
                            onTap: () async {
                              final selectedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());

                              if (selectedTime != null) {
                                setState(() {
                                  timeOfDay = selectedTime;
                                  ctrl.timeControllerCtx.text =
                                      selectedTime.format(context);
                                });
                              }
                            },
                            child: AppInput(
                              color: Colors.white,
                              enabled: false,
                              controller: ctrl.timeControllerCtx,
                              placeholder: 'Pick time',
                              prefixIcon: Icon(Icons.calendar_month),
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            PrimaryButton(
                              isLoading: ctrl.loading.value,
                              width: 154,
                              height: 38,
                              label: 'Search',
                              onPressed: () {
                                DateTime selectedDateTime = DateTime(
                                  selectedDate!.year,
                                  selectedDate!.month,
                                  selectedDate!.day,
                                  timeOfDay.hour,
                                  timeOfDay.minute,
                                  51,
                                  892,
                                );

                                String formattedDateTime =
                                    DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ')
                                        .format(selectedDateTime);

                                // Set the formattedDateTime in the MapController
                                ctrl.formattedDateTime.value =
                                    formattedDateTime;

                                ctrl.searchForDriver();
                              },
                            ),
                            PrimaryButton(
                              isLoading: ctrl.isLoading.value,
                              width: 154,
                              height: 38,
                              label: 'Create',
                              onPressed: () {
                                DateTime selectedDateTime = DateTime(
                                  selectedDate!.year,
                                  selectedDate!.month,
                                  selectedDate!.day,
                                  timeOfDay.hour,
                                  timeOfDay.minute,
                                  51,
                                  892,
                                );

                                String formattedDateTime =
                                    DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ')
                                        .format(selectedDateTime);

                                // Set the formattedDateTime in the MapController
                                ctrl.formattedDateTime.value =
                                    formattedDateTime;
                                // getSourceState();
                                // getdistinationState();
                                getSourceState();
                                getdistinationState();
                                ctrl.scheduleTrip();
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ));
            }),
      ]),
    );
  }
}

class MapUtils {
  static LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
        northeast: LatLng(x1! + 1, y1! + 1),
        southwest: LatLng(x0! - 1, y0! - 1));
  }
}
