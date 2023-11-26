

import 'package:get/get.dart';

import '../global/endpoints.dart';
import '../models/notification_model.dart';
import '../pages/home/home_screen.dart';
import '../services/api.dart';

class NotificationController extends GetxController {
  var isLoading = false.obs;
  var loading = false.obs;
  var notificationList = <NotificationModel>[].obs;

   @override
  void onReady() {
    getNotificationList();
    super.onReady();
  }

  void getNotificationList() async {
    final email = ctrl.email.text;
    String encodedEmail = Uri.encodeComponent(email);
    loading.value = true;
    var res = await Api().get('${Endpoints.NOTIFICATION}?email=$encodedEmail');
    loading.value = false;

    if (res.respCode == 0) {
      if (res.data != null) {
        notificationList.assignAll((res.data as List)
            .map((item) => NotificationModel.fromJson(item))
            .toList());
      }
    } else {
      // AppAlert(message: res.respDesc).showAlert();
    }
  }
}
