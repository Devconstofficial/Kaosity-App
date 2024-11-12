import 'package:get/get.dart';
import 'package:kaosity_app/screens/auth/forget_password_screen.dart';
import 'package:kaosity_app/screens/auth/login_screen.dart';
import 'package:kaosity_app/screens/auth/register_screen.dart';
import 'package:kaosity_app/screens/home/home_screen.dart';
import 'package:kaosity_app/screens/starting_screens/disclaimer_screen.dart';
import 'package:kaosity_app/screens/starting_screens/dont_agree_screen.dart';
import 'package:kaosity_app/screens/starting_screens/splash_screen.dart';
import 'package:kaosity_app/screens/view_video/view_video_screen.dart';
import 'package:kaosity_app/utils/app_strings.dart';
import 'package:kaosity_app/utils/screen_bindings.dart';

class RouteGenerator {
  static List<GetPage> getPages() {
    return [
      GetPage(
          name: kDisclaimerScreenRoute,
          page: () => const DisclaimerScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kDontAgreeScreenRoute,
          page: () => const DontAgreeScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kLoginScreenRoute,
          page: () => LoginScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kRegisterScreenRoute,
          page: () => RegisterScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kForgotPasswordScreenRoute,
          page: () => ForgetPasswordScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kSplashScreenRoute,
          page: () => const SplashScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kHomeScreenRoute,
          page: () => HomeScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kViewVideoScreenRoute,
          page: () => ViewVideoScreen(),
          binding: ScreenBindings()),
    ];
  }
}
