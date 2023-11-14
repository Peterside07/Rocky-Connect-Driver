import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rockyconnectdriver/models/trip_response.dart';
import 'package:rockyconnectdriver/pages/trip/trip_details.dart';

import '../../theme/colors.dart';

class TripCard extends StatelessWidget {
  final TripResponse item;
  final Function(TripResponse)? onSelect;
  const TripCard({
    Key? key,
    required this.item,
    this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect != null
          ? () {
              onSelect!(item);
            }
          : () {
              Get.to(() => TripDetails(
                    tripResponse: item,
                  ));
            },
      child: Container(
        width: 406,
        height: 103,
        margin: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        // ignore: prefer_const_constructors
        child: Row(
          children: [
            const Padding(
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
                        DateFormat('MMM d, hh:mm a')
                            .format(item.tripDate!.toLocal()),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        //   '1543 West Jackson St',
                        item.sourceLocation ?? '',
                        style: const TextStyle(
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
                        DateFormat('MMM d, hh:mm a').format(
                          item.tripDate!
                              .toLocal()
                              .add(Duration(hours: item.totalTime ?? 0)),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        //   'Chicago union station',
                        item.destination ?? '',
                        style: const TextStyle(
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
            const VerticalDivider(
              color: AppColors.PRIMARY_COLOR,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total time',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                       // item.totalTime! > 0
                         //   ?
                             '${item.totalTime} mins',
                        //    : '30 mins',
                        style: const TextStyle(
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
                      const Text(
                        'Total Cost',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '\$${item.tripCost}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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
