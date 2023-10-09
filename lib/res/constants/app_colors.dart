

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:inspection_app_flutter/res/constants/app_constants.dart';

class AppColors {
  AppColors._();

  //static ColorConstantsModel? colorConstants;
  
  static const MaterialColor navy = MaterialColor(
    0xFF162A69,
    <int, Color>{
      50: Color(0xFF162A49),
      100: Color(0xFF162A49),
      200: Color(0xFF162A49),
      300: Color(0xFF162A49),
      400: Color(0xFF162A49),
      500: Color(0xFF162A49),
      600: Color(0xFF162A49),
      700: Color(0xFF162A49),
      800: Color(0xFF162A49),
      900: Color(0xFF162A49),
    },
  );

  static Color textcolorblack = hexToColor(AppConstants.colorConstants?.textcolor2 ?? "#000000");
  static Color textcolorwhite = hexToColor(AppConstants.colorConstants?.textcolor1 ?? "#000000");
  static Color backgroundClr = hexToColor(AppConstants.colorConstants?.backgroundColor ?? "#000000");
  



}


  Color hexToColor(String code) {
    // Remove any leading '#' character
    if (code.startsWith('#')) {
      code = code.substring(1);
    }

    // Parse the color code as a hexadecimal integer
    int colorValue = int.parse(code, radix: 16);

    // Create a Color object by bitwise-ORing the color value with 0xFF (opaque alpha)
    return Color(colorValue | 0xFF000000);
  }
