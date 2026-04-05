import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static CupertinoThemeData get themeData {
    return CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.pastelMint,
      primaryContrastingColor: AppColors.textPrimary,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: CupertinoTextThemeData(
        textStyle: GoogleFonts.dongle(
          color: AppColors.textPrimary,
          fontSize: 28, // Dongle font usually needs larger sizes
          height: 1.2,
        ),
        actionTextStyle: GoogleFonts.dongle(
          color: AppColors.pastelMint,
          fontSize: 28,
        ),
        navTitleTextStyle: GoogleFonts.dongle(
          color: AppColors.textPrimary,
          fontSize: 34,
          fontWeight: FontWeight.w600,
        ),
        navActionTextStyle: GoogleFonts.dongle(
          color: AppColors.pastelMint,
          fontSize: 28,
        ),
        pickerTextStyle: GoogleFonts.dongle(
          color: AppColors.textPrimary,
          fontSize: 28,
        ),
        dateTimePickerTextStyle: GoogleFonts.dongle(
          color: AppColors.textPrimary,
          fontSize: 28,
        ),
      ),
    );
  }
}
