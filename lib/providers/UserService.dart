

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/UserProfile/chargeSettings.dart';
import '../model/UserProfile/userProfile.dart';
import '../model/UserProfile/vehicle.dart';
import '../repositories/userProfileRepository.dart';

class UserService {
  BuildContext context;
  UserProfileRepository repository;
  UserService(this.context): repository = Provider.of<UserProfileRepository>(context, listen: false );

  Future<UserProfile> getUserProfile(){
    return repository.getUserProfile();
  }

  Future<ChargeSettings> setUserSettings(ChargeSettings update){
    return repository.updateChargeSettings(update);
  }

  Future<void> updateSelectedChargePoint(int chargePointId){
    return repository.updateSelectedChargePoint(chargePointId);
  }

  Future<void> updateSelectedVehicle(int vehicleId){
    return repository.updateSelectedVehicle(vehicleId);
  }
  
  Future<Vehicle> updateVehilce(Vehicle v){
    return repository.updateVehicle(v);
  }
  
  Future<Vehicle> addVehicle(Vehicle v){
    return repository.addVehicle(v);
  }

  Future<void> deleteVehicle(int vehicleId){
    return repository.deleteVehicle(vehicleId);
  }
}