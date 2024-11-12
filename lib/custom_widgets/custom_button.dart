import 'package:flutter/material.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../utils/app_styles.dart';

class CustomButton extends StatelessWidget {
  final double borderRadius;
  final String title;
  final Color textColor;
  final Color color;
  final double width;
  final double height;
  final double textSize;
  final Function()? onTap;
  final bool showShadow;
  final Color? borderColor;
  final String? icon;

  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.textColor = kWhiteColor,
    this.color = kPrimaryColor,
    this.width = 94,
    this.height = 40,
    this.borderRadius = 16,
    this.textSize = 15,
    this.showShadow = false,
    this.borderColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: getHeight(height),
        width: getWidth(width),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderColor ?? Colors.transparent),
            boxShadow: [
              showShadow
                  ? BoxShadow(
                      color: kPrimaryColor.withOpacity(0.25),
                      offset: const Offset(0, 10),
                      blurRadius: 9,
                      spreadRadius: 0)
                  : const BoxShadow(color: Colors.transparent),
            ]),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Image.asset(
                  icon!,
                  height: getHeight(25),
                  width: getWidth(25),
                ),
                SizedBox(width: getWidth(8)),
              ],
              Text(
                title,
                style: AppStyles.whiteTextStyle()
                    .copyWith(fontSize: textSize.sp, color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
