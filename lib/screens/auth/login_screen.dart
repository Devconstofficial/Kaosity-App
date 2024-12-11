import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaosity_app/custom_widgets/custom_button.dart';
import 'package:kaosity_app/custom_widgets/custom_textfield.dart';
import 'package:kaosity_app/screens/auth/controller/auth_controller.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:kaosity_app/utils/app_images.dart';
import 'package:kaosity_app/utils/app_strings.dart';
import 'package:kaosity_app/utils/app_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.find();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(kBgImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(40)),
            child: Column(
              children: [
                SizedBox(height: getHeight(223)),
                Image.asset(kLogo, height: getHeight(48), width: getWidth(258)),
                SizedBox(height: getHeight(30)),
                CustomTextField(
                  controller: authController.usernameController,
                  hintText: 'Email Address',
                ),
                SizedBox(height: getHeight(19)),
                Obx(
                  ()=> CustomTextField(
                    controller: authController.passwordController,
                    hintText: 'Password',
                    isObscure:authController.isPasswordShow2.isTrue? false: true,
                    suffix: authController.isPasswordShow2.isTrue
                        ? GestureDetector(
                            onTap: () {
                              authController.isPasswordShow2.value =
                                  !authController.isPasswordShow2.value;
                            },
                            child: const Icon(
                              Icons.visibility,
                              color: kWhiteColor,
                            ))
                        : GestureDetector(
                            onTap: () {
                              authController.isPasswordShow2.value =
                                  !authController.isPasswordShow2.value;
                            },
                            child: const Icon(
                              Icons.visibility_off,
                              color: kWhiteColor,
                            )),
                  ),
                ),
                SizedBox(height: getHeight(4)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(kForgotPasswordScreenRoute);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: AppStyles.whiteTextStyle().copyWith(
                        fontSize: 13.sp,
                        color: kGreyShade1Color,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: getHeight(41)),
                CustomButton(
                  height: 49,
                  onTap: authController.login,
                  title: 'Log In',
                  width: getWidth(161),
                  borderRadius: 4,
                ),
                SizedBox(height: getHeight(20)),
                Text(
                  'or',
                  style: AppStyles.whiteTextStyle().copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: getHeight(20)),
                CustomButton(
                  height: 44,
                  onTap: () => authController.socialLogin(
                    provider: SocialSignInProvider.google,
                  ),
                  title: 'Continue with Google',
                  color: kWhiteColor,
                  textColor: kBlackColor,
                  textSize: 15,
                  width: 251,
                  borderRadius: 5,
                  icon: kGoogleIcon,
                ),
                if(GetPlatform.isIOS)...[
                  SizedBox(height: getHeight(14)),
                  CustomButton(
                    height: 44,
                    onTap: () => authController.socialLogin(
                      provider: SocialSignInProvider.apple,
                    ),
                    title: 'Continue with Apple',
                    color: kWhiteColor,
                    textColor: kBlackColor,
                    textSize: 15,
                    width: 251,
                    borderRadius: 5,
                    icon: kAppleIcon,
                  ),
                ],
                SizedBox(height: getHeight(24)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account? ",
                      style: AppStyles.whiteTextStyle().copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(kRegisterScreenRoute);
                      },
                      child: Text(
                        'Sign Up',
                        style: AppStyles.whiteTextStyle().copyWith(
                            fontSize: 14.sp,
                            decoration: TextDecoration.underline,
                            decorationColor: kWhiteColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
