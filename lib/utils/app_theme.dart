import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaosity_app/utils/app_colors.dart';

ThemeData buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);

  return baseTheme.copyWith(
    textTheme: GoogleFonts.urbanistTextTheme(baseTheme.textTheme),
    scaffoldBackgroundColor: kBgColor,
    appBarTheme: const AppBarTheme(backgroundColor: kBgColor),
    colorScheme: ThemeData().colorScheme.copyWith(primary: kPrimaryColor),
  );
}
