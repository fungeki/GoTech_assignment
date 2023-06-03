import 'package:flutter/material.dart';
import 'package:gotech_flutter_assignment/styles/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  static final appThemeData = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.primary,
    fontFamily: GoogleFonts.assistant().fontFamily,
  );
}
