// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chargeHistoryItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargeHistoryItem _$ChargeHistoryItemFromJson(Map<String, dynamic> json) =>
    ChargeHistoryItem(
      json['transactionId'] as String,
      DateTime.parse(json['chargeTime'] as String),
      (json['chargedEnergy'] as num).toDouble(),
      (json['chargingPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$ChargeHistoryItemToJson(ChargeHistoryItem instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'chargeTime': instance.chargeTime.toIso8601String(),
      'chargedEnergy': instance.chargedEnergy,
      'chargingPrice': instance.chargingPrice,
    };

ChargeHistoryItemList _$ChargeHistoryItemListFromJson(
        Map<String, dynamic> json) =>
    ChargeHistoryItemList(
      (json['chargeHistoryList'] as List<dynamic>)
          .map((e) => ChargeHistoryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChargeHistoryItemListToJson(
        ChargeHistoryItemList instance) =>
    <String, dynamic>{
      'chargeHistoryList': instance.chargeHistoryList,
    };
