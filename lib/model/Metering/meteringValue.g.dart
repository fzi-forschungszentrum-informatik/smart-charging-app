// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meteringValue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeteringValue _$MeteringValueFromJson(Map<String, dynamic> json) =>
    MeteringValue(
      DateTime.parse(json['date'] as String),
      (json['value'] as num).toDouble(),
      json['unit'] as String,
    );

Map<String, dynamic> _$MeteringValueToJson(MeteringValue instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'value': instance.value,
      'unit': instance.unit,
    };
