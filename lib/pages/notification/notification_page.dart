import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class NoticationPage extends StatelessWidget {
  const NoticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(         centerTitle: true,
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
  
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:ListView.builder(
  itemCount: 7, // Number of items
  itemBuilder: (context, index) {
    return NotificationItem(
      title: 'Ride Scheduled',
      content: 'Peter resul accepted ride request',
    );
  },
)
      ),
    );
  }
}


class NotificationItem extends StatelessWidget {
  final String title;
  final String content;

  NotificationItem({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 406,
      height: 103,
      margin: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: const Color(0xFFE5CBFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0, top: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              content,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
                height: 0,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'just now...',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
