import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaosity_app/custom_widgets/custom_snackbar.dart';
import 'package:kaosity_app/utils/app_strings.dart';

class AuthController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameRegController = TextEditingController();
  TextEditingController passwordRegController = TextEditingController();
  TextEditingController emailRegController = TextEditingController();
  TextEditingController emailForgetController = TextEditingController();

  void login() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      showCustomSnackbar("Error", "Username and Password cannot be empty");
    } else {
      Get.offAllNamed(kSplashScreenRoute);
    }
  }

  void register() {
    String username = usernameRegController.text.trim();
    String password = passwordRegController.text.trim();
    String email = emailRegController.text.trim();

    if (username.isEmpty || password.isEmpty || email.isEmpty) {
      showCustomSnackbar("Error", "Fields cannot be empty");
    } else {
      Get.offAllNamed(kSplashScreenRoute);
    }
  }

  void forgotPassword() {
    String email = usernameController.text.trim();

    if (email.isEmpty) {
      showCustomSnackbar("Error", "Email cannot be empty");
    } else {
      Get.back();
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    usernameRegController.dispose();
    emailRegController.dispose();
    passwordRegController.clear();
    super.dispose();
  }
}
