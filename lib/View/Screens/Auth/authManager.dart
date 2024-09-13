import 'package:chat_app/Services/authService.dart';
import 'package:chat_app/View/Screens/Auth/SignInScreen.dart';
import 'package:flutter/material.dart';

import '../HomeScreen/homeScreen.dart';

class AuthManager extends StatelessWidget {
  const AuthManager({super.key});

  @override
  Widget build(BuildContext context) {
    return (AuthService.authService.getCurrentUser() == null)
        ?  const SignInPage()
        :  const HomePage() ;
  }
}
