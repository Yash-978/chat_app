/*
import 'package:chat_app/Modal/chatModal.dart';
import 'package:chat_app/Services/authService.dart';
import 'package:chat_app/Services/cloudFireStore_Service.dart';
import 'package:chat_app/Services/local_notification_service.dart';
import 'package:chat_app/Services/storage_service.dart';
import 'package:chat_app/View/Screens/HomeScreen/homeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

FocusNode myFocusNode = FocusNode();

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with WidgetsBindingObserver{

  @override


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {




  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // CircleAvatar(
              //   backgroundImage: NetworkImage('${widget.img}'),
              // ),
              // SizedBox(width: screenWidth * 0.03),
              // Use media query for spacing
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${chatController.receiverName}',
                    overflow: TextOverflow.ellipsis,
                    // Adds ellipsis when the text overflows
                    maxLines: 1,
                    // Limits the text to a single line
                    style: TextStyle(

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  StreamBuilder(
                      stream: CloudFireStoreService.cloudFireStoreService
                          .checkUserIsOnlineOrNot(
                          chatController.receiverEmail.value),
                      builder: (context, snapshot) {
                        Map? user = snapshot.data!.data();
                        String nightDay = '';
                        // DateTime? lastSeen;
                        if (user!['timestamp'].toDate().hour > 11) {
                          nightDay = 'pm';
                        } else {
                          nightDay = 'am';
                        }
                        // // lastSeen = user!['timestamp'].toDate();
                        // // nightDay = lastSeen!.hour >= 12 ? 'PM' : 'AM';

                        return Text(
                          user['isOnline']
                              ? (user['typing'])
                              ? 'Typing...'
                              : 'Online'
                              : 'Last seen at ${DateFormat('hh:mm a').format(user['timestamp'].toDate())}',
                          style: TextStyle(

                              color: Colors.black),
                        );

                      })
                ],
              )
            ],
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: Icon(Icons.videocam_rounded)),
        ],
      ),
      body: Container(
        height: h * 1,
        width: w * 1,
        decoration: BoxDecoration(
          // gradient: LinearGradient(colors: [Colors.red,Colors.blue,Colors.green]),
          image: DecorationImage(
              image: AssetImage('assets/images/whatspp1dark.png'),
              fit: BoxFit.cover),
        ),
        child: Padding(
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
                                if (isSender) {
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
                                                            .receiverEmail
                                                            .value,
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
                                if (isSender) {
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
                                child: (chatList[index].image!.isEmpty &&
                                        chatList[index].image == "")
                                    ? Text(
                                        chatList[index].message!,
                                        style: TextStyle(
                                          color: isSender
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      )
                                    : Image.network(chatList[index].image!),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                color: Colors.white70,
                child: TextField(
                  onChanged: (value) {
                    chatController.messageStore.value = value;
                  CloudFireStoreService.cloudFireStoreService
                        .toggleTypingStatus(
                      true,
                    );
                  },
                  onTapOutside: (event) {
                    CloudFireStoreService.cloudFireStoreService
                        .toggleTypingStatus(
                      false,
                    );
                  },
                  controller: chatController.txtMessage,
                  // onChanged: (value) {
                  //   chatController.messageStore.value = value;
                  //   ChatServices.chatServices.toggleOnlineStatus(
                  //     true,
                  //     Timestamp.now(),
                  //     true,
                  //   );
                  // },
                  // onTapOutside: (event) {
                  //   ChatServices.chatServices.toggleOnlineStatus(
                  //     true,
                  //     Timestamp.now(),
                  //     false,
                  //   );
                  // },
                  decoration: InputDecoration(
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () async {
                              String url =
                                  await StorageService.service.uploadImage();
                              chatController.getImage(url);
                            },
                            icon: Icon(Icons.image)),
                        IconButton(
                            onPressed: () async {
                              ChatModel chat = ChatModel(
                                  image: chatController.image.value,
                                  sender: AuthService.authService
                                      .getCurrentUser()!
                                      .email,
                                  receiver: chatController.receiverEmail.value,
                                  message: chatController.txtMessage.text,
                                  time: Timestamp.now());
                              await CloudFireStoreService.cloudFireStoreService
                                  .addChatInFireStore(chat);
                              await LocalNotificationService.notificationService
                                  .showNotification(
                                      AuthService.authService
                                          .getCurrentUser()!
                                          .email!,
                                      chatController.txtMessage.text);
                              chatController.txtMessage.clear();
                              chatController.getImage("");
                            },
                            icon: Icon(Icons.send)),
                      ],
                    ),
                    hintText: 'Type a message!',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
import 'package:chat_app/Modal/chatModal.dart';
import 'package:chat_app/Services/authService.dart';
import 'package:chat_app/Services/cloudFireStore_Service.dart';
import 'package:chat_app/Services/local_notification_service.dart';
import 'package:chat_app/Services/storage_service.dart';
import 'package:chat_app/View/Screens/HomeScreen/homeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

FocusNode myFocusNode = FocusNode();

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.green.shade700,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.1,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chatController.receiverName.value,
            ),
            StreamBuilder(
                stream: CloudFireStoreService.cloudFireStoreService
                    .checkUserIsOnlineOrNot(chatController.receiverEmail.value),
                builder: (context, snapshot) {
                  Map? user = snapshot.data!.data();
                  String nightDay = '';
                  // DateTime? lastSeen;
                  if (user!['timestamp'].toDate().hour > 11) {
                    nightDay = 'pm';
                  } else {
                    nightDay = 'am';
                  }
                  // // lastSeen = user!['timestamp'].toDate();
                  // // nightDay = lastSeen!.hour >= 12 ? 'PM' : 'AM';

                  return Text(
                    user['isOnline']
                        ? (user['typing'])
                            ? 'Typing...'
                            : 'Online'
                        : 'Last seen at ${DateFormat('hh:mm a').format(user['timestamp'].toDate())}',
                    style: TextStyle(color: Colors.black),
                  );
                })
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: Icon(Icons.videocam_rounded)),
        ],
      ),
      body: Container(
        height: h * 1,
        width: w * 1,
        decoration: BoxDecoration(
          // gradient: LinearGradient(colors: [Colors.red,Colors.blue,Colors.green]),
          image: DecorationImage(
              image: AssetImage('assets/images/whatspp1dark.png'),
              fit: BoxFit.cover),
        ),
        child: Padding(
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
                                if (isSender) {
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
                                                            .receiverEmail
                                                            .value,
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
                                if (isSender) {
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
                                child: (chatList[index].image!.isEmpty &&
                                        chatList[index].image == "")
                                    ? Text(
                                        chatList[index].message!,
                                        style: TextStyle(
                                          color: isSender
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      )
                                    : Image.network(chatList[index].image!),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                color: Colors.white70,
                child: TextField(
                  onChanged: (value) {
                    chatController.messageStore.value = value;
                   CloudFireStoreService.cloudFireStoreService
                        .toggleTypingStatus(
                      true,
                    );
                  },
                  onTapOutside: (event) {
                    CloudFireStoreService.cloudFireStoreService
                        .toggleTypingStatus(
                      false,
                    );
                  },
                  controller: chatController.txtMessage,
                  decoration: InputDecoration(
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () async {
                              String url =
                                  await StorageService.service.uploadImage();
                              chatController.getImage(url);
                            },
                            icon: Icon(Icons.image)),
                        IconButton(
                            onPressed: () async {
                              ChatModel chat = ChatModel(
                                  image: chatController.image.value,
                                  sender: AuthService.authService
                                      .getCurrentUser()!
                                      .email,
                                  receiver: chatController.receiverEmail.value,
                                  message: chatController.txtMessage.text,
                                  time: Timestamp.now());
                              await CloudFireStoreService.cloudFireStoreService
                                  .addChatInFireStore(chat);
                              await LocalNotificationService.notificationService
                                  .showNotification(
                                      AuthService.authService
                                          .getCurrentUser()!
                                          .email!,
                                      chatController.txtMessage.text);
                              chatController.txtMessage.clear();
                              chatController.getImage("");
                            },
                            icon: Icon(Icons.send)),
                      ],
                    ),
                    hintText: 'Type a message!',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
