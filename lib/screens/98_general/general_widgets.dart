import 'package:flutter/material.dart';
import '../../layouts/themes/themeDefs/const_settings.dart';
import '../../layouts/themes/themeDefs/const_diary.dart';

class HeaderWithIcon extends StatelessWidget {
  HeaderWithIcon({required this.icon, required this.title});

  IconData icon;
  String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20.0),
        SizedBox(width: 10),
        Text(
          title,
          style: kSettingsWidgetTitleTextStyle,
        ),
      ],
    );
  }
}

class RowWithValueUnitDescription extends StatelessWidget {
  RowWithValueUnitDescription({
    required this.top,
    required this.middle,
    required this.bottom,
  });

  final List<String> top;
  final List<String> middle;
  final List<String> bottom;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        top.length,
            (index) => bottom[index].isEmpty
            ? buildColumn(index)
            : Expanded(
          child: buildColumn(index),
        ),
      ),
    );
  }

  Column buildColumn(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              top[index],
              style: kTagebuchValue,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: Text(
                middle[index],
                style: kTagebuchTextStyleSubheader,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Column(
          children: [
            Text(
              bottom[index],
              style: kTagebuchDescription,
            ),
          ],
        ),
      ],
    );
  }
}

class Seperator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 0.3,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}