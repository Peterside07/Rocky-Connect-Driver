// ignore_for_file: public_member_api_docs, sort_constructors_first, use_full_hex_values_for_flutter_colors
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/trip_controller.dart';
import '../../models/trip_response.dart';
import '../../theme/colors.dart';
import '../../widgets/loaders/app_loader.dart';
import '../trip/trip_card.dart';

class TripHistory extends StatefulWidget {
  final Function(TripResponse)? onSelect;

  const TripHistory({
    Key? key,
    this.onSelect,
  }) : super(key: key);

  @override
  State<TripHistory> createState() => _TripHistoryState();
}

class _TripHistoryState extends State<TripHistory> {
  final ctrl = Get.put(TripController());

  String segment = 'upcoming';

  void onValueChanged(val) {
    setState(() {
      segment = val as String;
    });
  }

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
            'Trip History',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.PRIMARY_COLOR,
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => AppLoader(
                isLoading: ctrl.loading.value,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, i) {
                          return TripCard(
                            item: ctrl.completedTrip[i],
                            onSelect: widget.onSelect,
                          );
                        },
                        itemCount: ctrl.completedTrip.length,
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}

class CustomInfoCard extends StatelessWidget {
  const CustomInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 406,
      height: 103,
      margin: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Row(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColors.PRIMARY_COLOR,
                ),
                Icon(
                  Icons.location_on,
                  color: AppColors.PRIMARY_COLOR,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nov 5, 5:00 AM',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '1543 West Jackson St',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nov 5, 9:00 AM',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Chicago union station',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          VerticalDivider(
            color: Color(0xff03f000000),
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total time',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '4hrs',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Cost',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    Text(
                      '\$120',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextInfo extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const TextInfo({
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
