import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaosity_app/custom_widgets/upper_case_formatters.dart';
import 'package:kaosity_app/screens/view_video/controller/view_video_controller.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:kaosity_app/utils/app_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PuzzleBoard extends StatelessWidget {
  final ViewVideoController controller = Get.find();

  PuzzleBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getWidth(14)),
      child: Column(
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
                Obx(() => Text(
                      "${controller.timeLeft.value ~/ 60}:${(controller.timeLeft.value % 60).toString().padLeft(2, '0')}",
                      style: AppStyles.whiteTextStyle().copyWith(
                        color: controller.timeLeft.value <= 10
                            ? kRedShade1Color
                            : kPrimaryColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(height: getHeight(11)),
          Container(
            width: getWidth(402),
            padding: EdgeInsets.symmetric(
                horizontal: getWidth(21), vertical: getHeight(9)),
            decoration: BoxDecoration(
              color: kBgColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: buildPuzzleGrid(),
          ),
          SizedBox(height: getHeight(20)),
          buildCluesSection(),
        ],
      ),
    );
  }

  Widget buildPuzzleGrid() {
    List<List<int?>> puzzleLayout = [
      [1, 0, 0, 0, 2, null, null],
      [null, null, null, null, 0, null, null],
      [null, 3, 0, 0, 0, null, null],
      [null, null, 4, 0, 0, 0, null],
      [5, 0, 0, 0, 0, 0, null],
      [null, null, 6, 0, 0, null, null],
    ];

    return Column(
      children: List.generate(puzzleLayout.length, (row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(puzzleLayout[row].length, (col) {
            if (puzzleLayout[row][col] == null) {
              return emptyCell();
            } else {
              return editableCell(row, col, puzzleLayout[row][col]);
            }
          }),
        );
      }),
    );
  }

  Widget editableCell(int row, int col, int? clueNumber) {
    bool isFilled = controller.userAnswers.containsKey("$row-$col");
    print("Building editableCell at row: $row, col: $col");
    return Obx(() => Container(
          width: getWidth(40),
          height: getHeight(37.26),
          margin: const EdgeInsets.all(0.1),
          decoration: BoxDecoration(
              color: kGreyShade6Color,
              border: Border.all(
                  color: (controller.timeLeft.value <= 10 && !isFilled)
                      ? kRedShade1Color
                      : kBgColor,
                  width: (controller.timeLeft.value <= 10 && !isFilled)
                      ? 1.5
                      : 0.66),
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
                  textAlign: TextAlign.center,
                  cursorWidth: 1.0,
                  cursorHeight: 16,
                  onChanged: (value) {
                    print(
                        'TextFormField onChanged triggered with value: $value');
                    controller.submitAnswer("$row-$col", value.toUpperCase());
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
        ));
  }

  Widget emptyCell() {
    return Container(
      width: getWidth(40),
      height: getHeight(37.26),
      margin: const EdgeInsets.all(0.1),
      color: Colors.transparent,
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
