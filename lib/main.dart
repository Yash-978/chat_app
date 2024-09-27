import 'package:chat_app/Services/local_notification_service.dart';
import 'package:chat_app/View/Screens/Auth/authManager.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'View/Screens/Auth/SignInScreen.dart';
import 'View/Screens/Auth/SignUpScreen.dart';
import 'View/Screens/ChatScreen/chatScreen.dart';
import 'View/Screens/HomeScreen/homeScreen.dart';
import 'View/Screens/SplashScreen/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalNotificationService.notificationService.initNotificationService();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashPage(),
        ),
        GetPage(
          name: '/',
          page: () => const AuthManager(),
        ),
        GetPage(
          name: '/signIn',
          page: () => const SignInPage(),
        ),
        GetPage(
          name: '/signUp',
          page: () => const SignUpPage(),
        ),
        GetPage(
          name: '/home',
          page: () => const HomePage(),
        ),
        GetPage(
          name: '/chat',
          page: () => const ChatPage(),
        ),
      ],
    );
  }
}
