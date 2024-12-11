import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaosity_app/custom_widgets/custom_snackbar.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameRegController = TextEditingController();
  TextEditingController passwordRegController = TextEditingController();
  TextEditingController emailRegController = TextEditingController();
  TextEditingController emailForgetController = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();

  RxBool isPasswordShow = false.obs;
  RxBool isPasswordShow2 = false.obs;
  RxBool isPasswordShow3 = false.obs;
  RxBool isPasswordShow4 = false.obs;

  RxString otp = ''.obs;
  RxBool isLoading = false.obs;
  void login() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      showCustomSnackbar("Error", "Username and Password cannot be empty");
    } else {
      isLoading.value = true;
      AuthService().signIn(username, password).then((_) {
        log("Signed In Successfully!!");
        isLoading.value = false;
      }).catchError((error) {
        isLoading.value = false;
        showCustomSnackbar("Error", error.toString());
      });
    }
  }

  void register() {
    String username = usernameRegController.text.trim();
    String password = passwordRegController.text.trim();
    String email = emailRegController.text.trim();

    if (username.isEmpty || password.isEmpty || email.isEmpty) {
      showCustomSnackbar("Error", "Fields cannot be empty");
    } else {
      AuthService().signUp(username, email, password).then((_) {
        log("Sign up complete");
        isLoading.value = false;
      }).catchError((error) {
        isLoading.value = false;
        showCustomSnackbar("Error", error.toString());
      });
    }
  }

  void forgotPassword() {
    String email = emailForgetController.text.trim();

    if (email.isEmpty) {
      showCustomSnackbar("Error", "Email cannot be empty");
    } else {
      AuthService().sendOtpToEmail(email).then((_) {
        log("OTP Sent successfully");
      }).catchError((error) {
        showCustomSnackbar("Error", error.toString());
      });
    }
  }

  void verifyOtp() {
    String email = emailForgetController.text.trim();
    if (otp.value.length != 4) {
      showCustomSnackbar("Error", "Please enter a valid 4-digit OTP");
    } else {
      AuthService().verifyOtp(email, otp.value).then((_) {
        log("OTP verification successfull");
      }).catchError((error) {
        showCustomSnackbar("Error", error.toString());
      });
    }
  }

  void resetPassword() {
    String pass1 = newPassword.text.trim();
    String pass2 = confirmNewPassword.text.trim();
    String email = emailForgetController.text.trim();

    if (pass1.isEmpty || pass2.isEmpty) {
      showCustomSnackbar("Error", "Please enter new password and confirm it");
    } else {
      AuthService().resetPassword(email, pass1,).then((_) {
        log("Password reset");
      }).catchError((error) {
        showCustomSnackbar("Error", error.toString());
      });
    }
  }

  void socialLogin({required SocialSignInProvider provider}) async {
    isLoading.value = true;
    await AuthService().loginWithSocial(provider: provider);
    isLoading.value = false;
  }


  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    usernameRegController.dispose();
    emailRegController.dispose();
    passwordRegController.dispose();
    emailForgetController.dispose();
    super.dispose();
  }
}
