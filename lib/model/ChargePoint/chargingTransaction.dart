/*
 "transactionId": "85e1b438-5c11-46ef-8faa-2a6b64f84714",
  "currentChargeSettings": null,
  "chargeMode": 1,
  "currentChargingPrice": 0,
  "currentChargingEnergy": 0,
  "chargePointId": 1,
  "chargingTimeSeries": null
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:fzi_charging_app/model/UserProfile/chargeSettings.dart';

import '../chargingMode.dart';



part 'chargingTransaction.g.dart';
@JsonSerializable()
class ChargingTransaction {



  String transactionId;
  ChargeSettings? currentChargeSettings;
  double currentChargingPrice = 0;
  double currentChargingEnergy=0;
  ChargingMode chargeMode;
  int chargePointId;
  Map<DateTime,double>? chargingTimeSeries;
  ChargingTransaction(
      this.chargePointId, this.transactionId, this.currentChargingPrice, this.chargeMode) ;

  factory ChargingTransaction.fromJson(Map<String, dynamic> json) => _$ChargingTransactionFromJson(json);

  static List<ChargingTransaction> fromJsonList(List<dynamic> json) {
    return json.map((e) => _$ChargingTransactionFromJson(e)).toList();
  }


  Map<String, dynamic> toJson() => _$ChargingTransactionToJson(this);
}
