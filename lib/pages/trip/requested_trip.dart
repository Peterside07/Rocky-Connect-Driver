// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rockyconnectdriver/widgets/loaders/app_loader.dart';

import '../../controllers/trip_controller.dart';
import '../../models/trip_response.dart';
import '../../theme/colors.dart';
import '../trip/trip_card.dart';
import '../../widgets/app_segment_item.dart';

class RequestTrip extends StatefulWidget {
  final Function(TripResponse)? onSelect;

  const RequestTrip({
    Key? key,
    this.onSelect,
  }) : super(key: key);

  @override
  State<RequestTrip> createState() => _RequestTripState();
}

class _RequestTripState extends State<RequestTrip> {
  final ctrl = Get.put(TripController());
  String segment = 'approved';

  void onValueChanged(val) {
    setState(() {
      segment = val as String;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR_LIGHT,
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => AppLoader(
            isLoading: ctrl.loading.value,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildSegmentedControl(),
                  buildTripList(segment),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40),
        ),
      ),
      title: const Text(
        'Trip',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: AppColors.PRIMARY_COLOR,
    );
  }

  CupertinoSlidingSegmentedControl buildSegmentedControl() {
    return CupertinoSlidingSegmentedControl(
      children: {
        'approved': AppSegmentItem(
          'Approved',
          value: 'approved',
          height: 50,
          textSize: 16,
          selectedValue: segment,
        ),
        'completed': AppSegmentItem(
          'Requested ',
          value: 'completed',
          height: 50,
          textSize: 16,
          selectedValue: segment,
        ),
        'requested': AppSegmentItem(
          'Unrequested',
          value: 'requested',
          height: 50,
          textSize: 16,
          selectedValue: segment,
        ),
      },
      onValueChanged: onValueChanged,
    );
  }

  Widget buildTripList(String segment) {
    if (segment == 'approved') {
      return buildTripListByType(ctrl.approvedTrip);
    } else if (segment == 'completed') {
      return buildTripListByType(ctrl.requestedTrip);
    } else if (segment == 'requested') {
      return buildTripListByType(ctrl.unrequestTrip);
    } else {
      return SizedBox.shrink();
    }
  }

  Widget buildTripListByType(List<TripResponse> trips) {
    return RefreshIndicator(
      onRefresh: () async {
        ctrl.fetchUnrequestedTrip();
        ctrl.fetchApprovedTrip();
        ctrl.fetchRequestedTrip();
        return ctrl.fetchCompletedTrip();
      },
      child: ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, i) {
          return TripCard(
            item: trips[i],
            onSelect: widget.onSelect,
          );
        },
        itemCount: trips.length,
      ),
    );
  }
}


class TextInfo extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  TextInfo({
    Key? key,
    required this.text,
    this.fontSize = 10,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize: fontSize,
        fontFamily: 'Poppins',
        fontWeight: fontWeight,
        height: 0,
      ),
    );
  }
}
