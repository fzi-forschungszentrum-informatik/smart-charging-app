import 'package:flutter/material.dart';
import '../../../layouts/themes/themeDefs/const.dart';
import '/layouts/themes/themeDefs/const_user_setup.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({
    required this.buttonColor,
    required this.label,
    required this.onPressed,
  });

  final Color buttonColor;
  final String label;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: MaterialButton(
        minWidth: 200.0,
        height: 20.0,
        onPressed: onPressed,
        child: Text(
          label,
          style: buttonColor == kBodyText2Color
              ? welcomeScreenTextStyle.copyWith(color: Color(0xFFFFFFFF))
              : welcomeScreenTextStyle,
        ),
      ),
    );
  }
}
