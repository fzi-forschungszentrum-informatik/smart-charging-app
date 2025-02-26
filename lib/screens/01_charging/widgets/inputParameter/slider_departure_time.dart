import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../layouts/themes/themeDefs/const.dart';
import '../../../../layouts/themes/themeDefs/const_charging_screen.dart';
import '../../../../model/UserProfile/userProfile.dart';
import '../../../98_general/media_query.dart';

class AbfahrtszeitSlider extends StatefulWidget {
  final DateTime earliestTimeAtDesired;
  final UserProfile? profile;
  final Function refresh;
  final Function refreshCosts;

  AbfahrtszeitSlider(
    this.earliestTimeAtDesired,
    this.profile,
    this.refresh,
    this.refreshCosts,
  );

  @override
  _AbfahrtszeitSliderState createState() => _AbfahrtszeitSliderState();
}

class _AbfahrtszeitSliderState extends State<AbfahrtszeitSlider> {

  int slotSizeInMinutes = 15;

  bool _showInsufficientTimeFlexibilityWarning() {
    return false; //widget.chargingParameter.timeFlexiblity <
        //widget.earliestTimeAtDesired.toUtc().difference(DateTime.now().toUtc());
  }
  int _durationToSliderValue(Duration d) {
    print(d);
    int val = (d.inMinutes ~/ 15) - 1;
    if(val <= -1) val = 0;
    print(val);
    return val;
  }
  static final DateFormat departureTimeFormat = DateFormat("HH:mm");
  String getDepartureDisplayString() {
    DateTime now = DateTime.now();
    DateTime nextDayBreak = DateTime(now.year, now.month, now.day + 1);
    DateTime departure = getDeparture(now).toLocal();

    String sDate = departure.isBefore(nextDayBreak) ? "Heute" : "Morgen";
    String sTime = departureTimeFormat.format(departure);

    return "$sDate, $sTime Uhr";
  }
  int _floorToMultiple(int value, int multiple) {
    return (value ~/ multiple) * multiple;
  }
  DateTime getDeparture(DateTime nowPossiblyLocal) {
    DateTime nowUtc = nowPossiblyLocal.toUtc();
    DateTime latestDepartureInThePast = DateTime.utc(
      nowUtc.year,
      nowUtc.month,
      nowUtc.day,
      nowUtc.hour,
      _floorToMultiple(nowUtc.minute, slotSizeInMinutes),
    );
    DateTime departure = latestDepartureInThePast.add(getDuration());
    return departure;
  }

  Duration getDuration(){
    return new Duration(seconds: widget.profile == null ? 10 : widget.profile!.chargeSettings.timeOfCompletion);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'ABFAHRT:',
              style: TextStyle(
                  fontSize: MediaQueryUtils.widthIsAbove350(context) ? 15 : 11),
            ),
            Expanded(
              child: Container(),
            ),
            Icon(
              Icons.warning_amber_rounded,
              size: 20,
              color: _showInsufficientTimeFlexibilityWarning()
                  ? kInformationText
                  : Colors.white,
            ),
            Text(
              getDepartureDisplayString(),
              style: TextStyle(
                  color: _showInsufficientTimeFlexibilityWarning()
                      ? kInformationText
                      : kBodyText2Color,
                  fontSize: MediaQueryUtils.widthIsAbove350(context) ? 15 : 11),
            ),
          ],
        ),
        Slider(
          value: _durationToSliderValue(getDuration()).toDouble(),
          divisions: 15,
          min: 0,
          max: 95.0,
          activeColor: kInteractionColor,
          inactiveColor: kNoInteractionColor,
          onChanged:  (double newValue) {
                  setState(
                    () {
                      if(widget.profile!=null)widget.profile!.chargeSettings.timeOfCompletion = new Duration(minutes: (newValue.toInt() + 1) * 15).inSeconds;
                    },
                  );
                },
          onChangeEnd: (double newValue) {
            widget.refreshCosts();
          },
        ),
      ],
    );
  }
}
