// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rockyconnectdriver/controllers/map_controller.dart';
import 'package:rockyconnectdriver/models/trip_response.dart';
import 'package:rockyconnectdriver/pages/trip/trip_card.dart';

import '../../theme/colors.dart';

class SelectDrip extends StatefulWidget {
  final Function(TripResponse)? onSelect;

  const SelectDrip({
    Key? key,
    this.onSelect,
  }) : super(key: key);

  @override
  State<SelectDrip> createState() => _SelectDripState();
}

class _SelectDripState extends State<SelectDrip> {
  final ctrl = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.PRIMARY_COLOR_LIGHT,
        appBar: AppBar(
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          )),
          title: const Text(
            'Based on selected location and date',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          backgroundColor: AppColors.PRIMARY_COLOR,
        ),
        body:  Obx(
                        () =>Padding(
          padding: const EdgeInsets.all(8.0),
          child: RefreshIndicator(
            onRefresh: () async {
              return ctrl.searchForDriver();
            },
            child: ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, i) {
                return TripCard(
                  item: ctrl.trip[i],
                  onSelect: widget.onSelect,
                );
              },
              itemCount: ctrl.trip.length,
            ),
          ),
        )));
  }
}
