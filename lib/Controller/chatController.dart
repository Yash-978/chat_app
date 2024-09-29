import 'package:chat_app/Services/cloudFireStore_Service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxString receiverEmail = "".obs;
  RxString receiverName = "".obs;
  RxString image = "".obs;

  TextEditingController txtMessage = TextEditingController();
  TextEditingController txtUpdateMessage = TextEditingController();

  void getReceiver(String email, String name) {
    receiverName.value = name;
    receiverEmail.value = email;
  }

  void getImage(String url) {
    image.value = url;
  }

  @override
  void onInit() {
    super.onInit();
    CloudFireStoreService.cloudFireStoreService.changeOnlineStatus(true);
  }

  @override
  void onClose() {
    super.onClose();
    CloudFireStoreService.cloudFireStoreService.changeOnlineStatus(false);
  }
}
