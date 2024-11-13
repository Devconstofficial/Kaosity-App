import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaosity_app/screens/view_video/challenge_section.dart';
import 'package:kaosity_app/screens/view_video/comment_list.dart';
import 'package:kaosity_app/screens/view_video/controller/view_video_controller.dart';
import 'package:kaosity_app/screens/view_video/puzzle_board.dart';
import 'package:kaosity_app/screens/view_video/puzzle_section.dart';
import 'package:kaosity_app/screens/view_video/video_player_widget.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:kaosity_app/utils/app_images.dart';
import 'package:kaosity_app/utils/app_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:video_player/video_player.dart';

class ViewVideoScreen extends StatelessWidget {
  final ViewVideoController controller = Get.find();

  ViewVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: SafeArea(
        child: Obx(
          () => controller.isExpanded.value
              ? Stack(
                  children: [
                    Column(
                      children: [
                        ChallengeSection(),
                        Obx(() => controller.isPuzzleActive.value
                            ? Expanded(
                                child:
                                    SingleChildScrollView(child: PuzzleBoard()))
                            : const SizedBox.shrink()),
                        Obx(() {
                          if (controller.showSuccess.value) {
                            return buildOverlayMessage(
                                "Great Job!",
                                "You completed the puzzle in ${controller.timeLeft.value ~/ 60}:${(controller.timeLeft.value % 60).toString().padLeft(2, '0')}!\nYou earned 100 Kaos Points!",
                                kGreenShade1Color.withOpacity(0.8),
                                Image.asset(
                                  kPointsIcon,
                                  height: getHeight(83),
                                  width: getWidth(117),
                                ));
                          } else if (controller.showFailure.value) {
                            return buildOverlayMessage(
                                "Oh no!",
                                "Time ran out!\nYou’ll get em’ next time.",
                                kRedShade2Color.withOpacity(0.85),
                                Image.asset(
                                  kTimeIcon,
                                  height: getHeight(77),
                                  width: getWidth(77),
                                ));
                          } else {
                            return const SizedBox.shrink();
                          }
                        }),
                      ],
                    ),
                    Positioned(
                      bottom: getHeight(56),
                      right: getWidth(18),
                      child: SizedBox(
                        height: getHeight(81),
                        width: getWidth(150),
                        child: AspectRatio(
                          aspectRatio:
                              controller.videoController.value.aspectRatio,
                          child: VideoPlayer(controller.videoController),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    VideoPlayerWidget(),
                    Obx(
                      () => controller.showPuzzleStart.value
                          ? PuzzleSection()
                          : ChallengeSection(),
                    ),
                    Obx(() => controller.isPuzzleActive.value
                        ? Expanded(
                            child: SingleChildScrollView(child: PuzzleBoard()))
                        : const SizedBox.shrink()),
                    SizedBox(height: getHeight(23)),
                    Obx(() {
                      if (controller.showSuccess.value) {
                        return buildOverlayMessage(
                            "Great Job!",
                            "You completed the puzzle in ${controller.timeLeft.value ~/ 60}:${(controller.timeLeft.value % 60).toString().padLeft(2, '0')}!\nYou earned 100 Kaos Points!",
                            kGreenShade1Color.withOpacity(0.8),
                            Image.asset(
                              kPointsIcon,
                              height: getHeight(83),
                              width: getWidth(117),
                            ));
                      } else if (controller.showFailure.value) {
                        return buildOverlayMessage(
                            "Oh no!",
                            "Time ran out!\nYou’ll get em’ next time.",
                            kRedShade2Color.withOpacity(0.85),
                            Image.asset(
                              kTimeIcon,
                              height: getHeight(77),
                              width: getWidth(77),
                            ));
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                    Obx(() => controller.isPuzzleActive.value
                        ? SizedBox(
                            height: getHeight(180),
                            child: CommentList(),
                          )
                        : Expanded(child: CommentList())),
                    SizedBox(height: getHeight(26)),
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildOverlayMessage(
      String title, String subtitle, Color color, Widget child) {
    return Center(
      child: Container(
        width: getWidth(363),
        height: getHeight(340),
        margin: EdgeInsets.only(bottom: getHeight(16)),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: AppStyles.whiteTextStyle()
                    .copyWith(fontSize: 22.sp, fontWeight: FontWeight.w700)),
            SizedBox(height: getHeight(18)),
            Text(subtitle,
                textAlign: TextAlign.center,
                style: AppStyles.whiteTextStyle().copyWith(fontSize: 16.sp)),
            SizedBox(height: getHeight(31)),
            child,
          ],
        ),
      ),
    );
  }
}
