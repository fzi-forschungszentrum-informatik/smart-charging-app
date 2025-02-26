import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:intl/intl.dart';
import 'package:fzi_charging_app/layouts/themes/themeDefs/const_charging_screen.dart';

class ChargingPlanLineChart extends StatelessWidget {
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';
  final SplayTreeMap<DateTime, double> estimatedStateOfChargeFactor;
  final bool animate = false;
  final String timeStart;
  final String timeEnd;
  final double widgetHeight;
  final double widgetWidth;
  final String descriptionTimeStart;
  final String descriptionTimeEnd;

  ChargingPlanLineChart({
    required this.estimatedStateOfChargeFactor,
    required this.timeStart,
    required this.timeEnd,
    required this.widgetHeight,
    required this.widgetWidth,
    required this.descriptionTimeStart,
    required this.descriptionTimeEnd,
  });

  List<Series<MapEntry<DateTime, num>, DateTime>> _makeSeriesFromMap() {
    return [
      new Series<MapEntry<DateTime, double>, DateTime>(
        id: 'estimatedStateOfChargeFactor',
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        domainFn: (MapEntry<DateTime,double> entry, _) => entry.key,
        measureFn: (MapEntry entry, _) => entry.value,
        data: List.of(estimatedStateOfChargeFactor.entries),
      ),
      // new Series<MapEntry<DateTime, int>, DateTime>(
      //   id: 'estimatedStateOfChargeInWattHours',
      //   colorFn: (_, __) => MaterialPalette.green.shadeDefault,
      //   domainFn: (MapEntry entry, _) => entry.key,
      //   measureFn: (MapEntry entry, _) => entry.value,
      //   data: List.of(estimatedStateOfChargeInWattHours.entries),
      // )..setAttribute(measureAxisIdKey, secondaryMeasureAxisId),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Series<MapEntry<DateTime, num>, DateTime>> ff  =  _makeSeriesFromMap();
    return Container(
      height: widgetHeight,
      width: widgetWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(

                'Ladestand\n in %',
                style: kKostenTitelKlein,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Expanded(
            child: TimeSeriesChart(
             ff,
              dateTimeFactory: _LocalizedDateTimeFactory(Locale('de')),
              animate: animate,
             /* primaryMeasureAxis: PercentAxisSpec(
                tickProviderSpec: BasicNumericTickProviderSpec(
                  desiredMinTickCount: 11,
                  desiredMaxTickCount: 11,
                  dataIsInWholeNumbers: false,
                ),
                // viewport: NumericExtents(
                //   max(0.0, stateOfChargeMap.values.reduce(min) - 0.1),
                //   min(1.0, stateOfChargeMap.values.reduce(max) + 0.1),
                // ),
            //  ), */
              // secondaryMeasureAxis: NumericAxisSpec(
              //   tickProviderSpec: BasicNumericTickProviderSpec(
              //     desiredMinTickCount: 11,
              //     desiredMaxTickCount: 11,
              //     dataIsInWholeNumbers: false,
              //   ),
              // ),
              behaviors: [
                LinePointHighlighter(
                    showHorizontalFollowLine:
                        LinePointHighlighterFollowLineType.nearest,
                    showVerticalFollowLine:
                        LinePointHighlighterFollowLineType.nearest),
                SelectNearest(eventTrigger: SelectionTrigger.tapAndDrag)
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                timeStart + '\n' + descriptionTimeStart,
                style: kKostenTitelKlein,
                textAlign: TextAlign.center,
              ),
              Text(
                timeEnd + '\n' + descriptionTimeEnd,
                style: kKostenTitelKlein,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LocalizedDateTimeFactory extends LocalDateTimeFactory {
  final Locale locale;

  @override
  DateFormat createDateFormat(String? pattern) {
    return DateFormat("HH:mm"); // locale.languageCode
  }

  _LocalizedDateTimeFactory(this.locale);
}
