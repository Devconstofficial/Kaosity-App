import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'app_colors.dart';

class AppStyles {
  static TextStyle greyTextStyle() => GoogleFonts.poppins(
      fontSize: 15.sp, fontWeight: FontWeight.w500, color: kGreyColor);
  static TextStyle primaryTextStyle() => GoogleFonts.poppins(
      fontSize: 15.sp, fontWeight: FontWeight.w400, color: kPrimaryColor);
  static TextStyle whiteTextStyle() => GoogleFonts.poppins(
      fontSize: 15.sp, fontWeight: FontWeight.w500, color: kWhiteColor);
  static TextStyle blackTextStyle() => GoogleFonts.poppins(
      fontSize: 15.sp, fontWeight: FontWeight.w500, color: kBlackColor);
}

double getWidth(double pixelValue) {
  double baseScreenWidth = 430.0;
  return (pixelValue / baseScreenWidth) * 100.w;
}

double getHeight(double pixelValue) {
  double baseScreenHeight = 957.0;
  return (pixelValue / baseScreenHeight) * 100.h;
}
