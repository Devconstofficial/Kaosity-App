import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaosity_app/screens/view_video/controller/view_video_controller.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:kaosity_app/utils/app_images.dart';
import 'package:kaosity_app/utils/app_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  final ViewVideoController controller = Get.find();

  VideoPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final currentPosition = controller.currentPosition.value;
      final duration = controller.videoController.value.duration;
      return Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: controller.isFullScreen.value
                ? double.infinity
                : getHeight(232),
            width: double.infinity,
            child: AspectRatio(
              aspectRatio: controller.videoController.value.aspectRatio,
              child: VideoPlayer(controller.videoController),
            ),
          ),
          // Positioned(
          //   top: getHeight(7),
          //   left: getWidth(14),
          //   child: Container(
          //     height: getHeight(18),
          //     width: getWidth(41),
          //     decoration: BoxDecoration(
          //       color: kRedColor,
          //       borderRadius: BorderRadius.circular(3),
          //     ),
          //     child: Center(
          //       child: Text(
          //         'LIVE',
          //         style: AppStyles.whiteTextStyle()
          //             .copyWith(fontWeight: FontWeight.w700, fontSize: 13.sp),
          //       ),
          //     ),
          //   ),
          // ),
          !controller.isFullScreen.value
              ? Positioned(
                  top: getHeight(11),
                  right: getWidth(17),
                  child: InkWell(
                    onTap: () {
                      controller.toggleVideoSize();
                    },
                    child: Icon(Icons.keyboard_arrow_down,
                        color: kWhiteColor, size: 20.sp),
                  ),
                )
              : const SizedBox.shrink(),
          Positioned(
            bottom: getHeight(14),
            left: getWidth(22),
            right: getWidth(60),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                VideoProgressIndicator(
                  controller.videoController,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    playedColor: kGreyColor.withOpacity(0.5),
                    bufferedColor: kGreyShade3Color,
                    backgroundColor: kGreyShade3Color,
                  ),
                ),
                SizedBox(height: getHeight(13)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: controller.togglePlayPause,
                      child: Icon(
                        controller.isPlaying.value
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: getWidth(10)),
                    Text(
                      '${currentPosition.inMinutes.remainder(60).toString().padLeft(2, '0')}:${currentPosition.inSeconds.remainder(60).toString().padLeft(2, '0')} / '
                      '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                      style: AppStyles.whiteTextStyle().copyWith(
                          fontSize: 12.sp, fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        controller.toggleFullScreen();
                      },
                      child: Image.asset(
                        kArrowsIcon,
                        height:
                            getHeight(controller.isFullScreen.value ? 30 : 12),
                        width: getWidth(16),
                        color: kWhiteColor,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          (controller.isChallengeActive.value && !controller.isFullScreen.value)
              ? Positioned(
                  bottom: getHeight(75),
                  right: 0,
                  child: Container(
                    height: getHeight(27),
                    width: getWidth(143),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            kPrimaryColor.withOpacity(0.22),
                            kPurpleColor.withOpacity(0.9),
                            kBlackColor.withOpacity(0.3)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(4),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          kLogoMarkIcon,
                          height: getHeight(21),
                          width: getWidth(21),
                        ),
                        SizedBox(width: getWidth(6)),
                        Text(
                          'Challenge Active',
                          style: AppStyles.whiteTextStyle().copyWith(
                              fontSize: 12.sp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ))
              : const SizedBox.shrink()
        ],
      );
    });
  }
}
