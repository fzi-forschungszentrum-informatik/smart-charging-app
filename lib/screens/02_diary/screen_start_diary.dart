import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:fzi_charging_app/model/calendar_event.dart';
import 'package:fzi_charging_app/layouts/themes/themeDefs/const.dart';
import 'package:fzi_charging_app/layouts/themes/themeDefs/const_diary.dart';
import 'package:fzi_charging_app/providers/chargeHistoryService.dart';
import 'package:fzi_charging_app/utils/number_formatting.dart';
import 'package:provider/provider.dart';
import '../../layouts/mainLayout.dart';
import '../../layouts/themes/themeDefs/const_settings.dart';
import 'screen_detailed_charging_plan.dart';
import 'package:loadmore/loadmore.dart';

class TagebuchScreen extends StatefulWidget {
  static const String id = "Tagebuch";

  @override
  _TagebuchScreenState createState() => _TagebuchScreenState();
}

class _TagebuchScreenState extends State<TagebuchScreen> {
  List<Row> eventList = [];

  int flex = 14;
  int firstCol = 3;
  int secCol = 8;
  int count = 0;
  ChargeHistoryService? service;
  bool isFinish = false;

  void updateList(SplayTreeMap<DateTime, List<CalendarEvent>> map) {
    if (map.isEmpty) {
      setState(() {
        this.isFinish = true;
      });
    }
    for (MapEntry<DateTime, List<CalendarEvent>> entry in map.entries) {
      eventList.add(
        buildDayTitleRow(entry.key),
      );

      for (CalendarEvent calendarEvent in entry.value) {
        eventList.add(
          Row(
            children: [
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: flex,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChargingPlanDetailScreen(
                              calendarEvent: calendarEvent,
                              getChargingModeIconData:
                                  getChargingModeIconData)),
                    );
                  },
                  child: Column(
                    children: [
                      buildInformationRow(calendarEvent),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    service = Provider.of<ChargeHistoryService>(super.context, listen: false);
  }

  Row buildSeperatorLine() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 0.5,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  IconData getChargingModeIconData(int chargingMode) {
    if (chargingMode == 0) return Icons.eco;
    if (chargingMode == 1)
      return Icons.auto_fix_high;
    else
      return Icons.fast_forward;
  }

  Padding buildInformationRow(CalendarEvent calendarEvent) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16.0,
        top: 6,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: firstCol,
                child: Row(
                  children: [
                    Icon(
                      getChargingModeIconData(calendarEvent.chargingMode),
                      size: 20,
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: secCol,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('HH:mm').format(calendarEvent.timeStart) +
                            ' Uhr',
                        style: kSettingsWidgetSubtitleTextStyle,
                      ),
                      Text(
                        'Start',
                        style: kSettingsInformationTextStyle,
                      )
                    ],
                  )),
              Expanded(
                  flex: secCol,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        calendarEvent.energyChargedInkWh.toString() + " kWh",
                        style: kSettingsWidgetSubtitleTextStyle,
                      ),
                      Text(
                        'Energie',
                        style: kSettingsInformationTextStyle,
                      )
                    ],
                  )),
              Expanded(
                flex: (5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      NumberFormatters.regEuroFormatter
                          .format(calendarEvent.price),
                      style: kSettingsWidgetSubtitleTextStyle,
                    ),
                    Text(
                      'Kosten',
                      style: kSettingsInformationTextStyle,
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Icon(
                  Icons.chevron_right,
                  size: 25,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row buildDayTitleRow(DateTime date) {
    return Row(
      children: [
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: flex,
          child: Column(
            children: [
              buildSeperatorLine(),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(),
                  ),
                  Expanded(
                      flex: 24,
                      child: Text(
                        DateFormat.MMMMd('de_DE').format(date),
                        style: kSettingsWidgetSubtitleTextStyle,
                      )),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column buildTableColumnHeadings() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 5,
              child: Container(),
            ),
            Expanded(
                flex: secCol,
                child: Text(
                  'STARTZEIT',
                  style: kTagebuchTextStyleSubheader,
                )),
            Expanded(
                flex: secCol,
                child: Text(
                  'GELADENE ENERGIE',
                  style: kTagebuchTextStyleSubheader,
                )),
            Expanded(
                flex: secCol,
                child: Text(
                  'KOSTEN',
                  style: kTagebuchTextStyleSubheader,
                )),
          ],
        ),
        SizedBox(
          height: 6,
        ),
        buildSeperatorLine(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(id: TagebuchScreen.id,
        child: Column(
      children: [
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
                    Text(
                      'Tagebuch',
                      style: kHeaderTextStyle,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
        buildTableColumnHeadings(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: LoadMore(
              isFinish: this.isFinish,
              textBuilder: DefaultLoadMoreTextBuilder.english,
              whenEmptyLoad: true,
              onLoadMore: _loadMore,
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: eventList.length,
                itemBuilder: (context, index) => eventList[index],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Future<bool> _loadMore() async {
    print("onLoadMore");
    count++;
    return service!
        .get(count-1)
        .then((value) => {updateList(value)})
        .then((value) => true).onError((error, stackTrace) => false);
  }

  Future<bool> _refresh() async {
    count = 0;
    isFinish = false;
    eventList.clear();
    return service!
        .get(count)
        .then((value) => {updateList(value)})
        .then((value) => true).onError((error, stackTrace) => false);
  }
}
