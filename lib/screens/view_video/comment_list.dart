import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaosity_app/screens/view_video/controller/view_video_controller.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:kaosity_app/utils/app_images.dart';
import 'package:kaosity_app/utils/app_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CommentList extends StatelessWidget {
  final ViewVideoController controller = Get.find();

  CommentList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.comments.length,
              itemBuilder: (context, index) {
                final comment = controller.comments[index];
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: getHeight(10),
                      left: getWidth(17),
                      right: getWidth(34)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        comment.icon,
                        height: getHeight(20),
                        width: getWidth(22),
                      ),
                      SizedBox(width: getWidth(6)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${comment.username}: ",
                                    style: AppStyles.whiteTextStyle().copyWith(
                                        fontSize: 15.sp,
                                        color: comment.nameColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: comment.message,
                                    style: AppStyles.whiteTextStyle().copyWith(
                                        fontSize: 13.sp,
                                        color: kGreyShade4Color),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(15)),
          child: Row(
            children: [
              CircleAvatar(
                radius: 15.sp,
                backgroundColor: kGreyShade4Color,
              ),
              SizedBox(width: getWidth(13)),
              Expanded(
                child: TextField(
                  controller: controller.commentController,
                  style: AppStyles.whiteTextStyle().copyWith(fontSize: 16.sp),
                  decoration: InputDecoration(
                      hintText: "Send a message...",
                      hintStyle: AppStyles.whiteTextStyle()
                          .copyWith(color: kGreyShade5Color, fontSize: 14.sp),
                      border: InputBorder.none),
                ),
              ),
              SizedBox(width: getWidth(5)),
              InkWell(
                onTap: () {
                  controller.addComment();
                },
                child: Image.asset(
                  kSendIcon,
                  height: getHeight(18),
                  width: getWidth(18),
                ),
              ),
              SizedBox(width: getWidth(23)),
              Image.asset(
                kMoreIcon,
                height: getHeight(26),
                width: getWidth(6),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
