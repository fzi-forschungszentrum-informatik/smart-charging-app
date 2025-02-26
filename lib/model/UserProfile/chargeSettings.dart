import 'package:json_annotation/json_annotation.dart';

import '../chargingMode.dart';





part 'chargeSettings.g.dart';

@JsonSerializable()
class ChargeSettings {


  int currentStateOfCharge;
  int endStateOfCharge;
  int timeOfCompletion;
  ChargingMode chargeMode;
  ChargeSettings(
    this.currentStateOfCharge, this. endStateOfCharge, this.timeOfCompletion, this.chargeMode) ;

  factory ChargeSettings.fromJson(Map<String, dynamic> json) => _$ChargeSettingsFromJson(json);


  Map<String, dynamic> toJson() => _$ChargeSettingsToJson(this);
}
