import 'package:chat_app/Controller/Modal/userModal.dart';
import 'package:chat_app/Services/cloudFireStore_Service.dart';
import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../../../Services/authService.dart';
import 'SignInScreen.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: ListView(
        children: [
          SizedBox(
            height: h * 0.4,
            child: RiveAnimation.asset(
              "assets/Animations/animated_login_character.riv",
              stateMachines: const ["Login Machine"],
              onInit: signInController.onInitStateMachine,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: w * 0.9,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    spreadRadius: 5,
                    blurRadius: 10,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: signInController.moveEyeBall,
                      onTap: signInController.isCheckField,
                      controller: controller.txtName,
                      style: const TextStyle(fontSize: 15),
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        hintText: "Name",
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusColor: Colors.blue,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (String? email) {
                        if (email == null) {
                          return null;
                        }
                        bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(email);
                        return emailValid ? null : 'Email is not valid';
                      },
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    TextFormField(
                      onChanged: signInController.moveEyeBall,
                      onTap: signInController.isCheckField,
                      controller: controller.txtEmail,
                      style: const TextStyle(fontSize: 15),
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        hintText: "Email",
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusColor: Colors.blue,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (String? email) {
                        if (email == null) {
                          return null;
                        }
                        bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(email);
                        return emailValid ? null : 'Email is not valid';
                      },
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    TextFormField(
                      onTap: () {
                        signInController.hidePassword();
                        signInController.obscure.value =
                            !signInController.obscure.value;
                      },
                      controller: controller.txtPassword,
                      obscureText: signInController.obscure.value,
                      style: const TextStyle(fontSize: 15),
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        hintText: "Password",
                        filled: true,
                        suffixIcon: Obx(
                          () => Icon(
                            signInController.obscure.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: signInController.obscure.value
                                ? Colors.blue
                                : Colors.black,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusColor: Colors.blue,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (String? password) {
                        if (password == null) {
                          return null;
                        }
                        if (password.length < 8) {
                          return "Password must be greater than 8 characters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    TextFormField(
                      onTap: () {
                        signInController.hidePassword();
                        signInController.obscure.value =
                            !signInController.obscure.value;
                      },
                      controller: controller.txtConfirmPassword,
                      obscureText: signInController.obscure.value,
                      style: const TextStyle(fontSize: 15),
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        filled: true,
                        suffixIcon: Obx(
                          () => Icon(
                            signInController.obscure.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: signInController.obscure.value
                                ? Colors.blue
                                : Colors.black,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusColor: Colors.blue,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (String? password) {
                        if (password == null) {
                          return null;
                        }
                        if (password.length < 8) {
                          return "Password must be greater than 8 characters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                          () => Checkbox(
                            checkColor: Colors.white,
                            activeColor: Colors.blue,
                            tristate: true,
                            value: signInController.rememberMeCheck.value,
                            onChanged: (value) {
                              (signInController.rememberMeCheck.value =
                                  value ?? false);
                            },
                          ),
                        ),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'By creating an account you agree to our',
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                            Text(
                              'Terms & Conditions',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    GestureDetector(
                      onTap: ()
                      async {
                        if (controller.txtPassword.text ==
                            controller.txtConfirmPassword.text) {
                          await AuthService.authService
                              .createAccountWithEmailAndPassword(
                              controller.txtEmail.text,
                              controller.txtPassword.text);

                          UserModel user = UserModel(
                              name: controller.txtName.text,
                              email: controller.txtEmail.text,
                              phone: controller.txtPhone.text,
                              token: "-",
                              image: "https://img.freepik.com/premium-photo/stylish-man-flat-vector-profile-picture-ai-generated_606187-310.jpg");

                          CloudFireStoreService.cloudFireStoreService
                              .insertUserIntoFireStore(user);
                          Get.back();

                          controller.txtEmail.clear();
                          controller.txtPassword.clear();
                          controller.txtName.clear();
                          controller.txtConfirmPassword.clear();
                          controller.txtPhone.clear();
                        }
                      },
                      // onTap: () {
                      //
                      //   AuthService.authService
                      //       .createAccountWithEmailAndPassword(
                      //           controller.txtEmail.text,
                      //           controller.txtPassword.text);
                      //
                      //
                      //   // CloudFireStoreService.cloudFireStoreService
                      //   //     .insertUserIntoFireStore();
                      //
                      //   controller.txtEmail.clear();
                      //   controller.txtPassword.clear();
                      // },
                      child: Container(
                        height: h * 0.06,
                        width: w * 0.86,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.blue[200],
                        ),
                        child: const Center(
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Obx(
                    //   () => CheckboxListTile(
                    //     controlAffinity: ListTileControlAffinity.leading,
                    //     title: const Text(
                    //       'By creating an account you agree to our',
                    //       style: TextStyle(
                    //         color: Colors.black38,
                    //       ),
                    //     ),
                    //     subtitle: const Text(
                    //       'Terms & Conditions',
                    //       style: TextStyle(
                    //         color: Colors.blue,
                    //         fontSize: 18,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //     tileColor: Colors.black,
                    //     tristate: true,
                    //     value: signInController.rememberMeCheck.value,
                    //     activeColor: Colors.blue,
                    //     onChanged: (value) {
                    //       (signInController.rememberMeCheck.value =
                    //           value ?? false);
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: h * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                "Already have an account?",
                style: TextStyle(
                  color: Color(0xFFb8b8b8),
                ),
              ),
              TextButton(
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  // Navigator.pop(context);
                  Get.back();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
