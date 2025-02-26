import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//General Colors
const Color kInteractionColor = Color(0xFF2B3F19);
const Color kNoInteractionColor = Color(0xFFe2e2e2);
const Color kInteractionColor80 = Color(0x802B3F19);
const Color kDeactivated = Color(0xFFAAAAAA);

//Connection Status Colors
const Color kConnectionStatusColorRed = Color(0xFFd32f2f);
const Color kConnectionStatusColorOrange = Color(0xFFf57c00);
const Color kConnectionStatusColorGreen = Color(0xFF388e3c);
const Color kConnectionStatusColorGrey = Color(0xFF616161);

const Color kBackgroundColorDark = Color.fromRGBO(224, 234, 226, 1);
const Color kBackgroundColorLight = Color.fromRGBO(240, 244, 241, 1);

const Color kDefaultDarkTextColor = Color(0xFF332726);
const Color kLightGreyTextColor = Color(0xFF5C5C5C);
const Color kDefaultRedTextColor = Color(0xffBA2736);

//Kosten Anzeige Text Styles
final TextStyle kFramingTextStyle = TextStyle(
    fontSize: 11.0,
    fontFeatures: [FontFeature.tabularFigures()],
    fontFamily: GoogleFonts.workSans().fontFamily,
    color: kDefaultDarkTextColor,
    fontWeight: FontWeight.w400);
final TextStyle kKosten17pt = TextStyle(
    fontSize: 17.0,
    fontFamily: GoogleFonts.workSans().fontFamily,
    color: kDefaultDarkTextColor,
    letterSpacing: 0.2,
    fontWeight: FontWeight.w500);
final TextStyle kKosten14pt = TextStyle(
    fontSize: 14.0,
    fontFamily: GoogleFonts.workSans().fontFamily,
    color: kDefaultDarkTextColor,
    letterSpacing: 0.2,
    fontWeight: FontWeight.w500);
final TextStyle kKosten12pt = TextStyle(
    fontSize: 14.0,
    fontFamily: GoogleFonts.workSans().fontFamily,
    color: kDefaultDarkTextColor,
    letterSpacing: 0.2,
    fontWeight: FontWeight.w500);
final TextStyle kKosten10pt = TextStyle(
    fontSize: 10.0,
    fontFamily: GoogleFonts.workSans().fontFamily,
    color: kLightGreyTextColor,
    letterSpacing: 0,
    fontWeight: FontWeight.w400);
final TextStyle kKostenTitelKlein = TextStyle(
    fontSize: 11.0,
    fontFamily: GoogleFonts.workSans().fontFamily,
    color: kDefaultDarkTextColor,
    letterSpacing: 0.5,
    fontWeight: FontWeight.w400);

//Charging Mode Selection Buttons Text Style
final TextStyle kChargingModeButtonTitelStyle = TextStyle(
  fontSize: 15.0,
  fontFamily: GoogleFonts.workSans().fontFamily,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.2,
);
final TextStyle kChargingModeButtonDescriptionStyle = TextStyle(
    fontSize: 10.0,
    fontFamily: GoogleFonts.workSans().fontFamily,
    letterSpacing: 0,
    fontWeight: FontWeight.w400);

//LadeButton Text Style
final TextStyle kLadenButtonTextStyle = TextStyle(
  fontSize: 20.0,
  letterSpacing: 5.0,
  color: Colors.white,
);
