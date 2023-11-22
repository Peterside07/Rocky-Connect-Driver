// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';

import '../../theme/colors.dart';
import '../../widgets/buttons/primary_button.dart';
import '../ride/map_screen.dart';

class SelectRide extends StatefulWidget {
  const SelectRide({super.key});

  @override
  _SelectRideState createState() => _SelectRideState();
}

class _SelectRideState extends State<SelectRide> {
  final _startSearchFieldController = TextEditingController();
  final _endSearchFieldController = TextEditingController();

  DetailsResult? startPosition;
  DetailsResult? endPosition;

  late FocusNode startFocusNode;
  late FocusNode endFocusNode;

  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? _debounce;

  String startLocationName = '';
  String endLocationName = '';

  @override
  void initState() {
    super.initState();
    String apiKey = 'AIzaSyDc6zzajds1F8pd2OsWtNwMDjtlKvBQMB8';
    googlePlace = GooglePlace(apiKey);

    startFocusNode = FocusNode();
    endFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    startFocusNode.dispose();
    endFocusNode.dispose();
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      debugPrint(result.predictions!.first.description);
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  // Function to calculate the distance between two LatLng positions
  double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double earthRadius = 6371.0; // Earth's radius in kilometers

    // Convert latitude and longitude from degrees to radians
    double radiansLat1 = lat1 * (pi / 180);
    double radiansLon1 = lon1 * (pi / 180);
    double radiansLat2 = lat2 * (pi / 180);
    double radiansLon2 = lon2 * (pi / 180);

    // Haversine formula
    double dLat = radiansLat2 - radiansLat1;
    double dLon = radiansLon2 - radiansLon1;

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(radiansLat1) * cos(radiansLat2) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Calculate the distance in kilometers
    double distance = earthRadius * c;

    return distance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40),
        )),
        title: const Text(
          'Trip',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.PRIMARY_COLOR,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Set your pick up and drop off location.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _startSearchFieldController,
                autofocus: false,
                focusNode: startFocusNode,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                    hintText: 'Pick Up',
                    hintStyle: const TextStyle(
                      color: AppColors.PLACEHOLDER_COLOR,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.location_on,
                        color: AppColors.PRIMARY_COLOR_LIGHT),
                    suffixIcon: _startSearchFieldController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                predictions = [];
                                _startSearchFieldController.clear();
                              });
                            },
                            icon: const Icon(Icons.clear_outlined),
                          )
                        : null),
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                  _debounce = Timer(const Duration(milliseconds: 10), () {
                    if (value.isNotEmpty) {
                      autoCompleteSearch(value);
                    } else {
                      setState(() {
                        predictions = [];
                        startPosition = null;
                      });
                    }
                  });
                },
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _endSearchFieldController,
                autofocus: false,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                    hintText: 'Drop Off',
                    hintStyle: const TextStyle(
                      color: AppColors.PLACEHOLDER_COLOR,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    filled: true,
                    enabled: _startSearchFieldController.text.isNotEmpty &&
                        startPosition != null,
                    fillColor: Colors.grey[200],
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.location_on,
                        color: AppColors.PRIMARY_COLOR_LIGHT),
                    suffixIcon: _endSearchFieldController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                predictions = [];
                                _endSearchFieldController.clear();
                              });
                            },
                            icon: const Icon(Icons.clear_outlined),
                          )
                        : null),
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                  _debounce = Timer(const Duration(milliseconds: 10), () {
                    if (value.isNotEmpty) {
                      //places api
                      autoCompleteSearch(value);
                    } else {
                      //clear out the results
                      setState(() {
                        predictions = [];
                        endPosition = null;
                      });
                    }
                  });
                },
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: predictions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: AppColors.PLACEHOLDER_COLOR,
                        child: Icon(Icons.location_on,
                            color: AppColors.PRIMARY_COLOR_LIGHT),
                      ),
                      title: Text(
                        predictions[index].description.toString(),
                      ),
                      onTap: () async {
                        final placeId = predictions[index].placeId!;
                        final details = await googlePlace.details.get(placeId);
                        if (details != null &&
                            details.result != null &&
                            mounted) {
                          if (startFocusNode.hasFocus) {
                            setState(() {
                              startPosition = details.result;
                              _startSearchFieldController.text =
                                  details.result!.name!;
                              predictions = [];
                              startLocationName = details.result!.name!;
                            });
                          } else {
                            setState(() {
                              endPosition = details.result;
                              _endSearchFieldController.text =
                                  details.result!.name!;
                              predictions = [];
                              endLocationName = details.result!.name!;
                            });
                          }
                        }
                      },
                    );
                  }),
              const SizedBox(
                height: 30,
              ),
              PrimaryButton(
                label: 'Set',
                onPressed: () {
                  if (startPosition != null && endPosition != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapScreen(
                          startPosition: startPosition,
                          endPosition: endPosition,
                          startName: startLocationName,
                          endName: endLocationName,
                          distance: 5,
                        ),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
