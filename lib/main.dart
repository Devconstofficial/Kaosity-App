import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kaosity_app/utils/app_strings.dart';
import 'package:kaosity_app/utils/app_theme.dart';
import 'package:kaosity_app/utils/route_generator.dart';
import 'package:kaosity_app/utils/screen_bindings.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final box = GetStorage();
  String initialRoute = kDisclaimerScreenRoute;
  final authToken = box.read<String?>('authToken');

  if (authToken != null) {
    initialRoute = kSplashScreenRoute;
    log(authToken);
  }
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return ScreenUtilInit(
        designSize: const Size(430, 957),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
              theme: buildTheme(Brightness.light),
              title: 'Kaosity App',
              debugShowCheckedModeBanner: false,
              initialBinding: ScreenBindings(),
              initialRoute: initialRoute,
              getPages: RouteGenerator.getPages(),
              builder: (context, child) {
                return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                        textScaler: MediaQuery.of(context)
                            .textScaler
                            .clamp(minScaleFactor: 1.0, maxScaleFactor: 1.0)),
                    child: child!);
              });
        },
      );
    });
  }
}
