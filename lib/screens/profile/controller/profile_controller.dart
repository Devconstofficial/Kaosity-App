import 'package:get/get.dart';
import 'package:kaosity_app/models/content_section_model.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:kaosity_app/utils/app_images.dart';

class ProfileController extends GetxController {
  var rareAchievement = FeaturedContent(
    title: 'Escape Live',
    subtitle: 'Complete All Challenges in a Single Episode',
    imageUrl: kThumbImage10,
    schedule: '12/9/2024   3:45',
    tags: [
      Tag(name: 'Family', color: kPrimaryColor),
      Tag(name: 'Rated E', color: kBlueColor),
      Tag(name: 'Gameshow', color: kGreenColor),
    ],
  ).obs;

  var allAchievements = <ContentSection>[].obs;
  var isMenuVisible = false.obs;
  var isSearchVisible = false.obs;

  void toggleMenu() {
    isMenuVisible.value = !isMenuVisible.value;
  }

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    allAchievements.value = [
      ContentSection(
        sectionTitle: 'All Achievements',
        items: [
          ContentItem(
            title: 'The Climb',
            type: 'Help Contestants Reach the Peak!',
            thumbnailUrl: kThumbImage1,
            schedule: '11/18/2024  7:34',
            tags: [
              Tag(name: 'Dating', color: kPrimaryColor),
              Tag(name: 'Reality', color: kBlueColor),
            ],
          ),
          ContentItem(
            title: 'Game Night',
            type: 'Help All Four Cast Members in a Single Episode',
            thumbnailUrl: kThumbImage2,
            schedule: '10/5/2024 8:00',
            tags: [
              Tag(name: 'Dating', color: kPrimaryColor),
              Tag(name: 'Reality', color: kBlueColor),
            ],
          ),
        ],
      ),
    ];
  }
}
