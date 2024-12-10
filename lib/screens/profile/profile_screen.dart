import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaosity_app/models/content_section_model.dart';
import 'package:kaosity_app/screens/profile/controller/profile_controller.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:kaosity_app/utils/app_images.dart';
import 'package:kaosity_app/utils/app_strings.dart';
import 'package:kaosity_app/utils/app_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.find();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        backgroundColor: kBgColor,
        surfaceTintColor: kBgColor,
        automaticallyImplyLeading: false,
        title: Image.asset(
          kLogo,
          height: getHeight(36),
          width: getWidth(193),
        ),
        actions: [
          Image.asset(
            kSearchIcon,
            height: getHeight(24),
            width: getWidth(24),
          ),
          SizedBox(width: getWidth(19)),
          GestureDetector(
            onTap: controller.toggleMenu,
            child: Image.asset(
              kMenuIcon,
              height: getHeight(32),
              width: getWidth(32),
            ),
          ),
          SizedBox(width: getWidth(14)),
        ],
      ),
      body: Stack(
        children: [
          Obx(() {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(height: getHeight(9)),
                buildProfile(),
                SizedBox(height: getHeight(19)),
                buildPoints(),
                SizedBox(height: getHeight(11)),
                buildRareAchievement(controller.rareAchievement.value),
                SizedBox(height: getHeight(19)),
                ...controller.allAchievements
                    .map((section) => buildSection(section))
                    ,
              ],
            );
          }),
          Obx(() => Positioned(
                top: getHeight(10),
                left: 0,
                right: 0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: controller.isMenuVisible.value ? getHeight(150) : 0,
                  color: kBgColor,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.isMenuVisible.value = false;
                          Get.toNamed(kHomeScreenRoute);
                        },
                        child: Text(
                          'Home',
                          style: AppStyles.whiteTextStyle()
                              .copyWith(fontSize: 16.sp),
                        ),
                      ),
                      SizedBox(height: getHeight(18)),
                      InkWell(
                        onTap: () {
                          controller.isMenuVisible.value = false;
                          Get.toNamed(kProfileScreenRoute);
                        },
                        child: Text(
                          'Profile',
                          style: AppStyles.whiteTextStyle()
                              .copyWith(fontSize: 16.sp),
                        ),
                      ),
                      SizedBox(height: getHeight(18)),
                      Text(
                        'Setting',
                        style: AppStyles.whiteTextStyle()
                            .copyWith(fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget buildProfile() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: getWidth(38),
        top: getHeight(17),
        right: getWidth(40),
        bottom: getHeight(28),
      ),
      decoration: BoxDecoration(
          color: kBlackShade5Color, borderRadius: BorderRadius.circular(4)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(kAvatar),
          ),
          SizedBox(width: getWidth(19)),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Image.asset(
                    kStatus1Icon,
                    height: getHeight(20),
                    width: getWidth(22),
                  ),
                  SizedBox(width: getWidth(8)),
                  Text(
                    'Gus Gaston',
                    style: AppStyles.whiteTextStyle().copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: getHeight(4)),
              Text(
                'Primetime Viewer',
                style: AppStyles.whiteTextStyle().copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: kGreyShade7Color),
              ),
              SizedBox(height: getHeight(4)),
              Row(
                children: [
                  Image.asset(
                    kLogoMarkIcon,
                    height: getHeight(21),
                    width: getWidth(21),
                  ),
                  SizedBox(width: getWidth(8)),
                  Text(
                    '1000 Kaos Points',
                    style: AppStyles.whiteTextStyle().copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: getHeight(19)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Level 8',
                    style: AppStyles.whiteTextStyle().copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: kGreyShade7Color,
                    ),
                  ),
                  Text(
                    '450/800',
                    style: AppStyles.whiteTextStyle().copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: kGreyShade7Color,
                    ),
                  ),
                ],
              ),
              SizedBox(height: getHeight(2)),
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    width: getWidth(258),
                    height: getHeight(2),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: getWidth(10)),
                    decoration: const BoxDecoration(
                      color: kGreyShade8Color,
                    ),
                  ),
                  Container(
                    width: getWidth(258) * (450 / 800),
                    height: getHeight(2),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: getWidth(10)),
                    decoration: const BoxDecoration(
                      color: kOrangeColor,
                    ),
                  )
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget buildPoints() {
    return Container(
      width: getHeight(395),
      margin: EdgeInsets.symmetric(horizontal: getWidth(17)),
      padding: EdgeInsets.symmetric(
          horizontal: getWidth(19), vertical: getHeight(15)),
      decoration: BoxDecoration(
        color: kBlackShade5Color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Container(
            width: getHeight(144),
            height: getHeight(144),
            decoration: BoxDecoration(
              color: kGreenShade3Color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '128',
                  style: AppStyles.whiteTextStyle().copyWith(
                      fontSize: 26.sp, fontWeight: FontWeight.w700, height: 1),
                ),
                Text(
                  'Episodes Watched',
                  style: AppStyles.whiteTextStyle().copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: getWidth(13)),
          SizedBox(
            height: getHeight(144),
            width: getWidth(203),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: getHeight(95),
                      height: getHeight(75),
                      decoration: BoxDecoration(
                        color: kGreenShade4Color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '100',
                            style: AppStyles.whiteTextStyle().copyWith(
                                fontSize: 23.sp,
                                fontWeight: FontWeight.w700,
                                height: 1),
                          ),
                          Text(
                            'Games Played',
                            style: AppStyles.whiteTextStyle().copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: getHeight(95),
                      height: getHeight(75),
                      decoration: BoxDecoration(
                        color: kBlueShade1Color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '43',
                            style: AppStyles.whiteTextStyle().copyWith(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w700,
                                height: 1),
                          ),
                          Text(
                            'Trivia Questions\nAnswered',
                            textAlign: TextAlign.center,
                            style: AppStyles.whiteTextStyle().copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: getHeight(55),
                  decoration: BoxDecoration(
                    color: kPurpleShadeColor,
                    borderRadius: BorderRadius.circular(4),
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
                        'Use Kaos Points',
                        textAlign: TextAlign.center,
                        style: AppStyles.whiteTextStyle().copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildRareAchievement(FeaturedContent content) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getWidth(17)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rarest Achievements Earned',
            style: AppStyles.whiteTextStyle().copyWith(fontSize: 16.sp),
          ),
          SizedBox(height: getHeight(11)),
          InkWell(
            onTap: () {},
            child: Container(
              width: getWidth(397),
              height: getHeight(135),
              padding: EdgeInsets.symmetric(
                  horizontal: getWidth(14), vertical: getHeight(11)),
              decoration: BoxDecoration(
                  color: kBlackShade5Color,
                  borderRadius: BorderRadius.circular(4)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    content.imageUrl,
                    height: getHeight(112),
                    width: getWidth(92),
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: getWidth(20)),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          content.title,
                          style: AppStyles.whiteTextStyle().copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: getHeight(10)),
                        SizedBox(
                          width: getWidth(200),
                          child: Text(
                            content.subtitle,
                            style: AppStyles.whiteTextStyle().copyWith(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: getHeight(2)),
                        Text(
                          content.schedule,
                          style: AppStyles.whiteTextStyle().copyWith(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: kGreyShade7Color),
                        ),
                      ]),
                  const Spacer(),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          kTickIcon,
                          height: getHeight(28),
                          width: getWidth(35),
                        ),
                        SizedBox(height: getHeight(2)),
                        Text(
                          'Top 5%',
                          style: AppStyles.whiteTextStyle().copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: kGreyShade7Color),
                        ),
                      ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSection(ContentSection section) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getWidth(17)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.sectionTitle,
            style: AppStyles.whiteTextStyle()
                .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w400),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: getHeight(11)),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: section.items.length,
            itemBuilder: (context, index) {
              final item = section.items[index];
              return buildContentItem(item);
            },
          ),
        ],
      ),
    );
  }

  Widget buildContentItem(ContentItem item) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: getWidth(397),
        height: getHeight(135),
        padding: EdgeInsets.symmetric(
            horizontal: getWidth(14), vertical: getHeight(11)),
        margin: EdgeInsets.only(bottom: getHeight(22)),
        decoration: BoxDecoration(
            color: kBlackShade5Color, borderRadius: BorderRadius.circular(4)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              item.thumbnailUrl,
              height: getHeight(112),
              width: getWidth(92),
              fit: BoxFit.cover,
            ),
            SizedBox(width: getWidth(20)),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.title,
                    style: AppStyles.whiteTextStyle().copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: getHeight(10)),
                  SizedBox(
                    width: getWidth(200),
                    child: Text(
                      item.type,
                      style: AppStyles.whiteTextStyle().copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: getHeight(2)),
                  Text(
                    item.schedule,
                    style: AppStyles.whiteTextStyle().copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: kGreyShade7Color),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
