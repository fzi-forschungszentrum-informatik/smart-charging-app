import 'dart:ui';
import 'package:fzi_charging_app/layouts/themes/themeDefs/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Defines all available app themes for material
class AppThemes {
  //region defaultTheme
  static ThemeData get defaultTheme {
    return new ThemeData(
      brightness: Brightness.light,
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: Colors.white,
      iconTheme: IconThemeData(color: kIconColor),
      textTheme: GoogleFonts.workSansTextTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
//endregion
}
