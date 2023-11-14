// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:rockyconnectdriver/controllers/map_controller.dart';
import 'package:rockyconnectdriver/models/trip_response.dart';
import 'package:rockyconnectdriver/widgets/buttons/primary_button.dart';

import '../../theme/colors.dart';
import '../../widgets/loaders/app_loader.dart';

class TripDetails extends StatefulWidget {
  final TripResponse tripResponse;

  const TripDetails({
    Key? key,
    required this.tripResponse,
  }) : super(key: key);

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
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
            'Trip Details',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          backgroundColor: AppColors.PRIMARY_COLOR,
        ),
        body: Obx(() => AppLoader(
            isLoading: ctrl.loading.value,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const SizedBox(height: 20),
                  Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text("Trip ID:"),
                                  Text(widget.tripResponse.id ?? ''),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              //  width: 406,
                              //  height: 103,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: AppColors.PRIMARY_COLOR,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Icon(
                                          Icons.location_on,
                                          color: AppColors.PRIMARY_COLOR,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Pick up location',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              widget.tripResponse
                                                      .sourceLocation ??
                                                  '',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Drop off location',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              //   'Chicago union station',
                                              widget.tripResponse.destination ??
                                                  '',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Trip Date',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0,
                                                  ),
                                                ),
                                                Text(
                                                  DateFormat('MM/dd/yyyy')
                                                      .format(widget
                                                          .tripResponse
                                                          .tripDate!
                                                          .toLocal()),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Trip Time',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0,
                                                  ),
                                                ),
                                                Text(
                                                  DateFormat('hh:mm a').format(
                                                    widget
                                                        .tripResponse.tripDate!
                                                        .toLocal()
                                                        .add(Duration(
                                                            hours: widget
                                                                    .tripResponse
                                                                    .totalTime ??
                                                                0)),
                                                  ),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              widget.tripResponse.totalTime! > 0
                                                  ? '${widget.tripResponse.totalTime} hrs'
                                                  : '30 mins',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                            Row(
                                              children: [
                                                Text(
                                                  '\$${widget.tripResponse.tripCost}',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                if (widget.tripResponse
                                                        .paymentId !=
                                                    null)
                                                  const Icon(
                                                    Icons.check,
                                                    color: Colors.green,
                                                  )
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Trip Status',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              widget.tripResponse.tripStatus ??
                                                  '',
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
                            const SizedBox(
                              height: 40,
                            ),
                            if (widget.tripResponse.tripStatus == 'Approved' ||
                                widget.tripResponse.tripStatus == 'Completed')
                              const Text(
                                'User Details',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),

                            if (widget.tripResponse.tripStatus == 'Approved' &&
                                    widget.tripResponse.customerEmail != '' ||
                                widget.tripResponse.tripStatus == 'Completed')
                              Container(
                                  height: 200,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Container(
                                        //   color: AppColors.PRIMARY_COLOR_LIGHT,
                                        //   height: 50,
                                        // ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor:
                                                        AppColors.PRIMARY_COLOR,
                                                    child: Text(
                                                      '${widget.tripResponse.riderFirstName?.substring(0, 1)}${widget.tripResponse.riderLastName?.substring(0, 1)}'
                                                          .toUpperCase(),
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white),
                                                    ),

                                                    // backgroundImage: AssetImage(""),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '${widget.tripResponse.riderFirstName} ${widget.tripResponse.riderLastName}',
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFF663399),
                                                          fontSize: 14,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      Text(
                                                        widget.tripResponse
                                                                .riderPhoneNumber ??
                                                            '',
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFF663399),
                                                          fontSize: 14,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ]),
                                      ])),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                if (widget.tripResponse.driverEmail != null)
                                  SizedBox(
                                    height: 35,
                                    width: 35,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                       String commonChatRoomId = widget.tripResponse.id ?? '';

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ChatScreen(
                                              tripResponse: widget.tripResponse,
                                                chatRoomId: commonChatRoomId),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.message,
                                        size: 35,
                                        color: AppColors.PRIMARY_COLOR_LIGHT,
                                      ),
                                    ),
                                  ),
                                if (widget.tripResponse.driverEmail != null)
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      // _makePhoneCall(widget.tripResponse
                                      //         .driverPhoneNumber ??
                                      //     '');
                                    },
                                    icon: const Icon(
                                      Icons.phone,
                                      size: 35,
                                      color: AppColors.PRIMARY_COLOR_LIGHT,
                                    ),
                                  ),
                                if (widget.tripResponse.driverEmail != null &&
                                    widget.tripResponse.tripStatus != 'Enroute')
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed:
                                        //    widget.tripResponse.tripStatus ==
                                        //     'Enroute' &&
                                        // widget.tripResponse.paymentId != null ? null :
                                        () {
                                      // Get.to(() => CancelTrip(
                                      //     tripResponse:
                                      //         widget.tripResponse));
                                      // tripCtrl.cancelTrip(
                                      //     widget.tripResponse.id ?? '');
                                    },
                                    icon: const Icon(
                                      Icons.do_disturb,
                                      size: 35,
                                      color: AppColors.PRIMARY_COLOR_LIGHT,
                                    ),
                                  )
                              ],
                            ),

                            // widget.tripResponse.tripStatus != 'Approved'
                            //     ? Center(
                            //         child: PrimaryButton(
                            //           height: 60,
                            //           width: 247,
                            //           onPressed: () {
                            //             //  Get.offAll(HomeScreen());
                            //             print(widget.tripResponse.id);
                            //           },
                            //           label: 'Done',
                            //         ),
                            //       )
                            //     : SizedBox(),
                            const SizedBox(
                              height: 10,
                            ),
                            if (widget.tripResponse.tripStatus == 'Created' &&
                                widget.tripResponse.customerEmail != null)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  PrimaryButton(
                                    height: 60,
                                    width: 120,
                                    isLoading: ctrl.loading.value,
                                    onPressed: () {
                                      ctrl.idTrip.value =
                                          widget.tripResponse.id ?? "";
                                      ctrl.customerEmail.value =
                                          widget.tripResponse.customerEmail ??
                                              '';
                                      ctrl.approveTrip();
                                      //  Get.offAll(HomeScreen());
                                    },
                                    label: 'Approve',
                                  ),
                                  Expanded(
                                    child: PrimaryButton(
                                      height: 60,
                                      //    width: 120,
                                      onPressed: () {
                                        Get.back();
                                      },
                                      label: 'Cancel',
                                    ),
                                  )
                                ],
                              ),
                            if (widget.tripResponse.tripStatus == 'Requested' &&
                                widget.tripResponse.customerEmail != null)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Obx(() => PrimaryButton(
                                        isLoading: ctrl.loading.value,
                                        height: 60,
                                        width: 120,
                                        onPressed: () {
                                          ctrl.idTrip.value =
                                              widget.tripResponse.id ?? "";
                                          ctrl.customerEmail.value = widget
                                                  .tripResponse.customerEmail ??
                                              '';
                                          ctrl.approveTrip();
                                          //  Get.offAll(HomeScreen());
                                        },
                                        label: 'Approve',
                                      )),
                                  Expanded(
                                    child: PrimaryButton(
                                      height: 60,
                                      //    width: 120,
                                      onPressed: () {
                                        ctrl.idTrip.value =
                                            widget.tripResponse.id ?? "";
                                        ctrl.customerEmail.value =
                                            widget.tripResponse.customerEmail ??
                                                '';
                                        ctrl.declineTrip();
                                      },
                                      label: 'Decline',
                                    ),
                                  )
                                ],
                              ),
                            if (widget.tripResponse.tripStatus == 'Created' &&
                                widget.tripResponse.riderFirstName == null)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  PrimaryButton(
                                    height: 60,
                                    // width: 120,
                                    onPressed: () {
                                      ctrl.idTrip.value =
                                          widget.tripResponse.id ?? "";
                                      ctrl.customerEmail.value =
                                          widget.tripResponse.customerEmail ??
                                              '';
                                      //  ctrl.approveTrip();
                                      //  Get.offAll(HomeScreen());
                                    },
                                    label: 'Update',
                                  ),
                                  Expanded(
                                    child: PrimaryButton(
                                      height: 60,
                                      onPressed: () {
                                        Get.back();
                                      },
                                      label: 'Cancel',
                                    ),
                                  )
                                ],
                              ),
                            if (widget.tripResponse.tripStatus == 'Approved' ||
                                widget.tripResponse.tripStatus == 'Enroute')
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: PrimaryButton(
                                      height: 60,
                                      // width: 120,

                                      onPressed: () {
                                        ctrl.startTrip(
                                            widget.tripResponse.id.toString());
                                      },
                                      label: 'Start Trip',
                                    ),
                                  ),
                                  PrimaryButton(
                                    height: 60,
                                    width: 120,
                                    //  isLoading: ctrl.loading.value,
                                    onPressed: () {
                                      ctrl.endTrip(
                                          widget.tripResponse.id.toString());
                                    },
                                    label: 'End Trip',
                                  )
                                ],
                              )
                          ]),
                    ),
                  )
                ],
              ),
            ))));
  }
}

