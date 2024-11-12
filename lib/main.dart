import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaosity_app/utils/app_strings.dart';
import 'package:kaosity_app/utils/app_theme.dart';
import 'package:kaosity_app/utils/route_generator.dart';
import 'package:kaosity_app/utils/screen_bindings.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
              initialRoute: kDisclaimerScreenRoute,
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
