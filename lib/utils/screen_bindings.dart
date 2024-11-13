import 'package:get/get.dart';
import 'package:kaosity_app/screens/auth/controller/auth_controller.dart';
import 'package:kaosity_app/screens/home/controller/home_controller.dart';
import 'package:kaosity_app/screens/profile/controller/profile_controller.dart';
import 'package:kaosity_app/screens/view_video/controller/view_video_controller.dart';

class ScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ViewVideoController());
    Get.lazyPut(() => ProfileController());
  }
}
