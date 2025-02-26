import 'package:json_annotation/json_annotation.dart';



part 'vehicle.g.dart';

@JsonSerializable()
class Vehicle {


   int vehicleId=0;
   String vehicleName;
   int currentStateOfChargeFactor;
   int immediateChargeTargetStateOfChargeFactor;
   int desiredStateOfChargeFactor;
   int maximumPowerInWatts;
  int rangeWhenFullInKiloMeters;
  int batteryCapacityInKiloWattHours;

  Vehicle(
      this.vehicleName,this.currentStateOfChargeFactor, this.immediateChargeTargetStateOfChargeFactor, this.desiredStateOfChargeFactor, this.maximumPowerInWatts, this. rangeWhenFullInKiloMeters, this. batteryCapacityInKiloWattHours) ;

  factory Vehicle.fromJson(Map<String, dynamic> json) => _$VehicleFromJson(json);


  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}
