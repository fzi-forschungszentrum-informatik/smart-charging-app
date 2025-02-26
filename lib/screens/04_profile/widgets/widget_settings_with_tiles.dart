import 'package:flutter/material.dart';
import 'package:fzi_charging_app/screens/98_general/general_widgets.dart';
import 'package:fzi_charging_app/layouts/themes/themeDefs/const_charging_screen.dart';
import 'package:fzi_charging_app/layouts/themes/themeDefs/const_settings.dart';

class SettingsWidgetWithTitle extends StatefulWidget {
  SettingsWidgetWithTitle({
    required this.title,
    required this.icondata,
    required this.editItemsCallback,
    required this.widget,
    required this.edit,
  });

  String title;
  IconData icondata;
  Function editItemsCallback;
  Widget widget;
  String edit;

  @override
  _SettingsWidgetWithTitleState createState() =>
      _SettingsWidgetWithTitleState();
}

class _SettingsWidgetWithTitleState extends State<SettingsWidgetWithTitle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: Container(),
            ),
            Expanded(
              flex: kFlexFactor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeaderWithIcon(icon: widget.icondata, title: widget.title),
                  GestureDetector(
                    onTap: () {
                      widget.editItemsCallback();
                    },
                    child: Text(widget.edit,
                        style: kSettingsSubtitleTextStyle.copyWith(
                            color: kInteractionColor)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
        SizedBox(
          height: 25,
        ),
        widget.widget,
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
