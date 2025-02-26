// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chargeSettings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargeSettings _$ChargeSettingsFromJson(Map<String, dynamic> json) =>
    ChargeSettings(
      json['currentStateOfCharge'] as int,
      json['endStateOfCharge'] as int,
      json['timeOfCompletion'] as int,
      $enumDecode(_$ChargingModeEnumMap, json['chargeMode']),
    );

Map<String, dynamic> _$ChargeSettingsToJson(ChargeSettings instance) =>
    <String, dynamic>{
      'currentStateOfCharge': instance.currentStateOfCharge,
      'endStateOfCharge': instance.endStateOfCharge,
      'timeOfCompletion': instance.timeOfCompletion,
      'chargeMode': _$ChargingModeEnumMap[instance.chargeMode]!,
    };

const _$ChargingModeEnumMap = {
  ChargingMode.OPTIMAL: 'OPTIMAL',
  ChargingMode.INTELLIGENT: 'INTELLIGENT',
  ChargingMode.FAST: 'FAST',
};
