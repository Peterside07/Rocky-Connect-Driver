// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rockyconnectdriver/controllers/notification_controller.dart';


import '../../models/notification_model.dart';
import '../../theme/colors.dart';
import '../../widgets/loaders/app_loader.dart';

class NoticationPage extends StatelessWidget {
  NoticationPage({super.key});
  final ctrl = Get.put(NotificationController());

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
          'Notification',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.PRIMARY_COLOR,
      ),
      body: Obx(() => AppLoader(
        isLoading: ctrl.loading.value,
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: ctrl.notificationList.length,
            itemBuilder: (context, i) {
              return NotificationItem(
                item: ctrl.notificationList[i],
              );
            },
          )),
    )));
  }
}

class NotificationItem extends StatelessWidget {
  final NotificationModel item;

  const NotificationItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 406,
      //  height: 103,
      margin: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title ?? '',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              item.body ?? '',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              DateFormat('dd MMMM yyyy HH:mm').format(item.dateSent!),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
