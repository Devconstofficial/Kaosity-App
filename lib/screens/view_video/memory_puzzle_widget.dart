import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaosity_app/screens/view_video/controller/view_video_controller.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:kaosity_app/utils/app_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MemoryPuzzleWidget extends StatelessWidget {
  final ViewVideoController controller = Get.find();

  MemoryPuzzleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: getHeight(16)),
      width: double.infinity,
      decoration: BoxDecoration(color: kBlackShade1Color.withOpacity(0.97)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: getWidth(18), vertical: getHeight(16)),
        color: kBlackColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Text(
                      controller.isUserTurn.value
                          ? "Round ${controller.roundNumber.value} of 3"
                          : 'Memory Puzzle',
                      style: AppStyles.whiteTextStyle().copyWith(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    )),
                Obx(() {
                  return Text(
                    "${controller.puzzleTimer.value ~/ 60}:${(controller.puzzleTimer.value % 60).toString().padLeft(2, '0')}",
                    style: AppStyles.whiteTextStyle().copyWith(
                      color: controller.timeLeft.value <= 10
                          ? kRedShade1Color
                          : kPrimaryColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }),
              ],
            ),
            SizedBox(height: getHeight(23)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return GestureDetector(
                  onTap: () {
                    if (controller.isUserTurn.value) {
                      controller.submitTile(index);
                    }
                  },
                  child: Obx(() {
                    bool isTapped = controller.userSequence.contains(index);
                    bool isHighlighted =
                        controller.highlightedTile.value == index;

                    bool showBorder = !controller.isUserTurn.value &&
                        controller.memorySequence.length > index &&
                        controller.userSequence.length ==
                            controller.memorySequence.length;

                    return Container(
                      width: getWidth(90),
                      height: getHeight(78),
                      margin: EdgeInsets.symmetric(horizontal: getWidth(4)),
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: isTapped || isHighlighted
                              ? controller.tileColors[index]
                              : [kGreyShade10Color, kGreyShade11Color],
                          radius: 0.3,
                        ),
                        border: showBorder
                            ? Border.all(
                                color: controller.memorySequence[index] ==
                                        controller.userSequence[index]
                                    ? kGreenColor
                                    : kRedColor,
                                width: 2,
                              )
                            : null,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
