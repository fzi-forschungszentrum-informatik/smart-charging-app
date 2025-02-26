import 'package:flutter/material.dart';
import 'package:fzi_charging_app/layouts/themes/themeDefs/const.dart';
import '../../../../layouts/themes/themeDefs/const_charging_screen.dart';
import 'dart:math';
import '../../../../model/UserProfile/userProfile.dart';
import '../../../98_general/media_query.dart';

class GewuenschterLadestandSlider extends StatefulWidget {
  final UserProfile? profile;

  final Function refresh;
  final Function refreshCosts;

  GewuenschterLadestandSlider(
 this.profile,
    this.refresh,
    this.refreshCosts,
  );

  @override
  _GewuenschterLadestandSliderState createState() =>
      _GewuenschterLadestandSliderState();
}

class _GewuenschterLadestandSliderState
    extends State<GewuenschterLadestandSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'GEWÜNSCHTER LADESTAND:',
              style: TextStyle(
                  fontSize: MediaQueryUtils.widthIsAbove350(context) ? 15 : 11),
            ),
            Row(
              children: [
                Text(
                  widget.profile == null ? "0%" : "${widget.profile!.chargeSettings.endStateOfCharge}%",
                  style: TextStyle(
                      fontSize:
                          MediaQueryUtils.widthIsAbove350(context) ? 15 : 11),
                ),
                MediaQuery.of(context).size.width > 400
                    ? Text(
                         widget.profile == null ? "  (~0km)" : "  (~${((widget.profile!.chargeSettings.endStateOfCharge/100)*widget.profile!.currentSelectedVehicle.rangeWhenFullInKiloMeters).toStringAsFixed(0)}km)"
                           ,
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
              min(widget.profile == null ? 0 : widget.profile!.chargeSettings.endStateOfCharge/100,
                  1),
              0),
          activeColor: kInteractionColor,
          inactiveColor: kNoInteractionColor,
          onChanged:
              (double newValue) {
            if(widget.profile != null) setState(()=>widget.profile!.chargeSettings.endStateOfCharge = (newValue *100).toInt());
                 //widget.chargingParameter
                   //   .setDesiredStateOfChargeFactor(newValue);
                  //widget.refresh();
                },
          onChangeEnd: (double newValue) {
            widget.refreshCosts();
          },
        ),
      ],
    );
  }
}
