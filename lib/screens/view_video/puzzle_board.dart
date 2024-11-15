import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaosity_app/custom_widgets/upper_case_formatters.dart';
import 'package:kaosity_app/screens/view_video/controller/view_video_controller.dart';
import 'package:kaosity_app/screens/view_video/overlay_message.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:kaosity_app/utils/app_images.dart';
import 'package:kaosity_app/utils/app_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PuzzleBoard extends StatelessWidget {
  final ViewVideoController controller = Get.find();

  PuzzleBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getWidth(14)),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: getHeight(20)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(19)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Solve the Puzzle",
                        style: AppStyles.whiteTextStyle().copyWith(
                            fontSize: 16.sp, fontWeight: FontWeight.w600)),
                    Obx(() {
                      if (controller.timeLeft.value <= 0 ||
                          controller.puzzleCompleted.value) {
                        FocusScope.of(context).unfocus();
                      }
                      return Text(
                        "${controller.timeLeft.value ~/ 60}:${(controller.timeLeft.value % 60).toString().padLeft(2, '0')}",
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
              ),
              SizedBox(height: getHeight(11)),
              Obx(() => Container(
                    width: getWidth(402),
                    padding: EdgeInsets.symmetric(
                        horizontal: getWidth(19), vertical: getHeight(9)),
                    decoration: BoxDecoration(
                      color: controller.timeLeft.value <= 10
                          ? kRedShade2Color
                          : kBgColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: buildPuzzleGrid(),
                  )),
              SizedBox(height: getHeight(20)),
              buildCluesSection(),
            ],
          ),
          Positioned(
            top: getHeight(55),
            left: 0,
            right: 0,
            child: Obx(() {
              if (controller.showSuccess.value) {
                return OverlayMessage(
                    title: "Great Job!",
                    subtitle:
                        "You completed the puzzle in ${controller.timeLeft.value ~/ 60}:${(controller.timeLeft.value % 60).toString().padLeft(2, '0')}!\nYou earned 100 Kaos Points!",
                    color: kGreenShade1Color.withOpacity(0.8),
                    child: Image.asset(
                      kPointsIcon,
                      height: getHeight(83),
                      width: getWidth(117),
                    ));
              } else if (controller.showFailure.value) {
                return OverlayMessage(
                    title: "Oh no!",
                    subtitle: "Time ran out!\nYou’ll get em’ next time.",
                    color: kRedShade2Color.withOpacity(0.85),
                    child: Image.asset(
                      kTimeIcon,
                      height: getHeight(77),
                      width: getWidth(77),
                    ));
              } else {
                return const SizedBox.shrink();
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget buildPuzzleGrid() {
    List<List<int?>> puzzleLayout = [
      [null, 1, null, 2, null, null, null, null, null],
      [null, 0, null, 0, null, 3, null, null, null],
      [4, 0, 0, 0, 0, 0, null, null, null],
      [null, null, null, 0, null, 0, null, null, null],
      [5, 0, 0, 0, null, 0, null, null, null],
      [null, null, null, 0, null, null, null, null, null],
      [null, null, null, 0, null, null, null, null, null],
      [null, null, 6, 0, 0, 0, 0, 0, 0],
      [null, null, null, 0, null, null, null, null, null],
    ];

    return Column(
      children: List.generate(puzzleLayout.length, (row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(puzzleLayout[row].length, (col) {
            final String key = "$row-$col";
            if (puzzleLayout[row][col] == null) {
              return Flexible(child: emptyCell());
            } else {
              if (!controller.textControllers.containsKey(key)) {
                controller.textControllers[key] = TextEditingController();
                controller.focusNodes[key] = FocusNode();
              }
              return editableCell(row, col, puzzleLayout[row][col]);
            }
          }),
        );
      }),
    );
  }

  Widget editableCell(int row, int col, int? clueNumber) {
    final String key = "$row-$col";
    final TextEditingController textController =
        controller.textControllers[key]!;
    final FocusNode focusNode = controller.focusNodes[key]!;

    return Obx(() {
      bool isFilled = controller.userAnswers.containsKey("$row-$col");
      return Container(
        width: getWidth(40),
        height: getHeight(37),
        margin: const EdgeInsets.all(0),
        decoration: BoxDecoration(
            color: kGreyShade6Color,
            border: Border.all(
                color: (!isFilled && controller.timeLeft.value <= 10)
                    ? kRedShade1Color
                    : kBgColor,
                width:
                    (!isFilled && controller.timeLeft.value <= 10) ? 1 : 0.66),
            borderRadius: BorderRadius.circular(3)),
        child: Stack(
          children: [
            if (clueNumber != 0)
              Positioned(
                top: 2,
                left: 2,
                child: Text(
                  '$clueNumber',
                  style: AppStyles.whiteTextStyle().copyWith(
                      fontSize: 10.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            Center(
              child: TextFormField(
                controller: textController,
                focusNode: focusNode,
                textAlign: TextAlign.center,
                cursorWidth: 1.0,
                cursorHeight: 16,
                onChanged: (value) {
                  controller.submitAnswer("$row-$col", value.toUpperCase());
                  if (value.isNotEmpty) {
                    FocusScope.of(focusNode.context!).nextFocus();
                  }
                },
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                style: AppStyles.whiteTextStyle().copyWith(
                    fontSize: 20.sp,
                    color: kBlackColor,
                    fontWeight: FontWeight.w700),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  counterText: "",
                ),
                maxLength: 1,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget emptyCell() {
    return Container(
      width: getWidth(40),
      height: getHeight(37),
      margin: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent, width: 0.66),
          borderRadius: BorderRadius.circular(3)),
    );
  }

  Widget buildCluesSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getWidth(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Puzzle Clues",
            style: AppStyles.whiteTextStyle()
                .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: getHeight(10)),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            crossAxisSpacing: getWidth(24),
            mainAxisSpacing: getHeight(10),
            childAspectRatio: 1.9,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              buildClueItem("1 Down:", "Who was on the phone?"),
              buildClueItem("2 Down:",
                  "The correct answer to the math problem in the elevator"),
              buildClueItem("3 Down:",
                  "VHS tape from the 80's on the pile and mentioned"),
              buildClueItem("4 Across:", "“A little bit of ______ came out”"),
              buildClueItem("5 Across:", "Lisa Kudrow’s high school name"),
              buildClueItem("6 Across:", "Lisa Kudrow in the reunion movie"),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildClueItem(String title, String description) {
    return SizedBox(
      height: getHeight(58),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.whiteTextStyle()
                .copyWith(color: kPrimaryColor, fontSize: 16.sp),
          ),
          Text(
            description,
            style: AppStyles.whiteTextStyle().copyWith(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
