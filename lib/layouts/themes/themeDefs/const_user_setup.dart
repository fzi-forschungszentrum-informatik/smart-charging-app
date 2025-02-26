import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color smartChargingGreen = Color(0xFF439374);
final TextStyle welcomeScreenTextStyle = TextStyle(
    color: smartChargingGreen, fontSize: 17.0, fontFamily: GoogleFonts.workSans().fontFamily, fontWeight: FontWeight.w500,
  letterSpacing: 0.5,);
const InputDecoration textFieldInputDec = InputDecoration(
  hintText: 'Email',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: smartChargingGreen, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: smartChargingGreen, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
  ),
);
