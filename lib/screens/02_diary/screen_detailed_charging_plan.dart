import 'package:flutter/material.dart';
import 'package:fzi_charging_app/model/calendar_event.dart';
import 'package:fzi_charging_app/screens/01_charging/widgets/window_for_charging_plan_line_chart.dart';
import 'package:fzi_charging_app/layouts/themes/themeDefs/const_diary.dart';
import 'package:fzi_charging_app/screens/98_general/media_query.dart';
import '../../layouts/themes/themeDefs/const.dart';
import '../../utils/number_formatting.dart';
import '../98_general/date_time_formatter.dart';
import '../98_general/general_widgets.dart';

class ChargingPlanDetailScreen extends StatefulWidget {
  CalendarEvent calendarEvent;
  Function getChargingModeIconData;
  ChargingPlanDetailScreen(
      {required this.calendarEvent, required this.getChargingModeIconData});
  @override
  _ChargingPlanDetailScreenState createState() =>
      _ChargingPlanDetailScreenState();
}

class _ChargingPlanDetailScreenState extends State<ChargingPlanDetailScreen> {
  String getChargingModeDescription(int chargingMode) {
    if (chargingMode == 0)
      return 'Dieser Ladevorgang hat den Grünstromanteil maximiert und die Kosten gesenkt.';
    if (chargingMode == 1)
      return 'Dieser Ladevorgang hat bis 25% Ladestand schnell geladen und danach den Grünstromanteil optimiert.';
    else
      return 'Dieser Ladevorgang wurde schnell geladen.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Header
              Row(
                children: [
                  Expanded(child: Container()),
                  Expanded(
                    flex: 12,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 50),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            MediaQueryUtils.widthIsAbove430(context)
                                ? 'Ladevorgang - ' + Formatter.returnFormatMMMMd(widget.calendarEvent.timeStart)
                                : Formatter.returnFormatMMMMd(widget.calendarEvent.timeStart),
                            style: kHeaderTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
              //Graph
              Row(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  ChargingPlanLineChart(
                      estimatedStateOfChargeFactor:
                          widget.calendarEvent.stateOfChargeMap,
                      timeStart: Formatter.returnFormatHHmm(
                              widget.calendarEvent.timeStart) +
                          ' Uhr',
                      timeEnd: Formatter.returnFormatHHmm(
                              widget.calendarEvent.timeStop) +
                          ' Uhr',
                      widgetHeight: MediaQuery.of(context).size.height * 0.35,
                      widgetWidth: MediaQuery.of(context).size.width * 0.85,
                      descriptionTimeStart: 'Beginn',
                      descriptionTimeEnd: 'Ende'),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
              //Detailed Information in Rows
              Row(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    flex: 12,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Row(
                            children: [
                              Text(
                                'LADEMODUS',
                                style: kTagebuchTitle,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 0.5,
                          child: Container(
                            color: Colors.black54,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 11,
                                child: Row(
                                  children: [
                                    Icon(widget.getChargingModeIconData(
                                        widget.calendarEvent.chargingMode)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                        child: Text(
                                      getChargingModeDescription(
                                          widget.calendarEvent.chargingMode),
                                      style: kTagebuchDescription,
                                    )),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              DetailRow(
                title: 'LADESTAND',
                top: [calculatevehicleSoCBeforeCharge(), widget.calendarEvent.energyChargedInkWh.toStringAsFixed(1), widget.calendarEvent.vehicleSoCInkWhAfterCharge.toStringAsFixed(1)],
                middle: ['kWh', 'kWh', 'kWh'],
                bottom: ['Start', 'Lademenge', 'Ende'],
              ),
              DetailRow(
                title: 'ZEIT',
                top: [
                  Formatter.returnFormatHHmm(widget.calendarEvent.timeStart),
                  calculateTimeDifference(),
                  Formatter.returnFormatHHmm(widget.calendarEvent.timeStop),
                ],
                middle: ['Uhr', 'h', 'Uhr'],
                bottom: ['Start', 'Ladezeit', 'Ende'],
              ),
              DetailRow(
                title: 'KOSTEN',
                top: [
                  NumberFormatters.regEuroFormatter
                      .format(widget.calendarEvent.price),
                  '',
                  ''
                ],
                middle: ['', '', ''],
                bottom: ['Kosten', '', ''],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String calculatevehicleSoCBeforeCharge() => (widget.calendarEvent.vehicleSoCInkWhAfterCharge-widget.calendarEvent.energyChargedInkWh).toStringAsFixed(1);

  String calculateTimeDifference() {
    return '+' +
        widget.calendarEvent.timeStop
            .difference(widget.calendarEvent.timeStart)
            .inHours
            .toString() +
        ':' +
        widget.calendarEvent.timeStop
            .difference(widget.calendarEvent.timeStart)
            .inMinutes
            .remainder(60)
            .toString()
            .padLeft(2, "0");
  }
}

class DetailRow extends StatelessWidget {
  DetailRow({
    required this.title,
    required this.top,
    required this.middle,
    required this.bottom,
  });

  final String title;
  final List<String> top;
  final List<String> middle;
  final List<String> bottom;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(),
        ),
        Expanded(
          flex: 12,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  children: [
                    Text(
                      title,
                      style: kTagebuchTitle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 0.5,
                child: Container(
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              RowWithValueUnitDescription(top: top, middle: middle, bottom: bottom),
            ],
          ),
        ),
      ],
    );
  }
}
