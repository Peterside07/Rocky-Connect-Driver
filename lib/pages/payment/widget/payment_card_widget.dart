import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/global_controller.dart';
import '../../../models/trip_response.dart';
import '../../../theme/colors.dart';

class PaymentTripCard extends StatelessWidget {
  final TripResponse item;
  final Function(TripResponse)? onSelect;
  PaymentTripCard({
    Key? key,
    required this.item,
    this.onSelect,
  }) : super(key: key);

  final ctrl = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Payment Status',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            item.paymentId != null ? 'Paid' : 'Not paid',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          if (item.paymentId == null)
                            IconButton(
                              onPressed: () {
                                ctrl.paymentReminder(item.id.toString(),
                                    item.customerEmail.toString());
                              },
                              icon: const Icon(Icons.notifications),
                              color: AppColors.PRIMARY_COLOR,
                            )
                        ],
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
