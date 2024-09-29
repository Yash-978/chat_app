import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class FirebaseMessagingService {
  FirebaseMessagingService._();

  static FirebaseMessagingService fm = FirebaseMessagingService._();

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> requestPermission() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      await requestPermission();
    } else if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      Get.snackbar(
          "Permission Checking Protocol", "Notification Permission Approved");
    }
  }

  Future<void> getDeviceToken() async {
    String? token = await firebaseMessaging.getToken();
    log(token!);
  }
}
