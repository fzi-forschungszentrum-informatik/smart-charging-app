// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chargePriceForecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargePriceForecast _$ChargePriceForecastFromJson(Map<String, dynamic> json) =>
    ChargePriceForecast(
      (json['priceDictionary'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$ChargingModeEnumMap, k), (e as num).toDouble()),
      ),
      (json['chargingPlanDictionary'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$ChargingModeEnumMap, k),
            (e as Map<String, dynamic>).map(
              (k, e) => MapEntry(DateTime.parse(k), (e as num).toDouble()),
            )),
      ),
      (json['energyDictionary'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$ChargingModeEnumMap, k), (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$ChargePriceForecastToJson(
        ChargePriceForecast instance) =>
    <String, dynamic>{
      'priceDictionary': instance.priceDictionary
          .map((k, e) => MapEntry(_$ChargingModeEnumMap[k]!, e)),
      'energyDictionary': instance.energyDictionary
          .map((k, e) => MapEntry(_$ChargingModeEnumMap[k]!, e)),
      'chargingPlanDictionary': instance.chargingPlanDictionary.map((k, e) =>
          MapEntry(_$ChargingModeEnumMap[k]!,
              e.map((k, e) => MapEntry(k.toIso8601String(), e)))),
    };

const _$ChargingModeEnumMap = {
  ChargingMode.OPTIMAL: 'OPTIMAL',
  ChargingMode.INTELLIGENT: 'INTELLIGENT',
  ChargingMode.FAST: 'FAST',
};
