
import 'dart:collection';
import "package:collection/collection.dart";
import 'package:flutter/cupertino.dart';

import '../model/ChargeHistory/chargeHistoryItem.dart';
import '../model/calendar_event.dart';
import '../repositories/chargeHistoryRepository.dart';
import 'package:provider/provider.dart';

class ChargeHistoryService{

   ChargeHistoryRepository chargeHistoryRepository;

  ChargeHistoryService(BuildContext context):
    chargeHistoryRepository = Provider.of<ChargeHistoryRepository>(context, listen: false);


  Future<SplayTreeMap<DateTime, List<CalendarEvent>>> get(int offset){
 return   chargeHistoryRepository.fetchChargeHistoryList(offset).then((value) => convertToCalendarEvents(value));


}

   SplayTreeMap<DateTime, List<CalendarEvent>> convertToCalendarEvents(List<ChargeHistoryItem> list) {

   /*  DateTime.utc(2021, 10, 9, 14, 30): 0.32,
     DateTime.utc(2021, 10, 9, 15, 45): 0.32,
     DateTime.utc(2021, 10, 9, 16, 15): 0.42,
     DateTime.utc(2021, 10, 9, 17, 45): 0.42,
     DateTime.utc(2021, 10, 9, 18, 30): 0.57,
     DateTime.utc(2021, 10, 9, 20, 30): 0.57,
   });*/


   List<CalendarEvent> calendarEventList = [];
   for (ChargeHistoryItem i in list) {
     SplayTreeMap<DateTime, double> stateOfChargeMap = SplayTreeMap();
     stateOfChargeMap[i.chargeTime.add(Duration(hours: -2))] = 12;
     print(i.chargeTime);
     print(i.chargeTime.isUtc);
     double soc = 12;
     Duration endDur = Duration(hours: 4, minutes: 22);
     for(int x = 0; x<17;x++){
       if(x%3==0 || x%6==0) continue;
       soc += 6;
       Duration dur = Duration(minutes: 15*x+15);
       if(dur < endDur)   stateOfChargeMap[i.chargeTime.add(dur).add(Duration(hours: -2)).toUtc()] = soc;
     }

     calendarEventList.add(CalendarEvent(
         timeStart: i.chargeTime,
         timeStop: i.chargeTime.add(endDur),
         price: i.chargingPrice,
         energyChargedInkWh: i.chargedEnergy,
         vehicleSoCInkWhAfterCharge: 89.5,
         chargingMode: 2,
         stateOfChargeMap: stateOfChargeMap));
   }


   SplayTreeMap<DateTime, List<CalendarEvent>> map = SplayTreeMap.from(
       groupBy(
           calendarEventList,
               (CalendarEvent obj) =>
               DateTime(
                 obj.timeStart.year,
                 obj.timeStart.month,
                 obj.timeStart.day,
               )),
           (a, b) => b.compareTo(a));

   for (MapEntry<DateTime, List<CalendarEvent>> entry in map.entries) {
     entry.value.sort((a, b) => b.timeStart.compareTo(a.timeStart));
   }
   return map;
 }

 }