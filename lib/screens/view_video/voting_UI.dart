import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kaosity_app/screens/home/video_services/video_services.dart';
import 'package:kaosity_app/screens/view_video/controller/view_video_controller.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:kaosity_app/utils/app_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VotingUI extends StatelessWidget {
  final ViewVideoController controller = Get.find();

  VotingUI({super.key});

  @override
  Widget build(BuildContext context) {
    final VideoService service = VideoService();
    return Container(
      height: getHeight(169),
      width: double.infinity,
      decoration: const BoxDecoration(color: kBlackColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(18)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Vote on Who Stays Next Week",
                  style: AppStyles.whiteTextStyle()
                      .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                Obx(() => Text(
                      "${controller.votingTimer.value ~/ 60}:${(controller.votingTimer.value % 60).toString().padLeft(2, '0')}",
                      style: AppStyles.whiteTextStyle().copyWith(
                        color: controller.votingTimer.value <= 10
                            ? kRedShade1Color
                            : kPrimaryColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(height: getHeight(8)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(18)),
            child: const Divider(
              height: 0,
              color: kGreyShade4Color,
            ),
          ),
          SizedBox(height: getHeight(8)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: getWidth(18)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: controller.votingOptions.map((option) {
                return GestureDetector(
                  onTap: () {
                    controller.voteForOption(option);
                    final String videoId = GetStorage().read('videoId');
                    final user =GetStorage().read<Map<String, dynamic>?>('user');
                    final String participantId = user!['_id'];
                    service.voteParticipant(videoId, participantId);
                  },
                  child: Obx(() => Container(
                        height: getHeight(110),
                        width: getWidth(160),
                        margin: EdgeInsets.only(right: getWidth(8)),
                        decoration: BoxDecoration(
                            color: kBlackShade1Color,
                            border: Border.all(
                              color: option.isSelected.value
                                  ? kGreenShade2Color
                                  : Colors.transparent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(4)),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: getWidth(160),
                                  height: getHeight(84),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(3),
                                        topRight: Radius.circular(3)),
                                    image: DecorationImage(
                                        image: AssetImage(
                                          option.image,
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                option.isSelected.value
                                    ? Container(
                                        width: getWidth(160),
                                        height: getHeight(84),
                                        decoration: BoxDecoration(
                                          color: option.isSelected.value
                                              ? kGreenShade5Color
                                                  .withOpacity(0.4)
                                              : null,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(3),
                                              topRight: Radius.circular(3)),
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: getWidth(24),
                                            height: getHeight(24),
                                            decoration: const BoxDecoration(
                                                color: kBgColor,
                                                shape: BoxShape.circle),
                                            child: Center(
                                              child: Icon(
                                                Icons.check,
                                                color: kGreenShade2Color,
                                                size: 17.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                            SizedBox(height: getHeight(1)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  option.name,
                                  style: AppStyles.whiteTextStyle().copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text("- ${option.percentage.value}%",
                                    style: AppStyles.whiteTextStyle().copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: kWhiteColor.withOpacity(0.7))),
                              ],
                            ),
                          ],
                        ),
                      )),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class VotingResults extends StatelessWidget {
  final ViewVideoController controller = Get.find();

  VotingResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          color: kBlackColor,
          padding: EdgeInsets.symmetric(horizontal: getWidth(35)),
          margin: EdgeInsets.only(top: getHeight(3)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getHeight(4)),
              Center(
                child: Text(
                  "Poll Results",
                  style: AppStyles.whiteTextStyle().copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: getHeight(18)),
              Obx(() {
                int maxPercentage = controller.votingOptions
                    .map((option) => option.percentage.value)
                    .reduce((a, b) => a > b ? a : b);
                return Wrap(
                  spacing: getWidth(20),
                  runSpacing: getHeight(10),
                  children: controller.votingOptions.map((option) {
                    return SizedBox(
                      width: getWidth(150),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  height: getHeight(4),
                                  margin: EdgeInsets.only(right: getWidth(15)),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: FractionallySizedBox(
                                    widthFactor: option.percentage.value / 100,
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: option.percentage.value ==
                                                maxPercentage
                                            ? kGreenShade2Color
                                            : kBlackShade6Color,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "${option.percentage.value}%",
                                style: AppStyles.whiteTextStyle().copyWith(
                                    fontSize: 14.sp, color: kGreyShade9Color),
                              ),
                            ],
                          ),
                          SizedBox(height: getHeight(3)),
                          Text(
                            option.name,
                            style: AppStyles.whiteTextStyle()
                                .copyWith(fontSize: 14.sp),
                          ),
                          SizedBox(height: getHeight(6)),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }),
            ],
          ),
        ),
        SizedBox(height: getHeight(9)),
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
      ],
    );
  }
}
