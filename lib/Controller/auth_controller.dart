import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
// bool _obscure = false;
// bool obscureText = false;
class AuthController extends GetxController {
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  final TextEditingController txtConfirmPassword = TextEditingController();

}

class SignInController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool obscure = false.obs;
  final RxBool _obscure = false.obs;
  RxBool rememberMeCheck=false.obs;

  void obscureCheck() {
    _obscure.value = !_obscure.value;
  }
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

  void moveEyeBall(value) {
    numLook?.change(value.length.toDouble());
  }

  void hidePassword() {
    isHandsUp?.change(true);
  }

  void onInitStateMachine(Artboard artBoard) {
    stateMachineController = StateMachineController.fromArtboard(artBoard, "Login Machine");
    if (stateMachineController == null) return;
    artBoard.addController(stateMachineController!);
    isChecking = stateMachineController?.findInput("isChecking");
    isHandsUp = stateMachineController?.findInput("isHandsUp");
    trigSuccess = stateMachineController?.findInput("trigSuccess");
    trigFail = stateMachineController?.findInput("trigFail");
    numLook = stateMachineController?.findSMI("numLook");
  }
}
