import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaosity_app/custom_widgets/custom_button.dart';
import 'package:kaosity_app/screens/view_video/controller/view_video_controller.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:kaosity_app/utils/app_images.dart';
import 'package:kaosity_app/utils/app_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PuzzleSection extends StatelessWidget {
  final ViewVideoController controller = Get.find();

  PuzzleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getWidth(33)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: getHeight(24)),
          Text("Solve the Puzzle",
              style: AppStyles.whiteTextStyle()
                  .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600)),
          SizedBox(height: getHeight(11)),
          Container(
            width: getWidth(363),
            padding: EdgeInsets.symmetric(horizontal: getWidth(43)),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: getHeight(15)),
                Image.asset(
                  kLogoMarkIcon,
                  height: getHeight(59),
                  width: getWidth(59),
                ),
                Text("A Puzzle is Starting",
                    style: AppStyles.whiteTextStyle().copyWith(
                        fontSize: 20.sp, fontWeight: FontWeight.w700)),
                SizedBox(height: getHeight(20)),
                Text(
                    "Be a part of the show and complete a puzzle! Earn points to effect the outcome of the scenario.",
                    textAlign: TextAlign.center,
                    style: AppStyles.whiteTextStyle().copyWith(
                        fontSize: 16.sp, fontWeight: FontWeight.w400)),
                SizedBox(height: getHeight(23)),
                CustomButton(
                  height: 46,
                  width: 147,
                  color: kBgColor,
                  borderRadius: 4,
                  title: 'Start Puzzle',
                  onTap: () {
                    if (controller.showMemoryPuzzleStart.value) {
                      controller.showMemoryPuzzleStart.value = false;
                      controller.showThirdPuzzle.value = true;

                      controller.startMemoryPuzzle();
                    } else {
                      controller.togglePuzzle();
                    }
                  },
                  textSize: 17,
                ),
                SizedBox(height: getHeight(2)),
                CustomButton(
                  height: 40,
                  width: 66,
                  title: 'Skip',
                  textColor: kBgColor,
                  onTap: () {
                    controller.isChallengeActive.value = false;
                    controller.showPuzzleStart.value = false;
                    Future.delayed(const Duration(seconds: 2), () {
                      controller.isChallengeActive.value = true;
                    });
                  },
                ),
                SizedBox(height: getHeight(20)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
