/*
import 'package:chat_app/Controller/chatController.dart';
import 'package:chat_app/Modal/userModal.dart';
import 'package:chat_app/Services/authService.dart';
import 'package:chat_app/Services/cloudFireStore_Service.dart';
import 'package:chat_app/Services/local_notification_service.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Services/google_auth_Service.dart';

ChatController chatController = Get.put(ChatController());

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    CloudFireStoreService.cloudFireStoreService.changeOnlineStatus(true);
  }

  @override
  void dispose() {
    super.dispose();
    print('----------------dispose-----------------------');
    CloudFireStoreService.cloudFireStoreService.changeOnlineStatus(false);
  }

  @override
  void deactivate() {
    super.deactivate();
    print('---------------deactivate-------------');
    CloudFireStoreService.cloudFireStoreService.changeOnlineStatus(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: FutureBuilder(
          future: CloudFireStoreService.cloudFireStoreService
              .readCurrentUserFromFireStore(),
          builder: (context, snapshot) {
            Map? data = snapshot.data!.data();
            print(data);
            UserModel userModel = UserModel.fromMap(data!);
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DrawerHeader(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(userModel.image!),
                  ),
                ),
                Text(userModel.name!),
                Text(userModel.email!),
                Text(userModel.phone!),
              ],
            );
          },
        ),
      ),
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
              onPressed: () async {
                await LocalNotificationService.notificationService
                    .scheduledNotification();
              },
              icon: const Icon(Icons.notifications_active)),
          IconButton(
              onPressed: () async {
                await AuthService.authService.signOutUser();
                await GoogleAuthServices.googleAuthServices.signOutFromGoogle();
                User? user = AuthService.authService.getCurrentUser();
                if (user == null) {
                  Get.offAndToNamed('/signIn');
                }
              },
              icon: Icon(Icons.logout_rounded)),
        ],
      ),
      body: FutureBuilder(
        future: CloudFireStoreService.cloudFireStoreService
            .readAllUserCloudFireStore(),
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
          List<UserModel> userList = [];
          for (var user in data) {
            userList.add(
              UserModel.fromMap(
                user.data(),
              ),
            );
          }
          return ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  chatController.getReceiver(
                      userList[index].email!, userList[index].name!);
                  Get.toNamed('/chat');
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(userList[index].image!),
                ),
                title: Text(userList[index].name!),
                subtitle: Text(userList[index].email!),
              );
            },
          );
        },
      ),
    );
  }
}
*/

import 'dart:ui';

import 'package:chat_app/Controller/chatController.dart';
import 'package:chat_app/Modal/userModal.dart';
import 'package:chat_app/Services/authService.dart';
import 'package:chat_app/Services/cloudFireStore_Service.dart';
import 'package:chat_app/Services/local_notification_service.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart' as r;

import '../../../Services/google_auth_Service.dart';
import '../../../Utils/global.dart';

