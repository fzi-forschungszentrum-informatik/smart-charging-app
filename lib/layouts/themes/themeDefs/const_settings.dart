import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final int kFlexFactor = 12;

final TextStyle kSettingsSubtitleTextStyle = TextStyle(
  fontFamily: GoogleFonts.workSans().fontFamily,
  fontFeatures: [FontFeature.tabularFigures()],
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.2,
);

final TextStyle kSettingsSubtitleThinTextStyle = TextStyle(
  fontFamily: GoogleFonts.workSans().fontFamily,
  fontFeatures: [FontFeature.tabularFigures()],
  fontSize: 11.0,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.2,
);

final TextStyle kSettingsTitleTextStyle = TextStyle(
    fontFamily: GoogleFonts.workSans().fontFamily,
    fontFeatures: [FontFeature.tabularFigures()],
    fontSize: 25.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
    color: Colors.black);

final TextStyle kSettingsWidgetTitleTextStyle = TextStyle(
    fontFamily: GoogleFonts.workSans().fontFamily,
    fontFeatures: [FontFeature.tabularFigures()],
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    color: Colors.black);
final TextStyle kSettingsWidgetSubtitleTextStyle = TextStyle(
    fontFamily: GoogleFonts.workSans().fontFamily,
    fontFeatures: [FontFeature.tabularFigures()],
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    color: Colors.black);
final TextStyle kSettingsInformationTextStyle = TextStyle(
    fontFamily: GoogleFonts.workSans().fontFamily,
    fontFeatures: [FontFeature.tabularFigures()],
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
    color: Colors.black);
final TextStyle kSettingsWidgetSubtitleTextStyleKursiv = TextStyle(
    fontFamily: GoogleFonts.workSans().fontFamily,
    fontFeatures: [FontFeature.tabularFigures()],
    fontSize: 13.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    color: Colors.black);
final TextStyle kWorkSansTextStyle = TextStyle(
    fontFamily: GoogleFonts.workSans().fontFamily,
    fontFeatures: [FontFeature.tabularFigures()],
    letterSpacing: 0,
    color: Colors.black);

final List<Widget> kSnapshotIsNotDoneYet = <Widget>[
  SizedBox(
    width: 60,
    height: 60,
    child: CircularProgressIndicator(),
  ),
  Padding(
    padding: EdgeInsets.only(top: 16),
    child: Text('Awaiting result...'),
  ),
];

final List<Widget> kSnapshotHasError = <Widget>[
    Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 60,
    ),
    Padding(
        padding: EdgeInsets.only(top: 16),
        child: Text('Something went wrong!'),
    )
];