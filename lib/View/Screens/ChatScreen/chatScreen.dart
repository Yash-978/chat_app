import 'package:chat_app/Modal/chatModal.dart';
import 'package:chat_app/Services/authService.dart';
import 'package:chat_app/Services/cloudFireStore_Service.dart';
import 'package:chat_app/View/Screens/HomeScreen/homeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chatController.receiverName.value),
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
                for (QueryDocumentSnapshot snap in data) {
                  chatList.add(
                    ChatModel.fromMap(snap.data() as Map),
                  );
                }
                return ListView.builder(
                  itemCount: chatList.length,
                  itemBuilder: (context, index) {
                    return Text(chatList[index].message!);
                  },
                );
              },
            )),
            TextField(
              controller: chatController.txtMessage,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () async {
                      ChatModel chat = ChatModel(
                          sender: AuthService.authService.getCurrentUser()!.email,
                          receiver: chatController.receiverEmail.value,
                          message: chatController.txtMessage.text,
                          time: Timestamp.now());
                      await CloudFireStoreService.cloudFireStoreService
                          .addChatInFireStore(chat);
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
