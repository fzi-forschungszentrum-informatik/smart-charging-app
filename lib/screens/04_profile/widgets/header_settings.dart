import 'package:flutter/material.dart';
import 'package:fzi_charging_app/layouts/themes/themeDefs/const.dart';
import 'package:fzi_charging_app/layouts/themes/themeDefs//const_settings.dart';
import 'package:fzi_charging_app/model/UserProfile/userProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../layouts/themes/themeDefs/const_charging_screen.dart';
import '../../00_userSetup/screen_welcome.dart';

class SettingsHeader extends StatefulWidget {
  final UserProfile account;


  SettingsHeader({
    required this.account
  });

  @override
  _SettingsHeaderState createState() => _SettingsHeaderState();
}

class _SettingsHeaderState extends State<SettingsHeader> {


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container()),
        Expanded(
          flex: kFlexFactor,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                              Text(
                                widget.account.userName,
                                style: kHeaderTextStyle,
                              ),
                              SizedBox(height: 8),
                              Text(
                                widget.account.loginName,
                                style: kSettingsSubtitleTextStyle,
                              ),
                            ])),
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                       await  prefs.clear();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            WelcomeScreen.id,
                            (Route<dynamic> route) => false);
                      },
                      child: Text(
                        'Abmelden',
                        style:
                        kSettingsSubtitleTextStyle.copyWith(color: kInteractionColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
