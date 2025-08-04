import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/const/app_colors.dart';
import 'core/localization/localization.dart';
import 'feature/splash/view/splash_screen.dart';

class VRoomZ extends StatelessWidget {
  const VRoomZ({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocalLocalizations(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.bgColor,
        textTheme: TextTheme(
          displayLarge: GoogleFonts.hindSiliguri(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
          ),
          bodyMedium: GoogleFonts.hindSiliguri(),
        ),
      ),
       home: SplashScreen(),
    );
  }
}
