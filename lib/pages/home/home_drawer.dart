import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/global_controller.dart';
import '../account/account_page.dart';
import '../auth/sign_in.dart';
import '../notification/notification_page.dart';
import '../ride history/ride_history.dart';
import '../security/reset_password.dart';
import '../trip/requested_trip.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({
    super.key,
  });

  final ctrl = Get.put(GlobalController());
  final globalCtrl = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.purple[800],
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(90), bottomRight: Radius.circular(90))),

      // color: Colors.green,
      child: ListView(
        children: [
          SizedBox(
            height: 120,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.purple[800]),

              //This the first row that contains the circular avatar for the profile picture of the user
              //variables that you would most likely use is : profileImage, username(firstname), cumulativeratingscore
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.amber,
                     child: Center(
                  child: Obx(
                    () => 
                    Text(
                      '${globalCtrl.user.value.lastName!.substring(0, 1)}${globalCtrl.user.value.firstName!.substring(0, 1)}',
style: TextStyle(fontSize: 20,color: Colors.white),
                  ),
                  ),
                ),
                    // backgroundImage: AssetImage(""),
                  ),

                  //This is the nested column that takes the name of the user
                  //Also it nest the Row for the Stars and the rating figures

                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          globalCtrl.user.value.firstName ?? '',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 27,
                                color: Colors.white,
                              ),
                              Text(
                                "5.0",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          //This is the container with the white background Image
          //It contains the items in the menu bar

          Container(
            height: 1000,
            color: Colors.white,
            child: ListView(
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                      top: 10
                    ),
                    child: ListTile(
                        leading: const Icon(
                          Icons.person_2_outlined,
                          size: 30,
                        ),
                        title: const Text(
                          "Account",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        onTap: () {
                          Get.to(() => AccountPage());
                        })),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ListTile(
                    leading: const Icon(
                      Icons.notifications_none_outlined,
                      size: 30,
                    ),
                    title: const Text(
                      "Notifications",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {
                      Get.to(() => const NoticationPage());
                    },
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 5),
                  child: ListTile(
                    leading: const Icon(
                      CupertinoIcons.car,
                      size: 23,
                    ),
                    title: const Text(
                      "Trip",
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Get.to(() =>  RequestTrip());
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 5),
                  child: ListTile(
                    leading: const Icon(
                      CupertinoIcons.car,
                      size: 23,
                    ),
                    title: const Text(
                      "Trip History",
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Get.to(() => const TripHistory());
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 4),
                  child: ListTile(
                    leading: const Icon(
                      CupertinoIcons.creditcard,
                      size: 26,
                    ),
                    title: const Text(
                      "Payment Methods",
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      //  Get.to(() => const NoticationPage());
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.security,
                      size: 30,
                    ),
                    title: const Text(
                      "Settings",
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Get.to(() => ResetPassword());
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: ListTile(
                    leading: Icon(
                      Icons.help,
                      size: 30,
                    ),
                    title: Text(
                      "Help Center",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                ListTile(
                    leading: const Icon(
                      Icons.logout_outlined,
                      size: 30,
                    ),
                    title: const Text(
                      "Log Out",
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Get.offAll(SignIn());
                    })
              ],
            ),
          )
          // Container(
          //   color: Colors.white,
          //   child: ListView(
          //     children: [
          //       ListTile(
          //         leading: Icon(Icons.person),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
