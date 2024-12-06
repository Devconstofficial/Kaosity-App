import 'dart:convert';
import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kaosity_app/utils/app_colors.dart';

import '../../../custom_widgets/custom_snackbar.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/const.dart';

class AuthService {
  final GetStorage box = GetStorage();

  Future<void> signIn(String email, String password) async {
    final url = Uri.parse("$server_url/auth/signin");

    try {
      print("Calling API: $url");
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "email": email,
          "password": password,
        }),
      );

      print("Response: ${response.statusCode} ${response.body}");

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        final data = responseData["data"];
        box.write('authToken', data['authToken']);
        box.write('user', data['user']);
        log('User logged in successfully: ${data['user']}');
        log('authToken: ${data['authToken']}');

        Get.snackbar(
          "Success",
          responseData["message"] ?? "Logged in successfully",
          backgroundColor: kWhiteColor,
          colorText: kBlackColor,
        );

        Get.offAllNamed(kSplashScreenRoute);
      } else {
        final errorData = json.decode(response.body);
        Get.snackbar(
          "Error",
          errorData["message"] ?? "Failed to login",
          backgroundColor: kRedColor,
          colorText: kWhiteColor,
        );
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar(
        "Error",
        "An error occurred: $e",
        backgroundColor: kRedColor,
        colorText: kWhiteColor,
      );
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    final url = Uri.parse("$server_url/auth/signup");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "name": name,
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        Get.snackbar("Successfull!!",
            responseData["message"] ?? "Account created successfully",
            backgroundColor: kWhiteColor, colorText: kBlackColor);

        log(response.body.toString(), name: "Signup Response");
        Get.close(1);
      } else {
        final errorData = json.decode(response.body);
        showCustomSnackbar(
          "Error",
          errorData["message"] ?? "Failed to create account",
        );

        log(errorData.toString(), name: "Signup Response");
      }
    } catch (e) {
      showCustomSnackbar(
        "Error",
        "An error occurred: $e",
      );
      log(e.toString(), name: "Signup Response");
    }
  }

  Future<void> sendOtpToEmail(String email) async {
    try {
      final response = await http.post(
        Uri.parse("$server_url/auth/forgotPassword/sendOTP"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      log("Response Status Code: ${response.statusCode}");
      log("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log(data["message"]);
        Get.snackbar("Success", "Please check your email $email for the OTP",
            backgroundColor: kWhiteColor, colorText: kBlackColor);
        Get.toNamed(kOTPVerificationScreenRoute);
      } else {
        final error = jsonDecode(response.body);
        log("Error: ${error["message"]}");
        Get.snackbar("Error", error["message"],
          backgroundColor: kRedColor, colorText: kBlackColor);
       
      }
    } catch (e) {
      log("Error sending OTP: $e");
      Get.snackbar("Error", "Failed to send OTP. Please try again.",
          backgroundColor: kRedColor, colorText: kBlackColor);
    }
  }

  Future<void> verifyOtp(String email, String otp) async {
    try {
      Map<String, dynamic> data = {
        'email': email,
        'otp': otp,
      };
      final response = await http.post(
        Uri.parse('$server_url/auth/forgotPassword/VerifyEmail'), 
        headers: {
          'Content-Type': 'application/json', 
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log(data["message"]);
        Get.snackbar("Success", "Email address has been verified",
            backgroundColor: kWhiteColor, colorText: kBlackColor);
        Get.toNamed(kResetPasswordScreenRoute);
      } else {
        final error = jsonDecode(response.body);
        log("Error: ${error["message"]}");
        Get.snackbar("Error", error["message"],
          backgroundColor: kRedColor, colorText: kBlackColor);
      }
    } catch (e) {
      log("Error verifying OTP: $e");
      Get.snackbar("Error", "Failed to verify OTP. Please try again.",
          backgroundColor: kRedColor, colorText: kBlackColor);
    }
  }

  Future<void> resetPassword(String email, String password) async {
    try {
      Map<String, dynamic> data = {
        'email': email,
        'password': password,
      };

      final response = await http.post(
        Uri.parse('$server_url/auth/createPassword'), 
        headers: {
          'Content-Type': 'application/json', 
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        log(data["message"]);
        Get.snackbar("Success", "Password has been reset",
            backgroundColor: kWhiteColor, colorText: kBlackColor);
       Get.offAllNamed(kLoginScreenRoute);
      } else {
       final error = jsonDecode(response.body);
        log("Error: ${error["message"]}");
        Get.snackbar("Error", error["message"],
          backgroundColor: kRedColor, colorText: kBlackColor);
      }
    } catch (e) {
       log("Error resetting password: $e");
      Get.snackbar("Error", "Failed to reset password. Please try again.",
          backgroundColor: kRedColor, colorText: kBlackColor);
    }
  }
}
