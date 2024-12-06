import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kaosity_app/custom_widgets/custom_button.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:kaosity_app/utils/app_strings.dart';
import 'package:kaosity_app/utils/app_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: kBgColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getWidth(40),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Disclaimer',
              style: AppStyles.whiteTextStyle().copyWith(
                fontSize: 22.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: getHeight(20)),
            Text(
              'The images and video content featured in this application are not licensed, original, or produced by Kaosity and does not involve the company in any capacity. It is included solely for the purpose of demonstrating the features and potential in this prototype.\n\n'
              'This prototype is for invite-only use, intended exclusively for beta testing and evaluation. All features, technology, and content are limited and subject to change. The public Kaosity app will include exclusively original content at that time.\n\n'
              'By proceeding, you acknowledge and agree to the terms outlined above and understand the current scope and purpose of this application.',
              style: AppStyles.whiteTextStyle().copyWith(
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: getHeight(23)),
            CustomButton(
              onTap: () {
                Get.offAllNamed(kLoginScreenRoute);
              },
              title: 'I Agree',
            ),
            SizedBox(height: getHeight(11)),
            CustomButton(
              onTap: () {
                Get.toNamed(kDontAgreeScreenRoute);
              },
              title: 'I Do Not Agree',
              color: Colors.transparent,
              textColor: kGreyShadeColor,
              width: getWidth(117),
              textSize: 14,
            ),
          ],
        ),
      ),
    );
  }
}
