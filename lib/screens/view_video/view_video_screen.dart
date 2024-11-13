import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kaosity_app/screens/view_video/audience_progress.dart';
import 'package:kaosity_app/screens/view_video/challenge_section.dart';
import 'package:kaosity_app/screens/view_video/comment_list.dart';
import 'package:kaosity_app/screens/view_video/controller/view_video_controller.dart';
import 'package:kaosity_app/screens/view_video/puzzle_board.dart';
import 'package:kaosity_app/screens/view_video/puzzle_section.dart';
import 'package:kaosity_app/screens/view_video/video_player_widget.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:kaosity_app/utils/app_styles.dart';
import 'package:video_player/video_player.dart';

class ViewVideoScreen extends StatelessWidget {
  final ViewVideoController controller = Get.find();

  ViewVideoScreen({super.key});

  Future<bool> _onWillPop() async {
    if (controller.isFullScreen.value) {
      controller.toggleFullScreen();
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: kBgColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Obx(
            () => controller.isFullScreen.value
                ? VideoPlayerWidget()
                : controller.isExpanded.value
                    ? Stack(
                        children: [
                          Column(
                            children: [
                              ChallengeSection(),
                              Obx(() => controller.isPuzzleActive.value
                                  ? Expanded(
                                      child: SingleChildScrollView(
                                          child: PuzzleBoard()))
                                  : const SizedBox.shrink()),
                              Obx(() => controller.showProgress.value
                                  ? const AudienceProgress()
                                  : const SizedBox.shrink()),
                            ],
                          ),
                          Positioned(
                            bottom: getHeight(56),
                            right: getWidth(18),
                            child: SizedBox(
                              height: getHeight(81),
                              width: getWidth(150),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  AspectRatio(
                                    aspectRatio: controller
                                        .videoController.value.aspectRatio,
                                    child:
                                        VideoPlayer(controller.videoController),
                                  ),
                                  InkWell(
                                    onTap: controller.togglePlayPause,
                                    child: Icon(
                                      controller.isPlaying.value
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      color: controller.isPlaying.value
                                          ? kWhiteColor.withOpacity(0.3)
                                          : kWhiteColor,
                                    ),
                                  ),
                                ],
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
                                  child: SingleChildScrollView(
                                      child: PuzzleBoard()))
                              : const SizedBox.shrink()),
                          Obx(() => controller.showProgress.value
                              ? const AudienceProgress()
                              : const SizedBox.shrink()),
                          SizedBox(height: getHeight(23)),
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
      ),
    );
  }
}
