import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:kaosity_app/utils/app_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DontAgreeScreen extends StatelessWidget {
  const DontAgreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Please contact ',
                style: AppStyles.whiteTextStyle().copyWith(
                  fontSize: 16.sp,
                ),
              ),
              TextSpan(
                text: 'fans@kaosity.com',
                style: AppStyles.whiteTextStyle().copyWith(
                    fontSize: 16.sp,
                    color: kPrimaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: kPrimaryColor),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
              TextSpan(
                text: ' to\ncontinue.',
                style: AppStyles.whiteTextStyle().copyWith(
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
