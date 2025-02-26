// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meteringChartData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeteringChartData _$MeteringChartDataFromJson(Map<String, dynamic> json) =>
    MeteringChartData(
      json['color'] as int,
      (json['seriesData'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(DateTime.parse(k), (e as num).toDouble()),
      ),
      json['name'] as String,
      json['yAxisName'] as String,
    );

Map<String, dynamic> _$MeteringChartDataToJson(MeteringChartData instance) =>
    <String, dynamic>{
      'color': instance.color,
      'seriesData':
          instance.seriesData.map((k, e) => MapEntry(k.toIso8601String(), e)),
      'name': instance.name,
      'yAxisName': instance.yAxisName,
    };
