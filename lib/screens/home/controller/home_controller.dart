import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kaosity_app/models/content_section_model.dart';
import 'package:kaosity_app/screens/view_video/controller/view_video_controller.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:kaosity_app/utils/app_images.dart';

import '../../../services/websocket_services.dart';
import '../video_services/video_services.dart';

class HomeController extends GetxController {
  final ViewVideoController controller = Get.find();
  final VideoService videoService = VideoService();
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
  var list = <dynamic>[].obs;
  var sections = <ContentSection>[].obs;
  var isMenuVisible = false.obs;
  var isSearchVisible = false.obs;
  var searchQuery = ''.obs;
  var searchedSections = <ContentSection>[].obs;

  void toggleMenu() {
    isMenuVisible.value = !isMenuVisible.value;
  }

  @override
  void onInit()async {
    super.onInit();
    loadData();
    final webSocketService = WebSocketService();
    await webSocketService.connect();
    fetchAndAppendVideos();
  }

  Future<void> fetchAndAppendVideos() async {
    try {
      final videos = await videoService.fetchVideos();

      if (videos.isNotEmpty) {
        final fetchedVideo = videos.first;

        featuredContent.value = FeaturedContent(
          id: fetchedVideo['_id'],
          path: fetchedVideo['path'],
          thumbnail: fetchedVideo['thumbnail'],
          participants: fetchedVideo['participants'],
          title: 'Escape Live',
          subtitle: 'Episode 1',
          imageUrl: kThumbImage10,
          schedule: 'Tonight at 9pm',
          tags: [
            Tag(name: 'Family', color: kPrimaryColor),
            Tag(name: 'Rated E', color: kBlueColor),
            Tag(name: 'Gameshow', color: kGreenColor),
          ],
        );
        final GetStorage box = GetStorage();
        box.write('videoId', featuredContent.value.id);
        box.write('path', featuredContent.value.path);
        print(box.read('videoId'));
        print(box.read('path'));
        print(featuredContent.value.toString());
      }
    } catch (e) {
      print('Error fetching videos: $e');
    }
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
