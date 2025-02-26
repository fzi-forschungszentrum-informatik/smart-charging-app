// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meteringCollection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeteringCollection _$MeteringCollectionFromJson(Map<String, dynamic> json) =>
    MeteringCollection(
      DateTime.parse(json['refreshDate'] as String),
      (json['meteringCollection'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$DeviceTypeEnumMap, k),
            (e as List<dynamic>)
                .map((e) => MeteringValue.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
    );

Map<String, dynamic> _$MeteringCollectionToJson(MeteringCollection instance) =>
    <String, dynamic>{
      'refreshDate': instance.refreshDate.toIso8601String(),
      'meteringCollection': instance.meteringCollection
          .map((k, e) => MapEntry(_$DeviceTypeEnumMap[k]!, e)),
    };

const _$DeviceTypeEnumMap = {
  DeviceType.PV: 'PV',
  DeviceType.EV: 'EV',
  DeviceType.GridConnection: 'GridConnection',
  DeviceType.Household: 'Household',
  DeviceType.Unknown: 'Unknown',
};
