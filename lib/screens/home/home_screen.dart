import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaosity_app/models/content_section_model.dart';
import 'package:kaosity_app/screens/home/controller/home_controller.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:kaosity_app/utils/app_images.dart';
import 'package:kaosity_app/utils/app_strings.dart';
import 'package:kaosity_app/utils/app_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.find();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        backgroundColor: kBgColor,
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
            onTap: homeController.toggleMenu,
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
              children: [
                SizedBox(height: getHeight(30)),
                buildFeaturedContent(homeController.featuredContent.value),
                SizedBox(height: getHeight(31)),
                ...homeController.sections
                    .map((section) => buildSection(section))
                    .toList(),
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
                  height:
                      homeController.isMenuVisible.value ? getHeight(150) : 0,
                  color: kBgColor,
                  child: Column(
                    children: [
                      Text(
                        'Home',
                        style: AppStyles.whiteTextStyle()
                            .copyWith(fontSize: 16.sp),
                      ),
                      SizedBox(height: getHeight(18)),
                      Text(
                        'Profile',
                        style: AppStyles.whiteTextStyle()
                            .copyWith(fontSize: 16.sp),
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

  Widget buildFeaturedContent(FeaturedContent content) {
    return InkWell(
      onTap: () {
      
      },
      child: Container(
        width: getWidth(396),
        height: getHeight(358),
        margin: EdgeInsets.symmetric(horizontal: getWidth(17)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  content.imageUrl,
                  height: getHeight(293),
                  width: getWidth(396),
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: getHeight(20),
                  left: getWidth(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          content.title,
                          style: AppStyles.whiteTextStyle().copyWith(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          content.subtitle,
                          style: AppStyles.whiteTextStyle().copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ]),
                ),
              ],
            ),
            SizedBox(height: getHeight(7)),
            Row(
              children: content.tags.map((tag) {
                return Container(
                  height: getHeight(17),
                  margin: EdgeInsets.only(right: getWidth(8)),
                  padding: EdgeInsets.symmetric(horizontal: getWidth(11)),
                  decoration: BoxDecoration(
                    color: tag.color,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Center(
                    child: Text(
                      tag.name,
                      style: AppStyles.blackTextStyle().copyWith(
                          color: kBgColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: getHeight(10)),
            Text(
              content.schedule,
              style: AppStyles.whiteTextStyle()
                  .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSection(ContentSection section) {
    return Padding(
      padding: EdgeInsets.only(bottom: getHeight(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(14)),
            child: Text(
              section.sectionTitle,
              style: AppStyles.whiteTextStyle()
                  .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: getHeight(248),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                  vertical: getHeight(10), horizontal: getWidth(14)),
              scrollDirection: Axis.horizontal,
              itemCount: section.items.length,
              itemBuilder: (context, index) {
                final item = section.items[index];
                return buildContentItem(item);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContentItem(ContentItem item) {
    return InkWell(
      onTap: () {
       
      },
      child: Container(
        width: getWidth(170),
        margin: EdgeInsets.only(right: getWidth(10)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.asset(
                    item.thumbnailUrl,
                    width: getWidth(170),
                    height: getHeight(174),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: getHeight(29),
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: getWidth(6)),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      kBlackColor.withOpacity(0.9),
                      kBlackColor.withOpacity(0)
                    ]),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  child: Text(
                    item.title,
                    style: AppStyles.whiteTextStyle()
                        .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w700),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: getHeight(5)),
            Padding(
              padding: EdgeInsets.only(left: getWidth(8)),
              child: Row(
                children: item.tags.map((tag) {
                  return Container(
                    height: getHeight(15),
                    margin: EdgeInsets.only(right: getWidth(4)),
                    padding: EdgeInsets.symmetric(horizontal: getWidth(6)),
                    decoration: BoxDecoration(
                      color: tag.color,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Center(
                      child: Text(
                        tag.name,
                        style: AppStyles.blackTextStyle()
                            .copyWith(color: kBgColor, fontSize: 11.sp),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: getHeight(10)),
            Padding(
              padding: EdgeInsets.only(left: getWidth(8)),
              child: Text(
                item.schedule,
                style: AppStyles.whiteTextStyle()
                    .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
