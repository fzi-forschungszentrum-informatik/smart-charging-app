import 'package:flutter/material.dart';
import 'dart:math';
import '../../../../layouts/themes/themeDefs/const.dart';
import '../../../../layouts/themes/themeDefs/const_charging_screen.dart';
import '../../../../model/UserProfile/userProfile.dart';
import '../../../98_general/media_query.dart';

class AktuellerLadestandSlider extends StatefulWidget {

  final Function refresh;
  final Function refreshCosts;
  final UserProfile? profile;

  AktuellerLadestandSlider(
    this.profile,
    this.refresh,
    this.refreshCosts,
  );

  @override
  _AktuellerLadestandSliderState createState() =>
      _AktuellerLadestandSliderState();
}

class _AktuellerLadestandSliderState extends State<AktuellerLadestandSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'AKTUELLER LADESTAND:',
              style: TextStyle(
                  fontSize: MediaQueryUtils.widthIsAbove350(context) ? 15 : 11),
            ),
            Row(
              children: [
                Text(
            widget.profile == null ? "0% "  :  "${(widget.profile!.chargeSettings.currentStateOfCharge)}% ",
                  style: TextStyle(
                      fontSize:
                          MediaQueryUtils.widthIsAbove350(context) ? 15 : 11),
                ),
                MediaQuery.of(context).size.width > 400
                    ? Text(
    widget.profile == null ?" (0km)"  : " (${(widget.profile!.chargeSettings.currentStateOfCharge/100
                                         *
                                    widget.profile!.currentSelectedVehicle.rangeWhenFullInKiloMeters)
                                .toStringAsFixed(0) }km)",
                        style: TextStyle(
                          color: kInformationText,
                          fontSize: 13,
                        ),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
        Slider(
          value: max(
              min(widget.profile == null ? 1 : widget.profile!.chargeSettings.currentStateOfCharge/100,
                  1),
              0),
          activeColor: kInteractionColor,
          inactiveColor: kNoInteractionColor,
          // FIXME: This code should be refactored such that onChanged updates
          // the locally stored data in the local data model and onChangeEnd
          // is used to update the data stored in the backend.
          onChanged:  (double newValue) {

           if(widget.profile != null) setState(()=>widget.profile!.chargeSettings.currentStateOfCharge = (newValue * 100).toInt())  ;
                  //widget.refresh();
                },
          onChangeEnd: (double v){
            widget.refreshCosts();
          },

        ),
      ],
    );
  }

  bool widthIsLarge(BuildContext context) =>
      MediaQuery.of(context).size.width > 350;
}
