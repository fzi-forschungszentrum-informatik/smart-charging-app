import 'dart:collection';

class CalendarEvent {
  final DateTime timeStart;
  final DateTime timeStop;
  final double energyChargedInkWh;
  final double vehicleSoCInkWhAfterCharge;
  final double price;
  final int chargingMode;
  final SplayTreeMap<DateTime, double> stateOfChargeMap;

  CalendarEvent({
    required this.timeStart,
    required this.timeStop,
    required this.energyChargedInkWh,
    required this.vehicleSoCInkWhAfterCharge,
    required this.price,
    required this.chargingMode,
    required this.stateOfChargeMap
  });
}
