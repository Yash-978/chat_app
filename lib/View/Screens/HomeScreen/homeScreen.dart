import 'package:chat_app/Services/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
              onPressed: () {
                AuthService.authService.getCurrentUser();
                User? user = AuthService.authService.getCurrentUser();
                if (user == null) {
                  Get.offAndToNamed('/signIn');
                }
              },
              icon: Icon(Icons.logout_rounded))
        ],
      ),
    );
  }
}
