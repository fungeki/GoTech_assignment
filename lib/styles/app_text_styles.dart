import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gotech_flutter_assignment/styles/app_colors.dart';

class AppTextStyles {
  static const pageHeadline =
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static const questionTextStyle = TextStyle(
    fontSize: 18,
  );
  static const buttonTextStyle =
      TextStyle(fontSize: 18, color: AppColors.textButtonColor);
  static const requiredTextStyle = TextStyle(
    fontSize: 18,
    color: AppColors.required,
  );
}
