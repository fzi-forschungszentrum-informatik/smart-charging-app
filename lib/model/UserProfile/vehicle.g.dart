// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicle _$VehicleFromJson(Map<String, dynamic> json) => Vehicle(
      json['vehicleName'] as String,
      json['currentStateOfChargeFactor'] as int,
      json['immediateChargeTargetStateOfChargeFactor'] as int,
      json['desiredStateOfChargeFactor'] as int,
      json['maximumPowerInWatts'] as int,
      json['rangeWhenFullInKiloMeters'] as int,
      json['batteryCapacityInKiloWattHours'] as int,
    )..vehicleId = json['vehicleId'] as int;

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      'vehicleId': instance.vehicleId,
      'vehicleName': instance.vehicleName,
      'currentStateOfChargeFactor': instance.currentStateOfChargeFactor,
      'immediateChargeTargetStateOfChargeFactor':
          instance.immediateChargeTargetStateOfChargeFactor,
      'desiredStateOfChargeFactor': instance.desiredStateOfChargeFactor,
      'maximumPowerInWatts': instance.maximumPowerInWatts,
      'rangeWhenFullInKiloMeters': instance.rangeWhenFullInKiloMeters,
      'batteryCapacityInKiloWattHours': instance.batteryCapacityInKiloWattHours,
    };
