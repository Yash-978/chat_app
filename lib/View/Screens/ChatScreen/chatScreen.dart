import 'package:chat_app/Modal/chatModal.dart';
import 'package:chat_app/Services/authService.dart';
import 'package:chat_app/Services/cloudFireStore_Service.dart';
import 'package:chat_app/Services/local_notification_service.dart';
import 'package:chat_app/View/Screens/HomeScreen/homeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // scrolledUnderElevation: 0.1,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chatController.receiverName.value,
            ),
            StreamBuilder(
              stream: CloudFireStoreService.cloudFireStoreService
                  .findUserIsOnlineOrNot(chatController.receiverEmail.value),
              builder: (context, snapshot) {
                Map? user = snapshot.data!.data();
                return Text(
                  user!['isOnline'] ? 'Online' : '',
                  style: TextStyle(fontSize: 12, color: Colors.green),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: CloudFireStoreService.cloudFireStoreService
                    .readChatFromFireStore(
                  chatController.receiverEmail.value,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List data = snapshot.data!.docs;
                  List<ChatModel> chatList = [];
                  List<String> docIdList = [];
                  for (QueryDocumentSnapshot snap in data) {
                    docIdList.add(snap.id);
                    chatList.add(
                      ChatModel.fromMap(snap.data() as Map),
                    );
                  }

                  return ListView.builder(
                    itemCount: chatList.length,
                    itemBuilder: (context, index) {
                      bool isSender = (chatList[index].sender ==
                          AuthService.authService.getCurrentUser()!.email!);
                      return Align(
                        alignment: isSender
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: w * 0.7,
                          ),
                          child: GestureDetector(
                            onLongPress: () {
                              if (chatList[index].sender ==
                                  AuthService.authService
                                      .getCurrentUser()!
                                      .email!) {
                                chatController.txtUpdateMessage =
                                    TextEditingController(
                                        text: chatList[index].message);
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Update"),
                                      content: TextField(
                                        controller:
                                            chatController.txtUpdateMessage,
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              String dcId = docIdList[index];
                                              await CloudFireStoreService
                                                  .cloudFireStoreService
                                                  .updateChat(
                                                      chatController
                                                          .receiverEmail.value,
                                                      chatController
                                                          .txtUpdateMessage
                                                          .text,
                                                      dcId);
                                              Get.back();
                                            },
                                            child: Text("Update")),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            onDoubleTap: () {
                              if (chatList[index].sender ==
                                  AuthService.authService
                                      .getCurrentUser()!
                                      .email!) {
                                CloudFireStoreService.cloudFireStoreService
                                    .removeChat(docIdList[index],
                                        chatController.receiverEmail.value);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 16,
                              ),
                              margin: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 1,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    isSender ? Colors.blue : Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                chatList[index].message!,
                                style: TextStyle(
                                  color: isSender ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            TextField(
              controller: chatController.txtMessage,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () async {
                      ChatModel chat = ChatModel(
                          sender:
                              AuthService.authService.getCurrentUser()!.email,
                          receiver: chatController.receiverEmail.value,
                          message: chatController.txtMessage.text,
                          time: Timestamp.now());
                      await CloudFireStoreService.cloudFireStoreService
                          .addChatInFireStore(chat);
                      await LocalNotificationService.notificationService
                          .showNotification(
                              AuthService.authService.getCurrentUser()!.email!,
                              chatController.txtMessage.text);
                      chatController.txtMessage.clear();
                    },
                    icon: Icon(Icons.send)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
