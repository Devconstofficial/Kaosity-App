import 'package:get/get.dart';
import 'package:kaosity_app/screens/auth/controller/auth_controller.dart';
import 'package:kaosity_app/screens/home/controller/home_controller.dart';

class ScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => HomeController());
  }
}
