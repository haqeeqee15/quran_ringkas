import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quranringkas/app/general/appColors.dart';

class AppTextStyles {
  var kTextStyleWithFont = GoogleFonts.poppins();

  var kTextStyle18WithThemeColor = GoogleFonts.poppins(
      fontSize: 18,
      color: AppColors().kPrimaryTextColor,
      fontWeight: FontWeight.w800);
  
  var kTextStyle28WithThemeColor = GoogleFonts.poppins(
      fontSize: 28,
      color: AppColors().kPrimaryTextColor,
      fontWeight: FontWeight.w800);

  var kTextStyleTwelveWithGreyColor =
      GoogleFonts.poppins(fontSize: 12, color: AppColors().kSecondaryTextColor);
}
