import 'package:chat_app/Controller/chatController.dart';
import 'package:chat_app/Modal/userModal.dart';
import 'package:chat_app/Services/authService.dart';
import 'package:chat_app/Services/cloudFireStore_Service.dart';

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
                await AuthService.authService.signOutUser();
                await GoogleAuthServices.googleAuthServices.signOutFromGoogle();
                User? user = AuthService.authService.getCurrentUser();
                if (user == null) {
                  Get.offAndToNamed('/signIn');
                }
              },
              icon: Icon(Icons.logout_rounded))
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