// ChatService.dart

class ChatScreen extends StatefulWidget {
  final String chatRoomId;
  final TripResponse tripResponse;

  ChatScreen({
    Key? key,
    required this.chatRoomId,
    required this.tripResponse,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textFieldController = TextEditingController();

  void sendMessage(String message) {
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatRoomId.toString())
        .collection('messages')
        .add({
      'senderId': FirebaseAuth.instance.currentUser?.uid,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getChatMessages() {
    print('Listening to Chat Messages for chatRoomId: ${widget.chatRoomId}');

    return FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatRoomId.toString())
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR_LIGHT,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40),
        )),
        title: const Text(
          'Chat',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        backgroundColor: AppColors.PRIMARY_COLOR,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: getChatMessages(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                var messages = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    var messageText = message['message'];
                    var messageSender = message['senderId'];

                    var isCurrentUser =
                        FirebaseAuth.instance.currentUser?.uid == messageSender;

                    return Align(
                      alignment: isCurrentUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isCurrentUser
                              ? Colors.white
                              : AppColors.PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
// Text(
//   widget.tripResponse.riderFirstName != null && widget.tripResponse.riderLastName != null
//       ? '${widget.tripResponse.riderFirstName![0].toUpperCase()}${widget.tripResponse.riderFirstName!.substring(1)} ${widget.tripResponse.riderLastName![0].toUpperCase()}${widget.tripResponse.riderLastName!.substring(1)}'
//       : 'Unknown User',
//   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
// ),
                            const SizedBox(height: 4),
                            Text(
                              messageText ?? '',
                              style: TextStyle(
                                color:
                                    isCurrentUser ? Colors.black : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textFieldController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    sendMessage(_textFieldController.text);
                    _textFieldController.clear();
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
