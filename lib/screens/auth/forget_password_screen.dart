import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaosity_app/custom_widgets/custom_button.dart';
import 'package:kaosity_app/custom_widgets/custom_textfield.dart';
import 'package:kaosity_app/screens/auth/controller/auth_controller.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:kaosity_app/utils/app_images.dart';
import 'package:kaosity_app/utils/app_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final AuthController authController = Get.find();

  ForgetPasswordScreen({super.key});

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
                'Forgot Password?',
                style: AppStyles.whiteTextStyle()
                    .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: getHeight(12)),
              Text(
                'Enter your email we will send you password\nreset link.',
                textAlign: TextAlign.center,
                style: AppStyles.whiteTextStyle().copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: kGreyShade2Color),
              ),
              SizedBox(height: getHeight(35)),
              CustomTextField(
                controller: authController.emailForgetController,
                hintText: 'Email',
              ),
              SizedBox(height: getHeight(80)),
              CustomButton(
                height: 49,
                onTap: authController.forgotPassword,
                title: 'Recover',
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
