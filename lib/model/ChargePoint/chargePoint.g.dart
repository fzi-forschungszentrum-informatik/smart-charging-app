// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chargePoint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargePoint _$ChargePointFromJson(Map<String, dynamic> json) => ChargePoint(
      json['chargePointId'] as int,
      json['name'] as String,
      json['maximumPower'] as int,
    );

Map<String, dynamic> _$ChargePointToJson(ChargePoint instance) =>
    <String, dynamic>{
      'chargePointId': instance.chargePointId,
      'name': instance.name,
      'maximumPower': instance.maximumPower,
    };
