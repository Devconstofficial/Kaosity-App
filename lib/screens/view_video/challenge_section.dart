import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaosity_app/screens/view_video/controller/view_video_controller.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:kaosity_app/utils/app_images.dart';
import 'package:kaosity_app/utils/app_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChallengeSection extends StatelessWidget {
  final ViewVideoController controller = Get.find();

  ChallengeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!controller.isEnabled.value ||
                !controller.showThirdPuzzle.value) ...[
              SizedBox(height: getHeight(12)),
              Text("Escape Room",
                  style: AppStyles.whiteTextStyle()
                      .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700)),
              Text("S1 - Ep 4",
                  style: AppStyles.whiteTextStyle().copyWith(fontSize: 15.sp)),
              SizedBox(height: getHeight(4)),
              Text(
                  "Four celebrities take on the escape room with the help of viewers across the nation.",
                  style: AppStyles.whiteTextStyle()
                      .copyWith(fontSize: 14.sp, color: kGreyShade2Color)),
            ],
            !controller.showThirdPuzzle.value
                ? SizedBox(height: getHeight(15))
                : const SizedBox.shrink(),
            !controller.showThirdPuzzle.value
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Challenges",
                          style: AppStyles.whiteTextStyle()
                              .copyWith(fontSize: 16.sp)),
                      if (controller.isChallengeActive.value)
                        GestureDetector(
                          onTap: () {
                            controller.isExpanded.value =
                                !controller.isExpanded.value;
                          },
                          child: Image.asset(
                            kArrowsIcon,
                            height: getHeight(18),
                            width: getWidth(18),
                          ),
                        )
                    ],
                  )
                : const SizedBox.shrink(),
            !controller.showThirdPuzzle.value
                ? SizedBox(height: getHeight(6))
                : const SizedBox.shrink(),
            !controller.showThirdPuzzle.value
                ? Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // if (controller.isChallengeActive.value) {
                          //   controller.showPuzzleStart.value = true;
                          // }
                        },
                        child: Container(
                          height: getHeight(28),
                          width: getWidth(64),
                          decoration: BoxDecoration(
                              color: controller.isChallengeActive.value
                                  ? kPrimaryColor
                                  : (controller.isEnabled.value
                                      ? kBlackShade3Color
                                      : kBlackShade2Color),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Image.asset(
                              kPuzzleIcon,
                              height: getHeight(18),
                              width: getWidth(18),
                              color: controller.isEnabled.value
                                  ? Colors.white
                                  : null,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: getWidth(12)),
                      Container(
                        height: getHeight(28),
                        width: getWidth(64),
                        decoration: BoxDecoration(
                            color: kBlackShade2Color,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Image.asset(
                            controller.isChallengeActive.value
                                ? kWorldIcon
                                : kVoteIcon,
                            height: getHeight(18),
                            width: getWidth(31),
                          ),
                        ),
                      ),
                      SizedBox(width: getWidth(12)),
                      Container(
                        height: getHeight(28),
                        width: getWidth(64),
                        decoration: BoxDecoration(
                            color: kBlackShade2Color,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Image.asset(
                            kPaintIcon,
                            height: getHeight(18),
                            width: getWidth(18),
                            color: controller.isChallengeActive.value
                                ? kWhiteColor
                                : null,
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ],
        ),
      );
    });
  }
}
