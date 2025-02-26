import 'package:json_annotation/json_annotation.dart';
import 'package:fzi_charging_app/model/UserProfile/vehicle.dart';


import '../ChargePoint/chargePoint.dart';
import 'chargeSettings.dart';



part 'userProfile.g.dart';

@JsonSerializable()
class UserProfile {


  String loginName;
  String userName;
  int id;
  List<Vehicle> vehicles;
  List<ChargePoint> chargePoints;
  ChargeSettings chargeSettings;
  Vehicle currentSelectedVehicle;
  ChargePoint currentSelectedChargePoint;


  UserProfile(
      this.loginName, this.userName, this.id, this.vehicles, this.chargePoints, this.chargeSettings, this.currentSelectedChargePoint, this.currentSelectedVehicle) ;

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);


  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
