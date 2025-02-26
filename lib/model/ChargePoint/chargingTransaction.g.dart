// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chargingTransaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargingTransaction _$ChargingTransactionFromJson(Map<String, dynamic> json) =>
    ChargingTransaction(
      json['chargePointId'] as int,
      json['transactionId'] as String,
      (json['currentChargingPrice'] as num).toDouble(),
      $enumDecode(_$ChargingModeEnumMap, json['chargeMode']),
    )
      ..currentChargeSettings = json['currentChargeSettings'] == null
          ? null
          : ChargeSettings.fromJson(
              json['currentChargeSettings'] as Map<String, dynamic>)
      ..currentChargingEnergy =
          (json['currentChargingEnergy'] as num).toDouble()
      ..chargingTimeSeries =
          (json['chargingTimeSeries'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(DateTime.parse(k), (e as num).toDouble()),
      );

Map<String, dynamic> _$ChargingTransactionToJson(
        ChargingTransaction instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'currentChargeSettings': instance.currentChargeSettings,
      'currentChargingPrice': instance.currentChargingPrice,
      'currentChargingEnergy': instance.currentChargingEnergy,
      'chargeMode': _$ChargingModeEnumMap[instance.chargeMode]!,
      'chargePointId': instance.chargePointId,
      'chargingTimeSeries': instance.chargingTimeSeries
          ?.map((k, e) => MapEntry(k.toIso8601String(), e)),
    };

const _$ChargingModeEnumMap = {
  ChargingMode.OPTIMAL: 'OPTIMAL',
  ChargingMode.INTELLIGENT: 'INTELLIGENT',
  ChargingMode.FAST: 'FAST',
};
