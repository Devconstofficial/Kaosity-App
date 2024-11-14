import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaosity_app/screens/view_video/controller/view_video_controller.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:kaosity_app/utils/app_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AudienceProgress extends StatefulWidget {
  const AudienceProgress({
    super.key,
  });

  @override
  _AudienceProgressState createState() => _AudienceProgressState();
}

class _AudienceProgressState extends State<AudienceProgress> {
  final ViewVideoController controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (controller.timeLeft.value != 0) {
      controller.runRemainingTimer();
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getHeight(8)),
        Obx(() => Text(
            controller.timeLeft.value == 0 ? "Success" : "Audience Progress",
            style: AppStyles.whiteTextStyle()
                .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600))),
        SizedBox(height: getHeight(10)),
        Obx(() => controller.timeLeft.value == 0
            ? Center(
                child: FilledContainer(totalValue: 1000, filledValue: 1000))
            : FilledContainer(totalValue: 1000, filledValue: 648)),
        SizedBox(height: getHeight(7)),
        Text("Points Earned",
            style: AppStyles.whiteTextStyle().copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: kGreenShade2Color)),
        SizedBox(height: getHeight(10)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(83)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Time Remaining",
                  style: AppStyles.whiteTextStyle().copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: kWhiteColor.withOpacity(0.5))),
              Obx(() => Text(
                    "${controller.timeLeft.value ~/ 60}:${(controller.timeLeft.value % 60).toString().padLeft(2, '0')}",
                    style: AppStyles.whiteTextStyle().copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: kWhiteColor.withOpacity(0.5)),
                  )),
            ],
          ),
        ),
        if (controller.timeLeft.value == 0) ...[
          SizedBox(height: getHeight(15)),
          Container(
            width: getWidth(402),
            height: getHeight(38),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: kPrimaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Everyone Won ",
                    style: AppStyles.whiteTextStyle().copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    )),
                Text(" +100 Kaos Points",
                    style: AppStyles.whiteTextStyle().copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    )),
              ],
            ),
          ),
        ]
      ],
    );
  }
}

class FilledContainer extends StatelessWidget {
  final double totalValue;
  final double filledValue;

  FilledContainer(
      {Key? key, required this.totalValue, required this.filledValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fraction = filledValue / totalValue;

    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          width: getWidth(282),
          height: getHeight(30),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: getWidth(10)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: kBlackShade4Color,
          ),
          child: Text(totalValue.toStringAsFixed(0),
              style: AppStyles.whiteTextStyle().copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: kWhiteColor.withOpacity(0.5))),
        ),
        Container(
          width: getWidth(282) * fraction,
          height: getHeight(30),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: getWidth(10)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: kGreenShade2Color,
          ),
          child: Text(filledValue.toStringAsFixed(0),
              style: AppStyles.whiteTextStyle().copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: kBgColor)),
        )
      ],
    );
  }
}
