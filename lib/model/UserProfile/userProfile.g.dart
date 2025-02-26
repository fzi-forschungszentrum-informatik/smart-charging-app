// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userProfile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      json['loginName'] as String,
      json['userName'] as String,
      json['id'] as int,
      (json['vehicles'] as List<dynamic>)
          .map((e) => Vehicle.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['chargePoints'] as List<dynamic>)
          .map((e) => ChargePoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      ChargeSettings.fromJson(json['chargeSettings'] as Map<String, dynamic>),
      ChargePoint.fromJson(
          json['currentSelectedChargePoint'] as Map<String, dynamic>),
      Vehicle.fromJson(json['currentSelectedVehicle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'loginName': instance.loginName,
      'userName': instance.userName,
      'id': instance.id,
      'vehicles': instance.vehicles,
      'chargePoints': instance.chargePoints,
      'chargeSettings': instance.chargeSettings,
      'currentSelectedVehicle': instance.currentSelectedVehicle,
      'currentSelectedChargePoint': instance.currentSelectedChargePoint,
    };
