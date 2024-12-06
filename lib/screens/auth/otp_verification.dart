import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaosity_app/custom_widgets/custom_button.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:kaosity_app/utils/app_styles.dart';
import 'package:kaosity_app/utils/app_images.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'controller/auth_controller.dart';

class OtpVerification extends StatelessWidget {
  final AuthController authController = Get.find();

  OtpVerification({super.key});

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
                'OTP Verification',
                style: AppStyles.whiteTextStyle()
                    .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: getHeight(12)),
              Text(
                'Please enter the 4-digit code sent to\nyour email address,',
                textAlign: TextAlign.center,
                style: AppStyles.whiteTextStyle().copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: kGreyShade2Color),
              ),
              SizedBox(height: getHeight(35)),
              PinCodeTextField(
                appContext: context,
                length: 4,
                onChanged: (value) {
                  authController.otp.value = value; 
                },
                keyboardType: TextInputType.number,
                textStyle: AppStyles.whiteTextStyle().copyWith(fontSize: 18.sp),
                pinTheme: PinTheme(
                  activeColor: kWhiteColor,
                  selectedColor: kGreyShade2Color,
                  inactiveColor: kGreyShade2Color,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: getHeight(50),
                  fieldWidth: getWidth(50),
                ),
              ),
               SizedBox(height: getHeight(80)),
              CustomButton(
                height: 49,
                onTap: (){
                  authController.verifyOtp();
                },
                title: 'Verify',
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
