import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaosity_app/custom_widgets/custom_button.dart';
import 'package:kaosity_app/custom_widgets/custom_textfield.dart';
import 'package:kaosity_app/screens/auth/controller/auth_controller.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:kaosity_app/utils/app_images.dart';
import 'package:kaosity_app/utils/app_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ResetPassword extends StatelessWidget {
  final AuthController authController = Get.find();

  ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              SizedBox(height: getHeight(213)),
              Text(
                'Reset Password',
                style: AppStyles.whiteTextStyle()
                    .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: getHeight(12)),
              Text(
                'Please enter your new password.',
                textAlign: TextAlign.center,
                style: AppStyles.whiteTextStyle().copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: kGreyShade2Color),
              ),
              SizedBox(height: getHeight(35)),
              Obx(
                ()=> CustomTextField(
                  controller: authController.newPassword,
                  hintText: 'New Password',
                  isObscure:authController.isPasswordShow3.isTrue? false: true,
                  suffix: authController.isPasswordShow3.isTrue
                      ? GestureDetector(
                          onTap: () {
                            authController.isPasswordShow3.value =
                                !authController.isPasswordShow3.value;
                          },
                          child: Icon(
                            Icons.visibility,
                            color: kWhiteColor,
                          ))
                      : GestureDetector(
                          onTap: () {
                            authController.isPasswordShow3.value =
                                !authController.isPasswordShow3.value;
                          },
                          child: Icon(
                            Icons.visibility_off,
                            color: kWhiteColor,
                          )),
                ),
              ),
              SizedBox(height: getHeight(19)),
              Obx(
                ()=> CustomTextField(
                  controller: authController.confirmNewPassword,
                  hintText: 'Confirm New Password',
                  isObscure:authController.isPasswordShow4.isTrue? false: true,
                  suffix: authController.isPasswordShow4.isTrue
                      ? GestureDetector(
                          onTap: () {
                            authController.isPasswordShow4.value =
                                !authController.isPasswordShow4.value;
                          },
                          child: Icon(
                            Icons.visibility,
                            color: kWhiteColor,
                          ))
                      : GestureDetector(
                          onTap: () {
                            authController.isPasswordShow4.value =
                                !authController.isPasswordShow4.value;
                          },
                          child: Icon(
                            Icons.visibility_off,
                            color: kWhiteColor,
                          )),
                ),
              ),
               SizedBox(height: getHeight(80)),
              CustomButton(
                height: 49,
                onTap: (){
                  authController.resetPassword();
                },
                title: 'Reset',
                width: getWidth(161),
                borderRadius: 4,
              ),
              SizedBox(height: getHeight(20)),
            ],
          ),
        ),
      ),
    );
  }
}
