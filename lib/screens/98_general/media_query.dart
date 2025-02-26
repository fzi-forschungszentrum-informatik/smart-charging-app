import 'package:flutter/material.dart';

class MediaQueryUtils {
  static bool widthIsAbove350(BuildContext context) =>
      MediaQuery.of(context).size.width > 350;

  static bool widthIsAbove430(BuildContext context) =>
      MediaQuery.of(context).size.width > 430;

  static bool heightIsAbove720(BuildContext context) =>
      MediaQuery.of(context).size.height > 720;

  static bool heightIsAbove590(BuildContext context) =>
      MediaQuery.of(context).size.height > 590;

  static bool heightIsAbove470(BuildContext context) =>
      MediaQuery.of(context).size.height > 470;
}