ChatController chatController = Get.put(ChatController());

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    CloudFireStoreService.cloudFireStoreService.toggleOnlineStatus(
      true,
      // Timestamp.now(),
      // false,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      CloudFireStoreService.cloudFireStoreService.toggleOnlineStatus(false);
      CloudFireStoreService.cloudFireStoreService.updateLastSeen();
    } else if (state == AppLifecycleState.resumed) {
      CloudFireStoreService.cloudFireStoreService.toggleOnlineStatus(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double WIDTH = 500;
    return Scaffold(
      drawer: Drawer(
        child: FutureBuilder(
          future: CloudFireStoreService.cloudFireStoreService
              .readCurrentUserFromFireStore(),
          builder: (context, snapshot) {
            Map? data = snapshot.data!.data();
            print(data);
            UserModel userModel = UserModel.fromMap(data!);
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DrawerHeader(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(userModel.image!),
                  ),
                ),
                Text(userModel.name!),
                Text(userModel.email!),
                Text(userModel.phone!),
              ],
            );
          },
        ),
      ),
      /*appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
              onPressed: () async {
                await LocalNotificationService.notificationService
                    .scheduledNotification();
              },
              icon: const Icon(Icons.notifications_active)),
          IconButton(
              onPressed: () async {
                await AuthService.authService.signOutUser();
                await GoogleAuthServices.googleAuthServices.signOutFromGoogle();
                User? user = AuthService.authService.getCurrentUser();
                if (user == null) {
                  Get.offAndToNamed('/signIn');
                }
              },
              icon: Icon(Icons.logout_rounded)),
        ],
      ),*/
      body: FutureBuilder(
        future: CloudFireStoreService.cloudFireStoreService
            .readAllUserCloudFireStore(),
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
          List<UserModel> userList = [];
          for (var user in data) {
            userList.add(
              UserModel.fromMap(
                user.data(),
              ),
            );
          }
          return Stack(
            children: [
              // Custom Paint and Rive Animation
              CustomPaint(
                size: Size(WIDTH, (WIDTH * 2.2222222222222223).toDouble()),
                painter: RPSCustomPainter(),
              ),
              r.RiveAnimation.asset(
                'assets/Animations/shapes.riv',
                fit: BoxFit.fill,
              ),

              // Icons row at the top of the screen
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  height: 60, // Fixed height for the icon row
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Placeholder for left spacing (you can replace this with a Rive icon if needed)
                      SizedBox(width: 40),

                      // Notification and Logout Icons
                      Row(
                        children: [
                          Text(
                            "Home",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                          SizedBox(
                            width: w * 0.3,
                          ),
                          IconButton(
                            onPressed: () async {
                              await LocalNotificationService.notificationService
                                  .scheduledNotification();
                            },
                            icon: const Icon(
                              Icons.notifications_active,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await AuthService.authService.signOutUser();
                              await GoogleAuthServices.googleAuthServices
                                  .signOutFromGoogle();
                              User? user =
                                  AuthService.authService.getCurrentUser();
                              if (user == null) {
                                Get.offAndToNamed('/signIn');
                              }
                            },
                            icon: Icon(
                              Icons.logout_rounded,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // The rest of the content (ListView, etc.)
              Padding(
                padding: const EdgeInsets.only(top: 80, left: 8, right: 8),
                // Prevent overlap with the icon row
                child: ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    int seconds = userList[index].timestamp!.seconds;
                    DateTime dateTime =
                        DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
                    String formattedTime =
                        DateFormat('h:mm a').format(dateTime);
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Card(
                            child: ListTile(
                              onTap: () {
                                chatController.getReceiver(
                                    userList[index].email!,
                                    userList[index].name!);
                                Get.toNamed('/chat');
                              },
                              title: Text(
                                userList[index].name!,
                                style: const TextStyle(fontSize: 18),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  userList[index].email!,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(userList[index].image!),
                                radius: 30,
                              ),
                              trailing: Text(
                                formattedTime,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 13),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );

          // return Stack(
          //   children: [
          //     CustomPaint(
          //       size: Size(WIDTH, (WIDTH * 2.2222222222222223).toDouble()),
          //       painter: RPSCustomPainter(),
          //     ),
          //     r.RiveAnimation.asset(
          //       'assets/Animations/shapes.riv',
          //       fit: BoxFit.fill,
          //     ),
          //
          //     // Icons Row at the top of the screen
          //     Positioned(
          //       top: 40, // Adjust the top padding as per your need
          //       left: 0,
          //       right: 0,
          //       child: Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             // Rive Icon (or your custom button)
          //             GestureDetector(
          //               onTap: () {
          //                 // Handle Rive icon tap
          //               },
          //               child: r.RiveAnimation.asset(
          //                 'assets/Animations/icon.riv',
          //               ),
          //             ),
          //             Row(
          //               children: [
          //                 IconButton(
          //                     onPressed: () async {
          //                       await LocalNotificationService.notificationService
          //                           .scheduledNotification();
          //                     },
          //                     icon: const Icon(Icons.notifications_active)),
          //                 IconButton(
          //                     onPressed: () async {
          //                       await AuthService.authService.signOutUser();
          //                       await GoogleAuthServices.googleAuthServices.signOutFromGoogle();
          //                       User? user = AuthService.authService.getCurrentUser();
          //                       if (user == null) {
          //                         Get.offAndToNamed('/signIn');
          //                       }
          //                     },
          //                     icon: Icon(Icons.logout_rounded)),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //
          //     // Your ListView builder and other content
          //     ListView.builder(
          //       padding: EdgeInsets.only(top: 100),
          //       // Prevents overlap with the icon row
          //       itemCount: userList.length,
          //       itemBuilder: (context, index) {
          //         int seconds = userList[index].timestamp!.seconds;
          //         DateTime dateTime =
          //             DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
          //         String formattedTime = DateFormat('h:mm a').format(dateTime);
          //         return Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             Padding(
          //               padding: const EdgeInsets.only(bottom: 8.0),
          //               child: Card(
          //                 child: ListTile(
          //                   onTap: () {
          //                     chatController.getReceiver(userList[index].email!,
          //                         userList[index].name!);
          //                     Get.toNamed('/chat');
          //                   },
          //                   title: Text(
          //                     userList[index].name!,
          //                     style: const TextStyle(fontSize: 18),
          //                   ),
          //                   subtitle: Padding(
          //                     padding: const EdgeInsets.only(top: 6.0),
          //                     child: Text(
          //                       userList[index].email!,
          //                       style: const TextStyle(fontSize: 15),
          //                     ),
          //                   ),
          //                   leading: CircleAvatar(
          //                     backgroundImage:
          //                         NetworkImage(userList[index].image!),
          //                     radius: 30,
          //                   ),
          //                   trailing: Text(
          //                     formattedTime,
          //                     style: const TextStyle(
          //                         color: Colors.grey, fontSize: 13),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         );
          //       },
          //     ),
          //   ],
          // );

          /*Stack(
            children: [
              CustomPaint(
                size: Size(WIDTH, (WIDTH * 2.2222222222222223).toDouble()),
                //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                painter: RPSCustomPainter(),
              ),

              r.RiveAnimation.asset(
                'assets/Animations/shapes.riv',
                fit: BoxFit.fill,
              ),

              ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  // userList[index].timestamp!.seconds,
                  int seconds = userList[index].timestamp!.seconds;
                  // Convert the seconds to DateTime
                  DateTime dateTime =
                      DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
                  // Format the DateTime into hour:minutes AM/PM format
                  String formattedTime = DateFormat('h:mm a').format(dateTime);
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Card(
                          child: ListTile(
                            onTap: () {
                              chatController.getReceiver(userList[index].email!,
                                  userList[index].name!);
                              Get.toNamed('/chat');
                            },
                            title: Text(
                              userList[index].name!,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Text(
                                userList[index].email!,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                userList[index].image!,
                              ),
                              radius: 30,
                            ),
                            trailing: Text(
                              formattedTime,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Divider(color: dividerColor, indent: 85),
                    ],
                  );
                },
              ),
            ],
          );*/
        },
      ),
    );
  }
}
