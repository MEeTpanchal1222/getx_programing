import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void login() {
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save();

      Get.snackbar('Success', 'Login successful',animationDuration: Duration(seconds: 2));
    }
  }

  void signUp() {
    if (signupFormKey.currentState!.validate()) {
      signupFormKey.currentState!.save();

      Get.snackbar('Success', 'Sign-up successful',animationDuration: Duration(seconds: 2));
    }
  }
}
