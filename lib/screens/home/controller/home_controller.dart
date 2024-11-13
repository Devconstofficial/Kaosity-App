import 'package:get/get.dart';
import 'package:kaosity_app/models/content_section_model.dart';
import 'package:kaosity_app/screens/view_video/controller/view_video_controller.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:kaosity_app/utils/app_images.dart';

class HomeController extends GetxController {
  final ViewVideoController controller = Get.find();
  var featuredContent = FeaturedContent(
    title: 'Escape Live',
    subtitle: 'Episode 1',
    imageUrl: kThumbImage10,
    schedule: 'Tonight at 9pm',
    tags: [
      Tag(name: 'Family', color: kPrimaryColor),
      Tag(name: 'Rated E', color: kBlueColor),
      Tag(name: 'Gameshow', color: kGreenColor),
    ],
  ).obs;

  var sections = <ContentSection>[].obs;
  var isMenuVisible = false.obs;
  var isSearchVisible = false.obs;
  var searchQuery = ''.obs;
  var searchedSections = <ContentSection>[].obs;

  void toggleMenu() {
    isMenuVisible.value = !isMenuVisible.value;
  }

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    sections.value = [
      ContentSection(
        sectionTitle: 'Watch & Play',
        items: [
          ContentItem(
            title: 'Dating Show',
            type: 'Reality',
            thumbnailUrl: kThumbImage1,
            schedule: 'Last Chance to Play!',
            tags: [
              Tag(name: 'Dating', color: kPrimaryColor),
              Tag(name: 'Reality', color: kBlueColor),
            ],
          ),
          ContentItem(
            title: 'Cooking Show',
            type: 'Reality',
            thumbnailUrl: kThumbImage2,
            schedule: 'Last Chance to Play!',
            tags: [
              Tag(name: 'Dating', color: kPrimaryColor),
              Tag(name: 'Reality', color: kBlueColor),
            ],
          ),
          ContentItem(
            title: 'Beauty Show',
            type: 'Reality',
            thumbnailUrl: kThumbImage3,
            schedule: 'Last Chance to Play!',
            tags: [
              Tag(name: 'Dating', color: kPrimaryColor),
              Tag(name: 'Reality', color: kBlueColor),
            ],
          ),
        ],
      ),
      ContentSection(
        sectionTitle: 'Choose Your Own Adventure',
        items: [
          ContentItem(
            title: 'Adventure Show',
            type: 'Action',
            thumbnailUrl: kThumbImage4,
            schedule: 'Next Showing at 4 pm',
            tags: [
              Tag(name: 'Adventure', color: kPrimaryColor),
              Tag(name: 'Action', color: kBlueColor),
            ],
          ),
          ContentItem(
            title: 'Game Show',
            type: 'Action',
            thumbnailUrl: kThumbImage5,
            schedule: 'Next Showing at 4 pm',
            tags: [
              Tag(name: 'Adventure', color: kPrimaryColor),
              Tag(name: 'Action', color: kBlueColor),
            ],
          ),
          ContentItem(
            title: 'Mystery Show',
            type: 'Action',
            thumbnailUrl: kThumbImage6,
            schedule: 'Next Showing at 4 pm',
            tags: [
              Tag(name: 'Adventure', color: kPrimaryColor),
              Tag(name: 'Action', color: kBlueColor),
            ],
          ),
        ],
      ),
      ContentSection(
        sectionTitle: 'Upcoming',
        items: [
          ContentItem(
            title: 'Dating Show',
            type: 'Interview',
            thumbnailUrl: kThumbImage7,
            schedule: 'Tomorrow at 8 pm EST',
            tags: [
              Tag(name: 'Celebrity', color: kPrimaryColor),
              Tag(name: 'Interview', color: kBlueColor),
            ],
          ),
          ContentItem(
            title: 'Celebrity Show',
            type: 'Interview',
            thumbnailUrl: kThumbImage8,
            schedule: 'Tomorrow at 8 pm EST',
            tags: [
              Tag(name: 'Celebrity', color: kPrimaryColor),
              Tag(name: 'Interview', color: kBlueColor),
            ],
          ),
          ContentItem(
            title: 'Celebrity Show',
            type: 'Interview',
            thumbnailUrl: kThumbImage9,
            schedule: 'Tomorrow at 8 pm EST',
            tags: [
              Tag(name: 'Celebrity', color: kPrimaryColor),
              Tag(name: 'Interview', color: kBlueColor),
            ],
          ),
        ],
      ),
    ];
  }

  void toggleSearch() {
    isSearchVisible.value = !isSearchVisible.value;
  }

  void searchShows(String query) {
    searchQuery.value = query;
    searchedSections.value = sections
        .map((section) => ContentSection(
              sectionTitle: section.sectionTitle,
              items: section.items
                  .where((item) =>
                      item.title.toLowerCase().contains(query.toLowerCase()))
                  .toList(),
            ))
        .toList();
  }
}
