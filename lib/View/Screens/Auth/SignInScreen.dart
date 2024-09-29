/*
import 'package:chat_app/Controller/auth_controller.dart';
import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rive/rive.dart';
import 'package:rive/rive.dart' as rive;

import '../Component/authComponent.dart';

bool _obscure = false;
bool obscureText = false;
// for controller
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

// final TextEditingController usernameController = TextEditingController();
// final TextEditingController passwordController = TextEditingController();

SMIInput<bool>? isChecking;
SMIInput<bool>? isHandsUp;
SMIInput<bool>? trigSuccess;
SMIInput<bool>? trigFail;
SMINumber? numLook;

late StateMachineController? stateMachineController;

void isCheckField() {
  isHandsUp?.change(false);
  isChecking?.change(true);
  numLook?.change(0);
}

void moveEyeBall(val) {
  numLook?.change(val.length.toDouble());
}

void hidePassword() {
  isHandsUp?.change(true);
}

var controller = Get.put(AuthController());

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    super.initState();
    if (obscureText) {
      _obscure = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: h * 0.4,
                child: RiveAnimation.asset(
                  "assets/Animations/animated_login_character.riv",
                  stateMachines: const ["Login Machine"],
                  onInit: (artBoard) {
                    stateMachineController =
                        StateMachineController.fromArtboard(artBoard,
                            "Login Machine" // it must me same from rive name
                            );
                    if (stateMachineController == null) return;
                    artBoard.addController(stateMachineController!);
                    isChecking =
                        stateMachineController?.findInput("isChecking");
                    isHandsUp = stateMachineController?.findInput("isHandsUp");
                    trigSuccess =
                        stateMachineController?.findInput("trigSuccess");
                    trigFail = stateMachineController?.findInput("trigFail");
                    numLook = stateMachineController?.findSMI("numLook");
                  },
                ),
              ),
              // now for ui parts(login page),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  alignment: Alignment.center,
                  width: 400,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black38,
                          spreadRadius: 10,
                          blurRadius: 10),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            onChanged: (value) {
                              numLook?.change(value.length.toDouble());
                            },
                            onTap: () {
                              isHandsUp?.change(false);
                              isChecking?.change(true);
                              numLook?.change(0);
                            },
                            controller: controller.txtEmail,
                            style: const TextStyle(fontSize: 15),
                            cursorColor: const Color.fromARGB(255, 176, 72, 99),
                            decoration: InputDecoration(
                              hintText: "Email",
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusColor:
                                  const Color.fromARGB(255, 176, 72, 99),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 176, 72, 99),
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            validator: (String? email) {
                              if (email == null) {
                                return null;
                              }
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(email);
                              return emailValid ? null : 'Email is not valid';
                            },
                          ),

                          // eye is moving
                          const SizedBox(height: 20),
                          TextFormField(
                            onTap: () {
                              setState(() {
                                isHandsUp?.change(true);
                                _obscure = !_obscure;
                              });
                            },
                            controller: controller.txtPassword,
                            obscureText: _obscure,
                            style: const TextStyle(fontSize: 15),
                            cursorColor: const Color.fromARGB(255, 176, 72, 99),
                            decoration: InputDecoration(
                              hintText: "Password",
                              filled: true,
                              suffixIcon: Icon(
                                _obscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusColor:
                                  const Color.fromARGB(255, 176, 72, 99),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 176, 72, 99),
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            validator: (String? password) {
                              if (password == null) {
                                return null;
                              }
                              if (password.length < 8) {
                                return "Password must be greater than 8 character";
                              }
                            },
                          ),
                          const SizedBox(height: 25),
                          Container(
                            height: 50,
                            width: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.blue[200]),
                            child: InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  isChecking!.change(false);
                                  isHandsUp!.change(false);
                                  trigFail!.change(false);
                                  trigSuccess!.change(true); // for success
                                  isChecking!.change(false);
                                } else {
                                  isChecking!.change(false);
                                  isHandsUp!.change(false);
                                  trigFail!.change(true); // for un success
                                  trigSuccess!.change(false);
                                  isChecking!.change(false);
                                }
                              },
                              child: const Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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

import 'package:chat_app/Services/authService.dart';
import 'package:chat_app/Services/google_auth_Service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import 'package:sign_in_button/sign_in_button.dart';

import '../../../Controller/auth_controller.dart';

final SignInController signInController = Get.put(SignInController());
// final AuthController authController = Get.put(AuthController());
final AuthController controller = Get.put(AuthController());

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: ListView(
          reverse: true,
          shrinkWrap: true,
          children: [
            SizedBox(
              height: h * 0.36,
              width: w * 1,
              child: RiveAnimation.asset(
                "assets/Animations/animated_login_character.riv",
                stateMachines: const ["Login Machine"],
                onInit: signInController.onInitStateMachine,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                alignment: Alignment.center,
                width: w * 0.9,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
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
                  child: Form(
                    key: signInController.formKey,
                    child: Column(
                      children: [
                        // Email field
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
                              borderSide: const BorderSide(
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (String? email) {
                            if (email == null) {
                              return null;
                            }
                            bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ).hasMatch(email);
                            return emailValid ? null : 'Email is not valid';
                          },
                        ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        // Password field
                        TextFormField(
                          onTap: () {
                            signInController.hidePassword();
                            signInController.obscure.value =
                                !signInController.obscure.value;
                          },
                          controller: controller.txtPassword,
                          obscureText: signInController.obscure.value,
                          style: const TextStyle(fontSize: 15),
                          cursorColor: const Color.fromARGB(255, 176, 72, 99),
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
                            focusColor: const Color.fromARGB(255, 176, 72, 99),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 176, 72, 99)),
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
                        SizedBox(height: h * 0.02),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Obx(
                            () => CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              title: const Text('Remember me'),
                              tileColor: Colors.black,
                              tristate: true,
                              value: signInController.rememberMeCheck.value,
                              activeColor: Colors.blue,
                              onChanged: (value) {
                                (signInController.rememberMeCheck.value =
                                    value ?? false);
                              },
                            ),
                          ),
                        ),
                        Obx(
                          () => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[200],
                              minimumSize: Size(w * 0.87, h * 0.06),
                              maximumSize: Size(w * 0.87, h * 0.06),
                              shape: StadiumBorder(),
                              textStyle: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                            onPressed: () async {
                              if (signInController.formKey.currentState!
                                  .validate()) {
                                signInController.isChecking?.value = true;
                                signInController.isHandsUp?.value = false;
                                signInController.trigFail?.value = false;
                                signInController.trigSuccess?.value = true;

                                if (signInController.isSignUp.value) return;

                                signInController.isSignUp.value = true;
                                String response = await AuthService.authService
                                    .signInWithEmailAndPassword(
                                  controller.txtEmail.text,
                                  controller.txtPassword.text,
                                );
                                User? user =
                                    AuthService.authService.getCurrentUser();

                                if (user != null && response == "Success") {
                                  Get.offAndToNamed('/home');
                                } else {
                                  Get.snackbar(
                                    'Sign in Invalid',
                                    'Email or Password may be wrong, $response',
                                  );
                                }
                                signInController.isSignUp.value = false;
                              } else {
                                signInController.isChecking?.value = false;
                                signInController.isHandsUp?.value = false;
                                signInController.trigFail?.value = true;
                                signInController.trigSuccess?.value = false;
                              }
                            },
                            child: signInController.isSignUp.value
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: w * 0.050,
                                      ),
                                      Text(
                                        'Please wait...',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  )
                                : Text(
                                    'Login',
                                    style: TextStyle(color: Colors.black),
                                  ),
                          ),
                        ),
                        SignInButton(
                          Buttons.googleDark,
                          onPressed: () async {
                            await GoogleAuthServices.googleAuthServices
                                .signInWithGoogle();
                            User? user =
                                AuthService.authService.getCurrentUser();
                            if (user != null) {
                              Get.offAndToNamed('/home');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: h * 0.1,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  "Don't have an account",
                  style: TextStyle(
                    color: Color(0xFFb8b8b8),
                  ),
                ),
                TextButton(
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed('/signUp');
                  },
                ),
              ],
            ),
          ].reversed.toList(),
        ),
      ),
    );
  }
}
